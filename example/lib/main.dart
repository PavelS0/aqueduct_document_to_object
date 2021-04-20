import 'package:aqueduct/aqueduct.dart';
import 'package:aqueduct_doc_to_obj/aqueduct_doc_to_obj.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'main.g.dart';

@JsonSerializable()
class Param {
  final String? name;
  final String? value;
  final DateTime? updateDate;
  Param({this.name, this.value, this.updateDate});
  factory Param.fromJson(Map<String, dynamic> json) => _$ParamFromJson(json);
  Map<String, dynamic> toJson() => _$ParamToJson(this);
}

class Person extends _Person {
  @DocToObj()
  List<Param>? _paramObj;
}

class _Person {
  @Column(primaryKey: true)
  String? id;
  @Column(defaultValue: "''")
  String? name;
  DateTime? birthDate;
  Document? _param;
}

void main() {
  final e = Person();
  e.param = [Param(name: "test", value: "test", updateDate: DateTime.now())];

  print('internal data \n${json.encode(e._param?.data)}');
  print('Person field data: \n Name ${e.param?.first.name}');
}
