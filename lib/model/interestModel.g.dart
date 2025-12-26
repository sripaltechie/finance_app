// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interestModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterestModel _$InterestModelFromJson(Map<String, dynamic> json) =>
    InterestModel(
      id: json['id'] as int?,
      date: json['date'] as String?,
      customer: json['customer'] as int?,
      credit: json['credit'] as int?,
      debit: json['debit'] as int?,
      paymentmode: json['paymentmode'] as int?,
      pmid: json['pmid'] as String?,
      note: json['note'] as String?,
      note1: json['note1'] as String?,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
      deleted: json['deleted'] as int?,
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
      forint: json['forint'] as int?,
      intrate: json['intrate'].toString() as String?,
      modename: json['modename'] as String?,
      opbal: json['opbal'] as int?,
      customername: json['customername'] as String?,
      paymentmodename: json['paymentmodename'] as String?,
    );

Map<String, dynamic> _$InterestModelToJson(InterestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'customer': instance.customer,
      'credit': instance.credit,
      'debit': instance.debit,
      'paymentmode': instance.paymentmode,
      'pmid': instance.pmid,
      'note': instance.note,
      'note1': instance.note1,
      'created': instance.created,
      'updated': instance.updated,
      'deleted': instance.deleted,
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
      'forint': instance.forint,
      'intrate': instance.intrate,
      'modename': instance.modename,
      'opbal': instance.opbal,
      'customername': instance.customername,
      'paymentmodename': instance.paymentmodename,
    };
