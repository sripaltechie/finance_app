// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) => SessionModel(
      uid: json['uid'] as String?,
      api_key: json['api_key'] as String?,
      name: json['name'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      firm: json['firm'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      branch: json['branch'] as String?,
      rolename: json['rolename'] as String?,
    );

Map<String, dynamic> _$SessionModelToJson(SessionModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'api_key': instance.api_key,
      'name': instance.name,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'firm': instance.firm,
      'phone': instance.phone,
      'role': instance.role,
      'branch': instance.branch,
      'rolename': instance.rolename,
    };
