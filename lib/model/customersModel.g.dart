// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customersModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomersModel _$CustomersModelFromJson(Map<String, dynamic> json) =>
    CustomersModel(
      id: json['id'] as int?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      phoneno: json['phoneno'] as String?,
      hami: json['hami'] as int?,
      ishami: json['ishami'] as int?,
      chitfund: json['chitfund'] as int?,
      aadhar: json['aadhar'] as int?,
      passbook: json['passbook'] as int?,
      debitcard: json['debitcard'] as int?,
      cheque: json['cheque'] as int?,
      pnote: json['pnote'] as int?,
      greensheet: json['greensheet'] as int?,
      note: json['note'] as String?,
      forint: json['forint'] as int?,
      intrate: json['intrate'].toDouble() as double?,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
      deleted: json['deleted'] as int?,
      hamifirstname: json['hamifirstname'] as String?,
      hamilastname: json['hamilastname'] as String?,
      hamiphoneno: json['hamiphoneno'] as String?,
      disp: json['disp'] == null
          ? null
          : Disp.fromJson(json['disp'] as Map<String, dynamic>),
      total: json['total'] as int?,
      rcvdamtlist: (json['rcvdamtlist'] as List<dynamic>?)
          ?.map((e) => ReceivedList.fromJson(e as Map<String, dynamic>))
          .toList(),
      collectionlist: json['collectionlist'] as List<dynamic>?,
      drcrlist: (json['drcrlist'] as List<dynamic>?)
          ?.map((e) => DrcrModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cftranslist: (json['cftranslist'] as List<dynamic>?)
          ?.map((e) => CftransModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      ccommlist: (json['ccommlist'] as List<dynamic>?)
          ?.map((e) => CcommModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      interestlist: (json['interestlist'] as List<dynamic>?)
          ?.map((e) => InterestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      chitilist: (json['chitilist'] as List<dynamic>?)
          ?.map((e) => ChitiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomersModelToJson(CustomersModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'phoneno': instance.phoneno,
      'hami': instance.hami,
      'ishami': instance.ishami,
      'chitfund': instance.chitfund,
      'aadhar': instance.aadhar,
      'passbook': instance.passbook,
      'debitcard': instance.debitcard,
      'cheque': instance.cheque,
      'pnote': instance.pnote,
      'greensheet': instance.greensheet,
      'note': instance.note,
      'forint': instance.forint,
      'intrate': instance.intrate,
      'created': instance.created,
      'updated': instance.updated,
      'deleted': instance.deleted,
      'hamifirstname': instance.hamifirstname,
      'hamilastname': instance.hamilastname,
      'hamiphoneno': instance.hamiphoneno,
      'disp': instance.disp,
      'total': instance.total,
      'rcvdamtlist': instance.rcvdamtlist,
      'collectionlist': instance.collectionlist,
      'drcrlist': instance.drcrlist,
      'cftranslist': instance.cftranslist,
      'ccommlist': instance.ccommlist,
      'interestlist': instance.interestlist,
      'chitilist': instance.chitilist,
    };
