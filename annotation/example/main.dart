import 'package:aqueduct/aqueduct.dart';
import 'package:aqueduct_doc_to_obj/aqueduct_doc_to_obj.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'main.g.dart';

@JsonSerializable()
class Person {
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  Person({this.firstName, this.lastName, this.dateOfBirth});
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

class Employee {
  @DocToObj(Person)
  Document _person;
  Person _personTmp;
}

void main() {
  final e = Employee();
  e.person = Person(
      firstName: 'Максим', lastName: 'Максимов', dateOfBirth: DateTime.now());

  print('FIRST NAME: ${e.person.firstName}');
  print('INNER JSON:\n${json.encode(e._person.data)}');
}
