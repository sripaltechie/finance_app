// import 'dart:ui';
// import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'cftransmodel.g.dart';

@JsonSerializable()
class CftransModel {
  late int? id;
  late String? date;
  late int? chiti;
  late int? paata;
  late int? customer;
  late int? debit;
  late int? credit;
  late int? paymentmode;
  late String? pmid;
  late String? note;
  late int? cusno;
  late String? fname;
  late String? lname;
  late String? phone;
  late int? first;
  late int? firstid;
  late int? maincus;
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
  late String? chitiname;
  late String? code;
  late int? no;
  late int? amount;
  late int? payamount;
  late int? repayamount;
  late int? sripalcomm;
  late int? sowjicomm;
  late String? customername;
  late int? paatano;
  late int? paataamt;

  CftransModel({
    this.id,
    this.date,
    this.chiti,
    this.paata,
    this.customer,
    this.debit,
    this.credit,
    this.paymentmode,
    this.pmid,
    this.note,
    this.cusno,
    this.fname,
    this.lname,
    this.phone,
    this.first,
    this.firstid,
    this.maincus,
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
    this.chitiname,
    this.code,
    this.no,
    this.amount,
    this.payamount,
    this.repayamount,
    this.sripalcomm,
    this.sowjicomm,
    this.customername,
    this.paatano,
    this.paataamt,
  });

  factory CftransModel.fromJson(Map<String, dynamic> json) =>
      _$CftransModelFromJson(json);

  Map<String, dynamic> toJson() => _$CftransModelToJson(this);
}
