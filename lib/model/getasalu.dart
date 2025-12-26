// import 'dart:ui';
// import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'getasalu.g.dart';

@JsonSerializable()
class GetAsalu {
  late int? id;
  late String? date;
  late int? customer;
  late int? amount;
  late int? chitiamount;
  late int? chiti;
  late String? customername;
  late String? note;
  late int? paymentmode;
  late String? paymentmodename;
  // late List<dynamic>? pmtrans = [];

  GetAsalu({
    this.id,
    this.date,
    this.customer,
    this.amount,
    this.chitiamount,
    this.chiti,
    this.customername,
    this.note,
    this.paymentmode,
    this.paymentmodename,
    // this.pmtrans,
  });

  factory GetAsalu.fromJson(Map<String, dynamic> json) =>
      _$GetAsaluFromJson(json);

  Map<String, dynamic> toJson() => _$GetAsaluToJson(this);
}
