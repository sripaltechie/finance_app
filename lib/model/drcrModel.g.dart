// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drcrModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrcrModel _$DrcrModelFromJson(Map<String, dynamic> json) => DrcrModel(
      id: json['id'] as int?,
      date: json['date'] as String?,
      customer: json['customer'] as int?,
      debit: json['debit'] as String?,
      credit: json['credit'] as String?,
      forint: json['forint'] as int?,
      paymentmode: json['paymentmode'] as int?,
      pmid: json['pmid'] as String?,
      creditexp: json['creditexp'] as int?,
      crid: json['crid'] as int?,
      chitfundid: json['chitfundid'] as int?,
      showdaybook: json['showdaybook'] as int?,
      note: json['note'] as String?,
      note1: json['note1'] as String?,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
      deleted: json['deleted'] as int?,
      firstname: json['firstname'],
      lastname: json['lastname'],
      phoneno: json['phoneno'],
      hami: json['hami'],
      ishami: json['ishami'],
      chitfund: json['chitfund'],
      aadhar: json['aadhar'],
      passbook: json['passbook'],
      debitcard: json['debitcard'],
      cheque: json['cheque'],
      pnote: json['pnote'],
      greensheet: json['greensheet'],
      intrate: json['intrate'],
      modename: json['modename'] as String?,
      opbal: json['opbal'] as int?,
      customername: json['customername'] as String?,
      haminame: json['haminame'],
      paymentmodename: json['paymentmodename'] as String?,
      // pmtrans(json['pmtrans'] != null)?
      pmtrans: (json['pmtrans'] != "")
          ? (json['pmtrans'] as List<dynamic>?)
              ?.map((e) => PmtransModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );

Map<String, dynamic> _$DrcrModelToJson(DrcrModel instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'customer': instance.customer,
      'debit': instance.debit,
      'credit': instance.credit,
      'forint': instance.forint,
      'paymentmode': instance.paymentmode,
      'pmid': instance.pmid,
      'creditexp': instance.creditexp,
      'crid': instance.crid,
      'chitfundid': instance.chitfundid,
      'showdaybook': instance.showdaybook,
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
      'intrate': instance.intrate,
      'modename': instance.modename,
      'opbal': instance.opbal,
      'customername': instance.customername,
      'haminame': instance.haminame,
      'paymentmodename': instance.paymentmodename,
      'pmtrans': instance.pmtrans,
    };
