import 'dart:ui';
import 'dart:convert';
import 'package:flutter/foundation.dart';

// part 'model.g.dart';

// List<latestnotes> welcomeFromJson(String str) => List<latestnotes>.from(
//     json.decode(str).map((x) => latestnotes.fromJson(x)));

// String welcomeToJson(List<latestnotes> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// @JsonSerializable(converters: [MyJsonConverter()])
class Latestnotes {
  // @MyJsonConverter()
  late String? customername;
  late String? customer;
  late String? chiti;
  late String? regularamt;
  late Lasttrans? lasttrans;
  late int? perday;
  late double? notes;

  Latestnotes({
    this.customername,
    this.customer,
    this.chiti,
    this.regularamt,
    this.lasttrans,
    this.perday,
    this.notes,
  });

  // factory Latestnotes.fromJson(Map<String, dynamic> json) =>
  //     _$LatestnotesFromJson(json);
  // Map<String, dynamic> toJson() => _$LatestnotesToJson(this);
}

//   factory latestnotes.fromJson(Map<String, dynamic> json) => latestnotes(
//         customername:
//             json["customername"] == null ? null : json["customername"],
//         regularamt: json["regularamt"] == null ? null : json["regularamt"],
//         lasttrans: json["lasttrans"] == null
//             ? null
//             : List<String>.from(json["lasttrans"].map((x) => x)),
//   //       perday: json["perday"] == null ? null : json["perday"],
//   //       notes: json["notes"] == null ? null : json["notes"],
//   //     );

//   // Map<String, dynamic> toJson() => {
//   //       "customername": customername == null ? null : customername,
//   //       "regularamt": regularamt == null ? null : regularamt,
//   //       "lasttrans": lasttrans == null
//   //           ? null
//   //           : List<dynamic>.from(lasttrans.map((x) => x)),
//   //       "perday": perday == null ? null : perday,
//   //       "notes": notes == null ? null : notes,
//   //     };
// }

class Lasttrans {
  int? id;
  String? date;
  int? customer;
  int? amount;
  int? chitiamount;
  int? chiti;
  String? note;
  String? created;
  String? updated;
  int? deleted;
  String? code;
  int? tYpe;
  int? advintmonths;
  int? iscountable;
  int? paymentmode;
  String? pmid;
  int? pdwtm;
  String? interestrate;
  int? ccomm;
  int? ccommpaymentmode;
  int? suriccomm;
  int? sowji;
  int? suri;
  int? fullandevi;
  int? reverse;
  int? revcash;
  int? status;
  int? irregular;
  String? firstname;
  String? lastname;
  String? phoneno;
  int? hami;
  int? ishami;
  int? chitfund;
  int? aadhar;
  int? passbook;
  int? debitcard;
  int? cheque;
  int? pnote;
  int? greensheet;
  int? forint;
  int? intrate;
  String? rcvddate;
  int? asalu;
  int? asaluid;
  int? colid;
  String? customername;
  int? rcvdid;

  Lasttrans({
    this.id,
    this.date,
    this.customer,
    this.amount,
    this.chitiamount,
    this.chiti,
    this.note,
    this.created,
    this.updated,
    this.deleted,
    this.code,
    this.tYpe,
    this.advintmonths,
    this.iscountable,
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
    this.irregular,
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
    this.rcvddate,
    this.asalu,
    this.asaluid,
    this.colid,
    this.customername,
    this.rcvdid,
  });
}
  // )