library aqueduct_doc_to_obj;

class DocToObj {
  final Symbol fromJsonMethod;
  final Symbol toJsonMethod;
  final Symbol documentField;
  final Symbol getSetField;
  const DocToObj(
      {this.fromJsonMethod = #fromJson,
      this.toJsonMethod = #toJson,
      this.documentField = Symbol.empty,
      this.getSetField = Symbol.empty});
}
