// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rcvdCollection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RcvdCollection _$RcvdCollectionFromJson(Map<String, dynamic> json) =>
    RcvdCollection(
      rcvddate: json['rcvddate'] as String?,
      userrcvddate: json['userrcvddate'] as String?,
      customer: json['customer'] as String?,
      customername: json['customername'] as String?,
      chiti: json['chiti'] as String?,
      collectionarr: (json['collectionarr'] as List<dynamic>?)
          ?.map((e) => Collectionarr.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentmode: json['paymentmode'] as String?,
      pmtrans: json['pmtrans'] as List<dynamic>?,
      note: json['note'] as String?,
      note1: json['note1'] as String?,
    );

Map<String, dynamic> _$RcvdCollectionToJson(RcvdCollection instance) =>
    <String, dynamic>{
      'rcvddate': instance.rcvddate,
      'userrcvddate': instance.userrcvddate,
      'customer': instance.customer,
      'customername': instance.customername,
      'chiti': instance.chiti,
      'collectionarr': instance.collectionarr,
      'paymentmode': instance.paymentmode,
      'pmtrans': instance.pmtrans,
      'note': instance.note,
      'note1': instance.note1,
    };
