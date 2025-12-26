import 'package:json_annotation/json_annotation.dart';

part 'sessionModel.g.dart';

//flutter pub run build_runner build
// List<SessionModel> welcomeFromJson(String str) => List<latestnotes>.from(
//     json.decode(str).map((x) => latestnotes.fromJson(x)));

// String welcomeToJson(List<latestnotes> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
//(converters: [MyJsonConverter()])
class SessionModel {
  // @MyJsonConverter()
  late String? uid;
  late String? api_key;
  late String? name;
  late String? firstname;
  late String? lastname;
  late String? firm;
  late String? phone;
  late String? role;
  late String? branch;
  late String? rolename;

  SessionModel({
    this.uid,
    this.api_key,
    this.name,
    this.firstname,
    this.lastname,
    this.firm,
    this.phone,
    this.role,
    this.branch,
    this.rolename,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

  // get date => null;
  Map<String, dynamic> toJson() => _$SessionModelToJson(this);
}
