import 'package:chanda_finance/model/asalu.dart';

class ChitiModel {
  int? id;
  int? customer;
  String? customername;
  String? code;
  String? date;
  int? tYpe;
  int? advintmonths;
  int? iscountable;
  int? chitiamount;
  int? remainingasalu;
  int? paymentmode;
  String? paymentmodename;
  String? pmid;
  int? pdwtm;
  String? interestrate;
  int? ccomm;
  int? ccommpaymentmode;
  String? ccommpaymentmodename;
  int? suriccomm;
  int? sowji;
  int? suri;
  int? fullandevi;
  int? reverse;
  int? revcash;
  int? status;
  String? note;
  int? irregular;
  int? hami;
  String? haminame;
  String? created;
  String? updated;
  List<PmtransModel>? pmtrans;

  ChitiModel(
      {this.id,
      this.customer,
      this.customername,
      this.code,
      this.date,
      this.tYpe,
      this.advintmonths,
      this.iscountable,
      this.chitiamount,
      this.remainingasalu,
      this.paymentmode,
      this.paymentmodename,
      this.pmid,
      this.pdwtm,
      this.interestrate,
      this.ccomm,
      this.ccommpaymentmode,
      this.ccommpaymentmodename,
      this.suriccomm,
      this.sowji,
      this.suri,
      this.fullandevi,
      this.reverse,
      this.revcash,
      this.status,
      this.note,
      this.irregular,
      this.hami,
      this.haminame,
      this.created,
      this.updated,
      this.pmtrans});

  ChitiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'];
    customername = json['customername'];
    code = json['code'];
    date = json['date'];
    tYpe = json['tYpe'];
    advintmonths = json['advintmonths'];
    iscountable = json['iscountable'];
    chitiamount = json['chitiamount'];
    remainingasalu = json['remainingasalu'];
    paymentmode = json['paymentmode'];
    paymentmodename = json['paymentmodename'];
    pmid = json['pmid'];
    pdwtm = json['pdwtm'];
    interestrate = json['interestrate'];
    ccomm = json['ccomm'];
    ccommpaymentmode = json['ccommpaymentmode'];
    ccommpaymentmodename = json['ccommpaymentmodename'];
    suriccomm = json['suriccomm'];
    sowji = json['sowji'];
    suri = json['suri'];
    fullandevi = json['fullandevi'];
    reverse = json['reverse'];
    revcash = json['revcash'];
    status = json['status'];
    note = json['note'];
    irregular = json['irregular'];
    hami = json['hami'];
    haminame = json['haminame'];
    created = json['created'];
    updated = json['updated'];
    if (json['pmtrans'] != null && json['pmtrans'] != "") {
      pmtrans = <PmtransModel>[];
      json['pmtrans'].forEach((v) {
        pmtrans!.add(new PmtransModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer'] = customer;
    data['customername'] = customername;
    data['code'] = code;
    data['date'] = date;
    data['tYpe'] = tYpe;
    data['advintmonths'] = advintmonths;
    data['iscountable'] = iscountable;
    data['chitiamount'] = chitiamount;
    data['remainingasalu'] = remainingasalu;
    data['paymentmode'] = paymentmode;
    data['paymentmodename'] = paymentmodename;
    data['pmid'] = pmid;
    data['pdwtm'] = pdwtm;
    data['interestrate'] = interestrate;
    data['ccomm'] = ccomm;
    data['ccommpaymentmode'] = ccommpaymentmode;
    data['ccommpaymentmodename'] = ccommpaymentmodename;
    data['suriccomm'] = suriccomm;
    data['sowji'] = sowji;
    data['suri'] = suri;
    data['fullandevi'] = fullandevi;
    data['reverse'] = reverse;
    data['revcash'] = revcash;
    data['status'] = status;
    data['note'] = note;
    data['irregular'] = irregular;
    data['hami'] = hami;
    data['haminame'] = haminame;
    data['created'] = created;
    data['updated'] = updated;
    if (pmtrans != null) {
      data['pmtrans'] = pmtrans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
