This library allows you to make an annotation for Document fields from the aqueduct library, 
which allows you to automatically generate getters and setters for this object, which is accepted or returned by any JsonSerializable object.

## Installing 

```yaml
dependencies:
  aqueduct_doc_to_obj: ^0.0.1

dev_dependencies:
  aqueduct_doc_to_obj_generator: ^0.0.1
```

## Setting

The Document field must be annotated with @DocToObj()

and also create a second field, specifying the required JsonSerializible type, or List of these types, it must be named in the same way as the Document field with the addition to the end of Tmp, for example:

```dart
  @DocToObj()
  Document _person;
  Person _personTmp;
```

```dart
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
  @DocToObj()
  Document _person;
  Person _personTmp;
}

void main() {
  final e = Employee();
  e.person = Person(
      firstName: 'Richard', lastName: 'Stanley', dateOfBirth: DateTime.now());

  print('FIRST NAME: ${e.person.firstName}');
  print('INNER JSON:\n${json.encode(e._person.data)}');
}

```
## Building
Run `pub run build_runner build` in the command line. 
The getters and setter will automatically be generated, so you can do stuff like this:

```dart
print(e.person.lastName);
```
