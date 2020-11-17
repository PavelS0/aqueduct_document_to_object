library aqueduct_doc_to_obj_generator;

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:aqueduct/aqueduct.dart';
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

class DocToObjGenerator extends GeneratorForAnnotatedField<DocToObj> {
  @override
  generateForField(FieldElement field, ConstantReader annotation) {
    final String fieldName = field.name;
    final String className = field.enclosingElement.name;

    assert(fieldName != null);
    assert(className != null);
    assert(field.type == Document);

    final tmpName = '${fieldName}Tmp';

    final visitor = FieldVisitor(tmpName);
    field.enclosingElement.visitChildren(visitor);
    final typeName = visitor.type.getDisplayString(withNullability: false);
    final getSetName = fieldName.substring(1);

    final listRegExp = RegExp(r'^List<(.*)>');
    final listMatch = listRegExp.firstMatch(typeName);
    final isList = listMatch != null;
    final singleType = isList ? listMatch.group(1) : typeName;

    final b = StringBuffer();
    b.write('''
    extension ${className}DocTo${singleType} on $className {
      $typeName get $getSetName {
        if ($tmpName == null) {
          if ($fieldName == null) {
            return null;
          } else {
    ''');
    if (isList) {
      b.write('''
          final l = $fieldName.data as List;
          return $tmpName = l
            .map((e) => $singleType.fromJson(e as Map<String, dynamic>))
              .toList();
      ''');
    } else {
      b.write('''
          return $singleType.fromJson($fieldName.data as Map<String, dynamic>);
      ''');
    }
    b.write('''
          }
        } else {
          return $tmpName;
        }
      }
      set $getSetName ($typeName s) {''');

    if (isList) {
      b.write('''
        final l = s.map((e) => e.toJson()).toList();
        $tmpName = s;
        $fieldName = Document(l);
      ''');
    } else {
      b.write('''
        $tmpName = s;
        $fieldName = Document(s.toJson());
      ''');
    }
    b.write('''
      }
    }
    ''');
    return b.toString();
  }
}
