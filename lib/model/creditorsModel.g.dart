// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creditorsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditorsModel _$CreditorsModelFromJson(Map<String, dynamic> json) =>
    CreditorsModel(
      customers: (json['customers'] as List<dynamic>?)
          ?.map((e) => CustomersModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int?,
    );

Map<String, dynamic> _$CreditorsModelToJson(CreditorsModel instance) =>
    <String, dynamic>{
      'customers': instance.customers,
      'total': instance.total,
    };
