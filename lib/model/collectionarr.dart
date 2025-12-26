import 'package:json_annotation/json_annotation.dart';

part 'collectionarr.g.dart';

// List<latestnotes> welcomeFromJson(String str) => List<latestnotes>.from(
//     json.decode(str).map((x) => latestnotes.fromJson(x)));

// String welcomeToJson(List<latestnotes> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
//(converters: [MyJsonConverter()])
class Collectionarr {
  late String? colid;
  late String? colamt;
  late String? paymentmode;

  Collectionarr({
    this.colid,
    this.colamt,
    this.paymentmode,
  });

  factory Collectionarr.fromJson(Map<String, dynamic> json) =>
      _$CollectionarrFromJson(json);

  // get date => null;
  Map<String, dynamic> toJson() => _$CollectionarrToJson(this);
}
