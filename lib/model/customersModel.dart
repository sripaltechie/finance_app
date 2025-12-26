import 'package:chanda_finance/model/ccommModel.dart';
import 'package:chanda_finance/model/cftransmodel.dart';
import 'package:chanda_finance/model/chitiModel.dart';
import 'package:chanda_finance/model/drcrModel.dart';
import 'package:chanda_finance/model/interestModel.dart';
import 'package:chanda_finance/model/receivedList.dart';
import 'package:json_annotation/json_annotation.dart';

import 'dispModel.dart';

part 'customersModel.g.dart';

@JsonSerializable()
class CustomersModel {
  late int? id;
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
  late String? note;
  late int? forint;
  late double? intrate;
  late String? created;
  late String? updated;
  late int? deleted;
  late String? hamifirstname;
  late String? hamilastname;
  late String? hamiphoneno;
  late Disp? disp;
  late int? total;
  List<ReceivedList>? rcvdamtlist;
  List? collectionlist;
  List<DrcrModel>? drcrlist;
  List<CftransModel>? cftranslist;
  List<CcommModel>? ccommlist;
  List<InterestModel>? interestlist;
  List<ChitiModel>? chitilist;

  CustomersModel({
    this.id,
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
    this.note,
    this.forint,
    this.intrate,
    this.created,
    this.updated,
    this.deleted,
    this.hamifirstname,
    this.hamilastname,
    this.hamiphoneno,
    this.disp,
    this.total,
    this.rcvdamtlist,
    this.collectionlist,
    this.drcrlist,
    this.cftranslist,
    this.ccommlist,
    this.interestlist,
    this.chitilist,
  });

  factory CustomersModel.fromJson(Map<String, dynamic> json) =>
      _$CustomersModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomersModelToJson(this);
}
