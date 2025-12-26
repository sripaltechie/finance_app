import 'dart:ui';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'receivedList.g.dart';

@JsonSerializable()
//(converters: [MyJsonConverter()])
class ReceivedList {
  // @MyJsonConverter()
  late int? id;
  late int? customer;
  late int? amount;
  late String? rcvddate;
  late int? asalu;
  late int? asaluid;
  late int? chiti;
  late int? colid;
  late int? paymentmode;
  late String? pmid;
  late String? note;
  late String? created;
  late String? updated;
  late int? deleted;
  late String? firstname;
  late String? lastname;
  late String? phoneno;
  late int? hami;
  late int? ishami;
  late int? chitfund;
  late int? aadhar;
  late int? passbook;
  late int? debitcard;
  late int? cheque;
  late int? pnote;
  late int? greensheet;
  late int? forint;
  late int? intrate;
  late String? date;
  late String? notes;
  late int? sowji;
  late int? suri;
  late int? fullandevi;
  late int? received;
  late int? reverseid;
  late int? receivedfrom;
  late String? code;
  late int? tYpe;
  late int? advintmonths;
  late int? iscountable;
  late int? pdwtm;
  late String? interestrate;
  late int? ccomm;
  late int? ccommpaymentmode;
  late int? suriccomm;
  late int? reverse;
  late int? revcash;
  late int? status;
  late int? irregular;
  late int? chitiamount;
  late String? modename;
  late int? opbal;
  late String? customername;
  late String? paymentmodename;
  late int? colamt;
  late int? sowjicomm;
  late int? suricomm;
  late int? fullandevicomm;
  late int? asaluchiti;
  late String? coldate;

  ReceivedList({
    this.id,
    this.customer,
    this.amount,
    this.rcvddate,
    this.asalu,
    this.asaluid,
    this.chiti,
    this.colid,
    this.paymentmode,
    this.pmid,
    this.note,
    this.created,
    this.updated,
    this.deleted,
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
    this.date,
    this.notes,
    this.sowji,
    this.suri,
    this.fullandevi,
    this.received,
    this.reverseid,
    this.receivedfrom,
    this.code,
    this.tYpe,
    this.advintmonths,
    this.iscountable,
    this.pdwtm,
    this.interestrate,
    this.ccomm,
    this.ccommpaymentmode,
    this.suriccomm,
    this.reverse,
    this.revcash,
    this.status,
    this.irregular,
    this.chitiamount,
    this.modename,
    this.opbal,
    this.customername,
    this.paymentmodename,
    this.colamt,
    this.sowjicomm,
    this.suricomm,
    this.fullandevicomm,
    this.asaluchiti,
    this.coldate,
  });

  factory ReceivedList.fromJson(Map<String, dynamic> json) =>
      _$ReceivedListFromJson(json);

  // get date => null;
  Map<String, dynamic> toJson() => _$ReceivedListToJson(this);
}
