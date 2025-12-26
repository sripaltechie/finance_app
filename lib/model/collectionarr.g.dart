// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collectionarr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collectionarr _$CollectionarrFromJson(Map<String, dynamic> json) =>
    Collectionarr(
      // date: json['date'] as String?,

      colid: json['colid'] as String?,
      colamt: json['colamt'] as String?,
      paymentmode: json['paymentmode'] as String?,
    );

Map<String, dynamic> _$CollectionarrToJson(Collectionarr instance) =>
    <String, dynamic>{
      'colid': instance.colid,
      'colamt': instance.colamt,
      'paymentmode': instance.paymentmode,
    };
