// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// DocToObjGenerator
// **************************************************************************

extension PersonDocToParam on Person {
  List<Param>? get param {
    if (_paramObj == null) {
      final docField = _param;
      if (docField != null) {
        final l = docField.data as List;
        return _paramObj =
            l.map((e) => Param.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        return null;
      }
    } else {
      return _paramObj;
    }
  }

  set param(List<Param>? s) {
    if (s != null) {
      final l = s.map((e) => e.toJson()).toList();
      _paramObj = s;
      _param = Document(l);
    } else {
      _paramObj = null;
      _param = null;
    }
  }

  void readParamFromMap(Map<String, dynamic> object) {
    if (object.containsKey('param') && object['param'] != null) {
      var l = object['param'] as List;
      final obj =
          l.map((e) => Param.fromJson(e as Map<String, dynamic>)).toList();
      l = obj.map((e) => e.toJson()).toList();
      _param = Document(l);
      _paramObj = obj;
    }
  }

  void paramToMap(Map<String, dynamic> map) {
    final docField = _param;
    if (docField != null) {
      map['param'] = docField.data;
    }
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Param _$ParamFromJson(Map<String, dynamic> json) {
  return Param(
    name: json['name'] as String?,
    value: json['value'] as String?,
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
