class LastPaymentsModel {
  List<Lastpayments>? lastpayments;

  LastPaymentsModel({this.lastpayments});

  LastPaymentsModel.fromJson(Map<String, dynamic> json) {
    if (json['lastpayments'] != null) {
      lastpayments = <Lastpayments>[];
      json['lastpayments'].forEach((v) {
        lastpayments!.add(new Lastpayments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lastpayments != null) {
      data['lastpayments'] = this.lastpayments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lastpayments {
  String? chiti;
  String? days;
  String? amount;
  String? rcvddate;
  dynamic customer;
  String? note;
  String? customername;
  dynamic paymentmode;
  String? tYpe;
  String? haminame;
  int? id;
  int? asalu;
  int? asaluid;
  int? colid;
  String? pmid;
  String? created;
  String? updated;
  int? deleted;
  String? latestdate;
  String? paymentmodename;

  Lastpayments(
      {this.chiti,
      this.days,
      this.amount,
      this.rcvddate,
      this.customer,
      this.note,
      this.customername,
      this.paymentmode,
      this.tYpe,
      this.haminame,
      this.id,
      this.asalu,
      this.asaluid,
      this.colid,
      this.pmid,
      this.created,
      this.updated,
      this.deleted,
      this.latestdate,
      this.paymentmodename});

  Lastpayments.fromJson(Map<String, dynamic> json) {
    chiti = json['chiti'];
    days = json['days'];
    amount = json['amount'];
    rcvddate = json['rcvddate'];
    customer = json['customer'];
    note = json['note'];
    customername = json['customername'];
    paymentmode = json['paymentmode'];
    tYpe = json['tYpe'];
    haminame = json['haminame'];
    id = json['id'];
    asalu = json['asalu'];
    asaluid = json['asaluid'];
    colid = json['colid'];
    pmid = json['pmid'];
    created = json['created'];
    updated = json['updated'];
    deleted = json['deleted'];
    latestdate = json['latestdate'];
    paymentmodename = json['paymentmodename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chiti'] = this.chiti;
    data['days'] = this.days;
    data['amount'] = this.amount;
    data['rcvddate'] = this.rcvddate;
    data['customer'] = this.customer;
    data['note'] = this.note;
    data['customername'] = this.customername;
    data['paymentmode'] = this.paymentmode;
    data['tYpe'] = this.tYpe;
    data['haminame'] = this.haminame;
    data['id'] = this.id;
    data['asalu'] = this.asalu;
    data['asaluid'] = this.asaluid;
    data['colid'] = this.colid;
    data['pmid'] = this.pmid;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['deleted'] = this.deleted;
    data['latestdate'] = this.latestdate;
    data['paymentmodename'] = this.paymentmodename;
    return data;
  }
}
