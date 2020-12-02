import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class CodeGenerationError extends Error {
  CodeGenerationError(this.message);

  final String message;

  String toString() => message;
}

abstract class GeneratorForAnnotatedField<AnnotationType> extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final generated = <String>[];
    for (final c in library.classes) {
      for (final field in c.fields) {
        final annotations =
            TypeChecker.fromRuntime(AnnotationType).annotationsOf(field);
        if (annotations.isNotEmpty) {
          generated.add(generateForField(
            field,
            ConstantReader(annotations.first),
          ));
        }
      }
    }
    return generated.join('\n\n');
  }

  String generateForField(FieldElement field, ConstantReader annotation);
}
