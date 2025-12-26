// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daybookModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DaybookModel _$DaybookModelFromJson(Map<String, dynamic> json) => DaybookModel(
      creditors: json['creditors'] == null
          ? null
          : CreditorsModel.fromJson(json['creditors'] as Map<String, dynamic>),
      debitors: json['debitors'] == null
          ? null
          : CreditorsModel.fromJson(json['debitors'] as Map<String, dynamic>),
      opbal: (json['opbal'] as List<dynamic>?)
          ?.map((e) =>
              DaybookPaymentmodeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      transttl: (json['transttl'] as List<dynamic>?)
          ?.map((e) =>
              DaybookPaymentmodeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      closingbal: (json['closingbal'] as List<dynamic>?)
          ?.map((e) =>
              DaybookPaymentmodeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DaybookModelToJson(DaybookModel instance) =>
    <String, dynamic>{
      'creditors': instance.creditors,
      'debitors': instance.debitors,
      'opbal': instance.opbal,
      'transttl': instance.transttl,
      'closingbal': instance.closingbal,
    };
