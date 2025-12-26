import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

//flutter pub run build_runner build
// List<latestnotes> welcomeFromJson(String str) => List<latestnotes>.from(
//     json.decode(str).map((x) => latestnotes.fromJson(x)));

// String welcomeToJson(List<latestnotes> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
//(converters: [MyJsonConverter()])
class Latestnotes {
  // @MyJsonConverter()
  late String? customername;
  late String? haminame;
  late int? customer;
  late int? id;
  late String? regularamt;
  late int? irregular;
  late List<dynamic>? lasttrans;
  late int? perday;
  late int? remainingasalu;
  late int? remainingdays;
  late double? notes;

  Latestnotes({
    this.customername,
    this.haminame,
    this.customer,
    this.id,
    this.regularamt,
    this.irregular,
    this.lasttrans,
    this.perday,
    this.remainingasalu,
    this.remainingdays,
    this.notes,
  });

  factory Latestnotes.fromJson(Map<String, dynamic> json) =>
      _$LatestnotesFromJson(json);

  // get date => null;
  Map<String, dynamic> toJson() => _$LatestnotesToJson(this);
}
