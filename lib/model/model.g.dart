// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Latestnotes _$LatestnotesFromJson(Map<String, dynamic> json) => Latestnotes(
      customername: json['customername'] as String?,
      haminame: json['haminame'] as String?,
      customer: json['customer'] as int?,
      id: json['id'] as int?,
      regularamt: json['regularamt'] as String?,
      irregular: json['irregular'] as int?,
      lasttrans: json['lasttrans'] as List<dynamic>?,
      perday: json['perday'] as int?,
      remainingasalu: json['remainingasalu'] as int?,
      remainingdays: json['remainingdays'] as int?,
      notes: (json['notes'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LatestnotesToJson(Latestnotes instance) =>
    <String, dynamic>{
      'customername': instance.customername,
      'haminame': instance.haminame,
      'customer': instance.customer,
      'id': instance.id,
      'regularamt': instance.regularamt,
      'irregular': instance.irregular,
      'lasttrans': instance.lasttrans,
      'perday': instance.perday,
      'remainingasalu': instance.remainingasalu,
      'remainingdays': instance.remainingdays,
      'notes': instance.notes,
    };
