import 'package:json_annotation/json_annotation.dart';

part 'chitilistModel.g.dart';

@JsonSerializable()
class ChitilistModel {
  late int? id;
  late int? customer;
  late String? code;
  late String? date;
  late int? tYpe;
  late int? advintmonths;
  late int? iscountable;
  late int? amount;
  late int? paymentmode;
  late String? pmid;
  late int? pdwtm;
  late String? interestrate;
  late int? ccomm;
  late int? ccommpaymentmode;
  late int? suriccomm;
  late int? sowji;
  late int? suri;
  late int? fullandevi;
  late int? reverse;
  late int? revcash;
  late int? status;
  late String? note;
  late int? irregular;
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
  late String? modename;
  late int? opbal;
  late String? customername;
  late String? haminame;
  late String? paymentmodename;
  late String? ccommpaymentmodename;

  ChitilistModel({
    this.id,
    this.customer,
    this.code,
    this.date,
    this.tYpe,
    this.advintmonths,
    this.iscountable,
    this.amount,
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
    this.note,
    this.irregular,
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
    this.haminame,
    this.paymentmodename,
    this.ccommpaymentmodename,
  });

  factory ChitilistModel.fromJson(Map<String, dynamic> json) =>
      _$ChitilistModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChitilistModelToJson(this);
}
