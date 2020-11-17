library aqueduct_doc_to_obj;

class DocToObj {
  final Type objectType;
  final Symbol fromJsonMethod;
  final Symbol toJsonMethod;
  const DocToObj(this.objectType,
      [this.fromJsonMethod = #fromJson, this.toJsonMethod = #toJson]);
}
