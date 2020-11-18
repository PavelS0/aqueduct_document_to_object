// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// DocToObjGenerator
// **************************************************************************

extension PersonDocToParam on Person {
  List<Param> get param {
    if (_paramObj == null) {
      if (_param == null) {
        return null;
      } else {
        final l = _param.data as List;
        return _paramObj =
            l.map((e) => Param.fromJson(e as Map<String, dynamic>)).toList();
      }
    } else {
      return _paramObj;
    }
  }

  set param(List<Param> s) {
    final l = s.map((e) => e.toJson()).toList();
    _paramObj = s;
    _param = Document(l);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Param _$ParamFromJson(Map<String, dynamic> json) {
  return Param(
    name: json['name'] as String,
    value: json['value'] as String,
    updateDate: json['updateDate'] == null
        ? null
        : DateTime.parse(json['updateDate'] as String),
  );
}

Map<String, dynamic> _$ParamToJson(Param instance) => <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'updateDate': instance.updateDate?.toIso8601String(),
    };
