import 'dart:ui';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lasttransold.g.dart';

// @Entity()
@JsonSerializable()
class Lasttransold {
  int? id;
  String? date;
  int? customer;
  int? amount;
  int? chitiamount;
  int? chiti;
  String? note;
  String? created;
  String? updated;
  int? deleted;
  String? code;
  int? tYpe;
  int? advintmonths;
  int? iscountable;
  int? paymentmode;
  String? pmid;
  int? pdwtm;
  String? interestrate;
  int? ccomm;
  int? ccommpaymentmode;
  int? suriccomm;
  int? sowji;
  int? suri;
  int? fullandevi;
  int? reverse;
  int? revcash;
  int? status;
  int? irregular;
  String? firstname;
  String? lastname;
  String? phoneno;
  int? hami;
  int? ishami;
  int? chitfund;
  int? aadhar;
  int? passbook;
  int? debitcard;
  int? cheque;
  int? pnote;
  int? greensheet;
  int? forint;
  int? intrate;
  String? rcvddate;
  int? asalu;
  int? asaluid;
  int? colid;
  String? customername;
  int? rcvdid;

  Lasttransold({
    this.id,
    this.date,
    this.customer,
    this.amount,
    this.chitiamount,
    this.chiti,
    this.note,
    this.created,
    this.updated,
    this.deleted,
    this.code,
    this.tYpe,
    this.advintmonths,
    this.iscountable,
    this.paymentmode,
    this.pmid,
    this.pdwtm,
    this.interestrate,
    this.ccomm,
    this.ccommpaymentmode,
    this.suriccomm,
    this.sowji,
    this.suri,
    this.fullandevi,
    this.reverse,
    this.revcash,
    this.status,
    this.irregular,
    this.firstname,
    this.lastname,
    this.phoneno,
    this.hami,
    this.ishami,
    this.chitfund,
    this.aadhar,
    this.passbook,
    this.debitcard,
    this.cheque,
    this.pnote,
    this.greensheet,
    this.forint,
    this.intrate,
    this.rcvddate,
    this.asalu,
    this.asaluid,
    this.colid,
    this.customername,
    this.rcvdid,
  });

  factory Lasttransold.fromJson(Map<String, dynamic> json) =>
      _$LasttransoldFromJson(json);
  Map<String, dynamic> toJson() => _$LasttransoldToJson(this);
}

// class CustomerJsonConverter
//     implements JsonConverter<Latestnotes, Map<String, dynamic>> {
//   const CustomerJsonConverter();
//   @override
//   Latestnotes fromJson(Map<String, dynamic> json) {
//     return Latestnotes(
//         customername: json["customername"],
//         regularamt: json["regularamt"],
//         perday: json["perday"],
//         notes: json["notes"]);
//   }

//   @override
//   Map<String, dynamic> toJson(Latestnotes object) {
//     return {
//       "customername": object.customername,
//       "regularamt": object.regularamt,
//       "perday": object.perday,
//       "notes": object.notes
//     };
//   }
// }
  // )