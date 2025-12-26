class CollectionModel {
  int? id;
  int? chiti;
  String? code;
  int? tYpe;
  int? status;
  int? chitiamount;
  String? chitidate;
  String? date;
  int? amount;
  String? notes;
  int? sowji;
  int? suri;
  int? fullandevi;
  int? iscountable;
  int? received;
  int? reverseid;
  int? receivedfrom;
  int? customer;
  String? customerFL;
  int? hami;
  String? haminame;
  String? rcvddate;
  int? rcvdid;
  int? paymentmode;
  String? pmid;
  String? paymentmodename;
  List<Pmtrans>? pmtrans;
  String? created;
  String? updated;

  CollectionModel(
      {this.id,
      this.chiti,
      this.code,
      this.tYpe,
      this.status,
      this.chitiamount,
      this.chitidate,
      this.date,
      this.amount,
      this.notes,
      this.sowji,
      this.suri,
      this.fullandevi,
      this.iscountable,
      this.received,
      this.reverseid,
      this.receivedfrom,
      this.customer,
      this.customerFL,
      this.hami,
      this.haminame,
      this.rcvddate,
      this.rcvdid,
      this.paymentmode,
      this.pmid,
      this.paymentmodename,
      this.created,
      this.updated});

  CollectionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chiti = json['chiti'];
    code = json['code'];
    tYpe = json['tYpe'];
    status = json['status'];
    chitiamount = json['chitiamount'];
    chitidate = json['chitidate'];
    date = json['date'];
    amount = json['amount'];
    notes = json['notes'];
    sowji = json['sowji'];
    suri = json['suri'];
    fullandevi = json['fullandevi'];
    iscountable = json['iscountable'];
    received = json['received'];
    reverseid = json['reverseid'];
    receivedfrom = json['receivedfrom'];
    customer = json['customer'];
    customerFL = json['customerFL'];
    hami = json['hami'];
    haminame = json['haminame'];
    rcvddate = json['rcvddate'];
    rcvdid = json["rcvdid"];
    paymentmode = json["paymentmode"];
    pmid = json["pmid"];
    paymentmodename = json["paymentmodename"];
    created = json['created'];
    updated = json['updated'];
    if (json['pmtrans'] != null) {
      pmtrans = <Pmtrans>[];
      json['pmtrans'].forEach((v) {
        pmtrans!.add(new Pmtrans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['chiti'] = chiti;
    data['code'] = code;
    data['tYpe'] = tYpe;
    data['status'] = status;
    data['chitiamount'] = chitiamount;
    data['chitidate'] = chitidate;
    data['date'] = date;
    data['amount'] = amount;
    data['notes'] = notes;
    data['sowji'] = sowji;
    data['suri'] = suri;
    data['fullandevi'] = fullandevi;
    data['iscountable'] = iscountable;
    data['received'] = received;
    data['reverseid'] = reverseid;
    data['receivedfrom'] = receivedfrom;
    data['customer'] = customer;
    data['customerFL'] = customerFL;
    data['hami'] = hami;
    data['haminame'] = haminame;
    data['rcvddate'] = rcvddate;
    data['created'] = created;
    data['updated'] = updated;
    data["rcvdid"] = rcvdid;
    data["paymentmode"] = paymentmode;
    data["pmid"] = pmid;
    data["paymentmodename"] = paymentmodename;
    if (this.pmtrans != null) {
      data['pmtrans'] = this.pmtrans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pmtrans {
  int? paymentmode;
  String? paymentmodename;
  int? credit;
  int? debit;

  Pmtrans({this.paymentmode, this.credit, this.debit});

  Pmtrans.fromJson(Map<String, dynamic> json) {
    paymentmode = json['paymentmode'];
    paymentmodename = json['paymentmodename'];
    credit = json['credit'];
    debit = json['debit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentmode'] = this.paymentmode;
    data['paymentmodename'] = this.paymentmodename;
    data['credit'] = this.credit;
    data['debit'] = this.debit;
    return data;
  }
}
