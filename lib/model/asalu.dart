class AsaluModel {
  int? id;
  String? date;
  int? customer;
  int? amount;
  int? chitiamount;
  int? chiti;
  String? code;
  String? customername;
  String? note;
  int? paymentmode;
  String? paymentmodename;
  String? pmid;
  int? rcvdid;
  String? rcvdnote;
  int? collectedby;
  String? created;
  String? updated;
  List<PmtransModel>? pmtrans;

  AsaluModel(
      {this.id,
      this.date,
      this.customer,
      this.amount,
      this.chitiamount,
      this.chiti,
      this.code,
      this.customername,
      this.note,
      this.paymentmode,
      this.paymentmodename,
      this.pmid,
      this.rcvdid,
      this.rcvdnote,
      this.collectedby,
      this.created,
      this.updated,
      this.pmtrans});

  AsaluModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    customer = json['customer'];
    amount = json['amount'];
    chitiamount = json['chitiamount'];
    chiti = json['chiti'];
    code = json['code'];
    customername = json['customername'];
    note = json['note'];
    paymentmode = json['paymentmode'];
    paymentmodename = json['paymentmodename'];
    pmid = json['pmid'];
    rcvdid = json['rcvdid'];
    rcvdnote = json['rcvdnote'];
    collectedby = json['collectedby'];
    created = json['created'];
    updated = json['updated'];
    if (json['pmtrans'] != null) {
      pmtrans = <PmtransModel>[];
      json['pmtrans'].forEach((v) {
        pmtrans!.add(new PmtransModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['customer'] = this.customer;
    data['amount'] = this.amount;
    data['chitiamount'] = this.chitiamount;
    data['chiti'] = this.chiti;
    data['code'] = this.code;
    data['customername'] = this.customername;
    data['note'] = this.note;
    data['paymentmode'] = this.paymentmode;
    data['paymentmodename'] = this.paymentmodename;
    data['pmid'] = this.pmid;
    data['rcvdid'] = this.rcvdid;
    data['rcvdnote'] = this.rcvdnote;
    data['collectedby'] = this.collectedby;
    data['created'] = this.created;
    data['updated'] = this.updated;
    if (this.pmtrans != null) {
      data['pmtrans'] = this.pmtrans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PmtransModel {
  int? id;
  String? date;
  String? tablename;
  int? tableid;
  int? paymentmode;
  int? credit;
  int? debit;
  String? created;
  String? updated;
  int? deleted;
  String? modename;
  int? opbal;
  String? paymentmodename;

  PmtransModel(
      {this.id,
      this.date,
      this.tablename,
      this.tableid,
      this.paymentmode,
      this.credit,
      this.debit,
      this.created,
      this.updated,
      this.deleted,
      this.modename,
      this.opbal,
      this.paymentmodename});

  PmtransModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    tablename = json['tablename'];
    tableid = json['tableid'];
    paymentmode = json['paymentmode'];
    credit = json['credit'];
    debit = json['debit'];
    created = json['created'];
    updated = json['updated'];
    deleted = json['deleted'];
    modename = json['modename'];
    opbal = json['opbal'];
    paymentmodename = json['paymentmodename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['tablename'] = this.tablename;
    data['tableid'] = this.tableid;
    data['paymentmode'] = this.paymentmode;
    data['credit'] = this.credit;
    data['debit'] = this.debit;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['deleted'] = this.deleted;
    data['modename'] = this.modename;
    data['opbal'] = this.opbal;
    data['paymentmodename'] = this.paymentmodename;
    return data;
  }
}
