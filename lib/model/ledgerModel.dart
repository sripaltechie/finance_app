class ledgerModel {
  List<LedgerList>? ledgerList;
  dynamic opbal;
  dynamic closingbal;

  ledgerModel({this.ledgerList, this.opbal, this.closingbal});

  ledgerModel.fromJson(Map<String, dynamic> json) {
    opbal = json['opbal'];
    closingbal = json['closingbal'];
    if (json['ledgerList'] != null) {
      ledgerList = <LedgerList>[];
      json['ledgerList'].forEach((v) {
        ledgerList!.add(new LedgerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['opbal'] = this.opbal;
    data['closingbal'] = this.closingbal;
    if (this.ledgerList != null) {
      data['ledgerList'] = this.ledgerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LedgerList {
  int? id;
  String? date;
  int? customer;
  String? customername;
  dynamic debit;
  dynamic credit;
  int? collectedby;
  int? forint;
  int? creditexp;
  int? crid;
  int? chitfundid;
  int? showdaybook;
  String? note;
  int? paymentmode;
  String? pmid;
  List<Pmtrans>? pmtrans;
  String? paymentmodename;
  String? note1;
  int? interestentry;
  dynamic balance;

  LedgerList(
      {this.id,
      this.date,
      this.customer,
      this.customername,
      this.debit,
      this.credit,
      this.collectedby,
      this.forint,
      this.creditexp,
      this.crid,
      this.chitfundid,
      this.showdaybook,
      this.note,
      this.paymentmode,
      this.pmid,
      this.pmtrans,
      this.paymentmodename,
      this.note1,
      this.interestentry,
      this.balance});

  LedgerList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    customer = json['customer'];
    customername = json['customername'];
    debit = json['debit'];
    credit = json['credit'];
    collectedby = json['collectedby'];
    forint = json['forint'];
    creditexp = json['creditexp'];
    crid = json['crid'];
    chitfundid = json['chitfundid'];
    showdaybook = json['showdaybook'];
    note = json['note'];
    paymentmode = json['paymentmode'];
    pmid = json['pmid'];
    if (json['pmtrans'] != null) {
      pmtrans = <Pmtrans>[];
      json['pmtrans'].forEach((v) {
        pmtrans!.add(new Pmtrans.fromJson(v));
      });
    }
    paymentmodename = json['paymentmodename'];
    note1 = json['note1'];
    interestentry = json['interestentry'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['customer'] = this.customer;
    data['customername'] = this.customername;
    data['debit'] = this.debit;
    data['credit'] = this.credit;
    data['collectedby'] = this.collectedby;
    data['forint'] = this.forint;
    data['creditexp'] = this.creditexp;
    data['crid'] = this.crid;
    data['chitfundid'] = this.chitfundid;
    data['showdaybook'] = this.showdaybook;
    data['note'] = this.note;
    data['paymentmode'] = this.paymentmode;
    data['pmid'] = this.pmid;
    if (this.pmtrans != null) {
      data['pmtrans'] = this.pmtrans!.map((v) => v.toJson()).toList();
    }
    data['paymentmodename'] = this.paymentmodename;
    data['note1'] = this.note1;
    data['interestentry'] = this.interestentry;
    data['balance'] = this.balance;
    return data;
  }
}

class Pmtrans {
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

  Pmtrans(
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

  Pmtrans.fromJson(Map<String, dynamic> json) {
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
