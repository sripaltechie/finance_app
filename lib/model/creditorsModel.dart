import 'dart:ui';
import 'dart:convert';
import 'package:chanda_finance/model/customersModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'creditorsModel.g.dart';

@JsonSerializable()
//(converters: [MyJsonConverter()])
class CreditorsModel {
  late int? total;
  List<CustomersModel>? customers;

  CreditorsModel({this.customers, this.total});

  factory CreditorsModel.fromJson(Map<String, dynamic> json) =>
      _$CreditorsModelFromJson(json);

  // get date => null;
  Map<String, dynamic> toJson() => _$CreditorsModelToJson(this);
}
