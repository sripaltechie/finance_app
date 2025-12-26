// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customerlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomersList _$CustomersListFromJson(Map<String, dynamic> json) =>
    CustomersList(
      id: json['id'] as int?,
      SNO: json['SNO'] as int?,
      Firstname: json['Firstname'] as String?,
      LastName: json['LastName'] as String?,
      PhoneNo: json['PhoneNo'] as String?,
      hami: json['hami'] as int?,
      ishami: json['ishami'] as int?,
      chitfund: json['chitfund'] as int?,
      HamiFirstName: json['HamiFirstName'] as String?,
      HamiLastName: json['HamiLastName'] as String?,
      HamiPhoneNo: json['HamiPhoneNo'] as String?,
      aadhar: json['aadhar'] as int?,
      passbook: json['passbook'] as int?,
      debitcard: json['debitcard'] as int?,
      cheque: json['cheque'] as int?,
      pnote: json['pnote'] as int?,
      greensheet: json['greensheet'] as int?,
      note: json['note'] as String?,
      forint: json['forint'] as int?,
      intrate: json['intrate'].toString() as String?,
      proofs: json['proofs'] as String?,
    );

Map<String, dynamic> _$CustomersListToJson(CustomersList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'SNO': instance.SNO,
      'Firstname': instance.Firstname,
      'LastName': instance.LastName,
      'PhoneNo': instance.PhoneNo,
      'hami': instance.hami,
      'ishami': instance.ishami,
      'chitfund': instance.chitfund,
      'HamiFirstName': instance.HamiFirstName,
      'HamiLastName': instance.HamiLastName,
      'HamiPhoneNo': instance.HamiPhoneNo,
      'aadhar': instance.aadhar,
      'passbook': instance.passbook,
      'debitcard': instance.debitcard,
      'cheque': instance.cheque,
      'pnote': instance.pnote,
      'greensheet': instance.greensheet,
      'note': instance.note,
      'forint': instance.forint,
      'intrate': instance.intrate,
      'proofs': instance.proofs,
    };
