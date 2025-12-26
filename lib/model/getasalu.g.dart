// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getasalu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAsalu _$GetAsaluFromJson(Map<String, dynamic> json) => GetAsalu(
      id: json['id'] as int?,
      date: json['date'] as String?,
      customer: json['customer'] as int?,
      amount: json['amount'] as int?,
      chitiamount: json['chitiamount'] as int?,
      chiti: json['chiti'] as int?,
      customername: json['customername'] as String?,
      note: json['note'] as String?,
      paymentmode: json['paymentmode'] as int?,
      paymentmodename: json['paymentmodename'] as String?,
    );

Map<String, dynamic> _$GetAsaluToJson(GetAsalu instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'customer': instance.customer,
      'amount': instance.amount,
      'chitiamount': instance.chitiamount,
      'chiti': instance.chiti,
      'customername': instance.customername,
      'note': instance.note,
      'paymentmode': instance.paymentmode,
      'paymentmodename': instance.paymentmodename,
    };
