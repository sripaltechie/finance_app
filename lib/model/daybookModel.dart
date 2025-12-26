import 'package:chanda_finance/model/creditorsModel.dart';
import 'package:json_annotation/json_annotation.dart';
import 'daybookPmModeModel.dart';

part 'daybookModel.g.dart';

@JsonSerializable()
class DaybookModel {
  CreditorsModel? creditors;
  CreditorsModel? debitors;
  List<DaybookPaymentmodeModel>? opbal;
  List<DaybookPaymentmodeModel>? transttl;
  List<DaybookPaymentmodeModel>? closingbal;

  DaybookModel({
    this.creditors,
    this.debitors,
    this.opbal,
    this.transttl,
    this.closingbal,
  });

  factory DaybookModel.fromJson(Map<String, dynamic> json) =>
      _$DaybookModelFromJson(json);

  Map<String, dynamic> toJson() => _$DaybookModelToJson(this);
}
