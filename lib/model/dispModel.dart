// import 'dart:ui';
// import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'dispModel.g.dart';

@JsonSerializable()
class Disp {
  late int? rcvdamt;
  late int? collection;
  late int? drcr;
  late int? cftrans;
  late int? ccomm;
  late int? interest;
  late int? chiti;

  Disp({
    this.rcvdamt,
    this.collection,
    this.drcr,
    this.cftrans,
    this.ccomm,
    this.interest,
    this.chiti,
  });

  factory Disp.fromJson(Map<String, dynamic> json) => _$DispFromJson(json);

  Map<String, dynamic> toJson() => _$DispToJson(this);
}
