// import 'dart:ui';
// import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'interestModel.g.dart';

@JsonSerializable()
class InterestModel {
  late int? id;
  late String? date;
  late int? customer;
  late int? credit;
  late int? debit;
  late int? paymentmode;
  late String? pmid;
  late String? note;
  late String? note1;
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
  late String? intrate;
  late String? modename;
  late int? opbal;
  late String? customername;
  late String? paymentmodename;

  InterestModel({
    this.id,
    this.date,
    this.customer,
    this.credit,
    this.debit,
    this.paymentmode,
    this.pmid,
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
    this.forint,
    this.intrate,
    this.modename,
    this.opbal,
    this.customername,
    this.paymentmodename,
  });

  factory InterestModel.fromJson(Map<String, dynamic> json) =>
      _$InterestModelFromJson(json);

  Map<String, dynamic> toJson() => _$InterestModelToJson(this);
}
