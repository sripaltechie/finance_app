// import 'dart:ui';
// import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

import 'asalu.dart';

part 'drcrModel.g.dart';

@JsonSerializable()
class DrcrModel {
  int? id;
  String? date;
  int? customer;
  String? debit;
  String? credit;
  int? forint;
  int? paymentmode;
  String? pmid;
  int? creditexp;
  int? crid;
  int? chitfundid;
  int? showdaybook;
  String? note;
  String? note1;
  String? created;
  String? updated;
  int? deleted;
  dynamic firstname;
  dynamic lastname;
  dynamic phoneno;
  dynamic hami;
  dynamic ishami;
  dynamic chitfund;
  dynamic aadhar;
  dynamic passbook;
  dynamic debitcard;
  dynamic cheque;
  dynamic pnote;
  dynamic greensheet;
  dynamic intrate;
  String? modename;
  int? opbal;
  String? customername;
  dynamic haminame;
  String? paymentmodename;
  List<PmtransModel>? pmtrans;

  DrcrModel({
    this.id,
    this.date,
    this.customer,
    this.debit,
    this.credit,
    this.forint,
    this.paymentmode,
    this.pmid,
    this.creditexp,
    this.crid,
    this.chitfundid,
    this.showdaybook,
    this.note,
    this.note1,
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
    this.intrate,
    this.modename,
    this.opbal,
    this.customername,
    this.haminame,
    this.paymentmodename,
    this.pmtrans,
  });

  factory DrcrModel.fromJson(Map<String, dynamic> json) =>
      _$DrcrModelFromJson(json);

  Map<String, dynamic> toJson() => _$DrcrModelToJson(this);
}
