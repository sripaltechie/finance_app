// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dispModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Disp _$DispFromJson(Map<String, dynamic> json) => Disp(
      rcvdamt: json['rcvdamt'] as int?,
      collection: json['collection'] as int?,
      drcr: json['drcr'] as int?,
      cftrans: json['cftrans'] as int?,
      ccomm: json['ccomm'] as int?,
      interest: json['interest'] as int?,
      chiti: json['chiti'] as int?,
    );

Map<String, dynamic> _$DispToJson(Disp instance) => <String, dynamic>{
      'rcvdamt': instance.rcvdamt,
      'collection': instance.collection,
      'drcr': instance.drcr,
      'cftrans': instance.cftrans,
      'ccomm': instance.ccomm,
      'interest': instance.interest,
      'chiti': instance.chiti,
    };
