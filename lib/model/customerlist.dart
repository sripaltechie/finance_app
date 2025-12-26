import 'package:json_annotation/json_annotation.dart';

part 'customerlist.g.dart';

@JsonSerializable()
class CustomersList {
  late int? id;
  late int? SNO;
  late String? Firstname;
  late String? LastName;
  late String? PhoneNo;
  late int? hami;
  late int? ishami;
  late int? chitfund;
  late String? HamiFirstName;
  late String? HamiLastName;
  late String? HamiPhoneNo;
  late int? aadhar;
  late int? passbook;
  late int? debitcard;
  late int? cheque;
  late int? pnote;
  late int? greensheet;
  late String? note;
  late int? forint;
  late String? intrate;
  late String? proofs;

  CustomersList(
      {this.id,
      this.SNO,
      this.Firstname,
      this.LastName,
      this.PhoneNo,
      this.hami,
      this.ishami,
      this.chitfund,
      this.HamiFirstName,
      this.HamiLastName,
      this.HamiPhoneNo,
      this.aadhar,
      this.passbook,
      this.debitcard,
      this.cheque,
      this.pnote,
      this.greensheet,
      this.note,
      this.forint,
      this.intrate,
      this.proofs});

  factory CustomersList.fromJson(Map<String, dynamic> json) =>
      _$CustomersListFromJson(json);

  Map<String, dynamic> toJson() => _$CustomersListToJson(this);
}
