import 'package:json_annotation/json_annotation.dart';

import 'collectionarr.dart';

part 'rcvdCollection.g.dart';

@JsonSerializable()
//(converters: [MyJsonConverter()])
class RcvdCollection {
  // @MyJsonConverter()
  late int? id;
  late String? rcvddate;
  late String? userrcvddate;
  late String? customer;
  late String? customername;
  late String? chiti;
  late List<Collectionarr>? collectionarr;
  late String? paymentmode;
  late List<dynamic>? pmtrans;
  late String? note;
  late String? note1;

  RcvdCollection({
    this.id,
    this.rcvddate,
    this.userrcvddate,
    this.customer,
    this.customername,
    this.chiti,
    this.collectionarr,
    this.paymentmode,
    this.pmtrans,
    this.note,
    this.note1,
  });

  factory RcvdCollection.fromJson(Map<String, dynamic> json) =>
      _$RcvdCollectionFromJson(json);

  // get date => null;
  Map<String, dynamic> toJson() => _$RcvdCollectionToJson(this);
}
