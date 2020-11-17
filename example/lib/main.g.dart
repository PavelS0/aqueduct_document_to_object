// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// DocToObjGenerator
// **************************************************************************

extension EmployeeDocToPerson on Employee {
  Person get person {
    if (_personTmp == null) {
      if (_person == null) {
        return null;
      } else {
        return Person.fromJson(_person.data as Map<String, dynamic>);
      }
    } else {
      return _personTmp;
    }
  }

  set person(Person s) {
    _personTmp = s;
    _person = Document(s.toJson());
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    dateOfBirth: json['dateOfBirth'] == null
        ? null
        : DateTime.parse(json['dateOfBirth'] as String),
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
    };
