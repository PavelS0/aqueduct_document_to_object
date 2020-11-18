library aqueduct_doc_to_obj_generator;

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:aqueduct_doc_to_obj_generator/base.dart';
import 'package:build/build.dart';
import 'package:aqueduct_doc_to_obj/aqueduct_doc_to_obj.dart';
import 'package:source_gen/source_gen.dart';

/*
    EXAMPLE FOR GENERATED CODE

    List<ElementScore> _scr;

    List<ElementScore> get scores {
      if (_scr == null) {
        if (_scores == null) {
          return null;
        } else {
          final l = _scores.data as List;
          return _scr = l
              .map((e) => ElementScore.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      } else {
        return _scr;
      }
    }

    set scores(List<ElementScore> s) {
      final l = s.map((e) => e.toJson()).toList();
      _scr = s;
      _scores = Document(l);
    }
*/

Builder generateDocToObj(BuilderOptions options) =>
    SharedPartBuilder([DocToObjGenerator()], 'doc_to_obj');

class FieldVisitor extends SimpleElementVisitor {
  FieldVisitor(this.target);
  final String target;
  DartType type;

  @override
  dynamic visitFieldElement(FieldElement element) {
    if (element.name == target) {
      type = element.type;
    }
  }
}

class _TypeDef {
  final String type;
  final String singleType;
  final bool isList;
  _TypeDef(this.type, this.singleType, this.isList);
}

class DocToObjGenerator extends GeneratorForAnnotatedField<DocToObj> {
  static const objPostfix = 'Obj';
  static final listRegExp = RegExp(r'^List<(.*)>');

  String getDocumentField(String fieldName, ConstantReader annotation) {
    final tmp = annotation.read('documentField').symbolValue;
    if (tmp == Symbol.empty) {
      final l = fieldName.length;
      // Remove Obj Postifx
      return fieldName.substring(0, l - objPostfix.length);
    } else {
      return tmp.toString();
    }
  }

  String getGetSetField(String variable, ConstantReader annotation) {
    final tmp = annotation.read('getSetField').symbolValue;
    if (tmp == Symbol.empty) {
      // Remove _ at begginning
      return variable.substring(1);
    } else {
      return tmp.toString();
    }
  }

  _TypeDef getTypeDef(String typeName) {
    final listMatch = listRegExp.firstMatch(typeName);
    final isList = listMatch != null;
    final singleType = isList ? listMatch.group(1) : typeName;
    return _TypeDef(typeName, singleType, isList);
  }

  @override
  generateForField(FieldElement fieldElement, ConstantReader annotation) {
    final fieldName = fieldElement.name;
    final className = fieldElement.enclosingElement.name;
    final fieldType = fieldElement.type;

    final toJsonMethod =
        annotation.read('toJsonMethod').objectValue.toSymbolValue();
    final fromJsonMethod =
        annotation.read('fromJsonMethod').objectValue.toSymbolValue();

    assert(fieldName != null);
    assert(className != null);

    final documentField = getDocumentField(fieldName, annotation);
    final getSetField = getGetSetField(documentField, annotation);
    final typeDef =
        getTypeDef(fieldType.getDisplayString(withNullability: false));
    final field = typeDef.type;
    final singleType = typeDef.singleType;

    final b = StringBuffer();
    b.write('''
    extension ${className}DocTo${singleType} on $className {
      $field get $getSetField {
        if ($fieldName == null) {
          if ($documentField == null) {
            return null;
          } else {
    ''');
    if (typeDef.isList) {
      b.write('''
          final l = $documentField.data as List;
          return $fieldName = l
            .map((e) => $singleType.$fromJsonMethod(e as Map<String, dynamic>))
              .toList();
      ''');
    } else {
      b.write('''
          return $singleType.$fromJsonMethod($documentField.data as Map<String, dynamic>);
      ''');
    }
    b.write('''
          }
        } else {
          return $fieldName;
        }
      }
      set $getSetField ($field s) {''');

    if (typeDef.isList) {
      b.write('''
        final l = s.map((e) => e.$toJsonMethod()).toList();
        $fieldName = s;
        $documentField = Document(l);
      ''');
    } else {
      b.write('''
        $fieldName = s;
        $documentField = Document(s.$toJsonMethod());
      ''');
    }
    b.write('''
      }
    }
    ''');
    return b.toString();
  }
}
