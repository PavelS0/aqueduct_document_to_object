import 'package:aqueduct_doc_to_obj/aqueduct_doc_to_obj.dart';
import 'package:test/test.dart';

class TestObj {}

void main() {
  group('annotation tests', () {
    test('symbol saved', () {
      final annotation = DocToObj(TestObj);
      expect(annotation.objectType, TestObj);
    });
  });
}
