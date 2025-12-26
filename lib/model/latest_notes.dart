class LatestNotesModel {
  Chiti? chiti;

  LatestNotesModel({this.chiti});

  LatestNotesModel.fromJson(Map<String, dynamic> json) {
    chiti = json['chiti'] != null ? new Chiti.fromJson(json['chiti']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chiti != null) {
      data['chiti'] = this.chiti!.toJson();
    }
    return data;
  }
}

class Chiti {
  String? customername;
  String? haminame;
  int? customer;
  int? id;
  int? irregular;
  int? remainingasalu;
  int? remainingint;
  String? regularamt;
  String? regularpmmode;
  int? remainingdays;
  int? status;
  List<Lasttrans>? lasttrans;
  int? perday;
  dynamic notes;

  Chiti(
      {this.customername,
      this.haminame,
      this.customer,
      this.id,
      this.irregular,
      this.remainingasalu,
      this.remainingint,
      this.regularamt,
      this.regularpmmode,
      this.remainingdays,
      this.status,
      this.lasttrans,
      this.perday,
      this.notes});

  Chiti.fromJson(Map<String, dynamic> json) {
    customername = json['customername'];
    haminame = json['haminame'];
    customer = json['customer'];
    id = json['id'];
    irregular = json['irregular'];
    remainingasalu = json['remainingasalu'];
    remainingint = json['remainingint'];
    regularamt = json['regularamt'];
    regularpmmode = json['regularpmmode'];
    remainingdays = json['remainingdays'];
    status = json['status'];
    if (json['lasttrans'] != null) {
      lasttrans = <Lasttrans>[];
      json['lasttrans'].forEach((v) {
        lasttrans!.add(new Lasttrans.fromJson(v));
      });
    }
    perday = json['perday'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customername'] = this.customername;
    data['haminame'] = this.haminame;
    data['customer'] = this.customer;
    data['id'] = this.id;
    data['irregular'] = this.irregular;
    data['remainingasalu'] = this.remainingasalu;
    data['remainingint'] = this.remainingint;
    data['regularamt'] = this.regularamt;
    data['regularpmmode'] = this.regularpmmode;
    data['remainingdays'] = this.remainingdays;
    data['status'] = this.status;
    if (this.lasttrans != null) {
      data['lasttrans'] = this.lasttrans!.map((v) => v.toJson()).toList();
    }
    data['perday'] = this.perday;
    data['notes'] = this.notes;
    return data;
  }
}

class Lasttrans {
  int? id;
  String? date;
  int? customer;
  int? amount;
  int? chitiamount;
  int? chiti;
  String? note;
  String? days;
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
  String? modename;
  int? opbal;
  String? customername;
  int? rcvdid;
  String? rcvdnote;
  String? paymentmodename;

  Lasttrans(
      {this.id,
      this.date,
      this.customer,
      this.amount,
      this.chitiamount,
      this.chiti,
      this.note,
      this.days,
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
      this.modename,
      this.opbal,
      this.customername,
      this.rcvdid,
      this.rcvdnote,
      this.paymentmodename});

  Lasttrans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    customer = json['customer'];
    amount = json['amount'];
    chitiamount = json['chitiamount'];
    chiti = json['chiti'];
    note = json['note'];
    days = json['days'];
    created = json['created'];
    updated = json['updated'];
    deleted = json['deleted'];
    code = json['code'];
    tYpe = json['tYpe'];
    advintmonths = json['advintmonths'];
    iscountable = json['iscountable'];
    paymentmode = json['paymentmode'];
    pmid = json['pmid'];
    pdwtm = json['pdwtm'];
    interestrate = json['interestrate'];
    ccomm = json['ccomm'];
    ccommpaymentmode = json['ccommpaymentmode'];
    suriccomm = json['suriccomm'];
    sowji = json['sowji'];
    suri = json['suri'];
    fullandevi = json['fullandevi'];
    reverse = json['reverse'];
    revcash = json['revcash'];
    status = json['status'];
    irregular = json['irregular'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phoneno = json['phoneno'];
    hami = json['hami'];
    ishami = json['ishami'];
    chitfund = json['chitfund'];
    aadhar = json['aadhar'];
    passbook = json['passbook'];
    debitcard = json['debitcard'];
    cheque = json['cheque'];
    pnote = json['pnote'];
    greensheet = json['greensheet'];
    forint = json['forint'];
    intrate = json['intrate'];
    rcvddate = json['rcvddate'];
    asalu = json['asalu'];
    asaluid = json['asaluid'];
    colid = json['colid'];
    modename = json['modename'];
    opbal = json['opbal'];
    customername = json['customername'];
    rcvdid = json['rcvdid'];
    rcvdnote = json['rcvdnote'];
    paymentmodename = json['paymentmodename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['customer'] = customer;
    data['amount'] = amount;
    data['chitiamount'] = chitiamount;
    data['chiti'] = chiti;
    data['note'] = note;
    data['days'] = days;
    data['created'] = created;
    data['updated'] = updated;
    data['deleted'] = deleted;
    data['code'] = code;
    data['tYpe'] = tYpe;
    data['advintmonths'] = advintmonths;
    data['iscountable'] = iscountable;
    data['paymentmode'] = paymentmode;
    data['pmid'] = pmid;
    data['pdwtm'] = pdwtm;
    data['interestrate'] = interestrate;
    data['ccomm'] = ccomm;
    data['ccommpaymentmode'] = ccommpaymentmode;
    data['suriccomm'] = suriccomm;
    data['sowji'] = sowji;
    data['suri'] = suri;
    data['fullandevi'] = fullandevi;
    data['reverse'] = reverse;
    data['revcash'] = revcash;
    data['status'] = status;
    data['irregular'] = irregular;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['phoneno'] = phoneno;
    data['hami'] = hami;
    data['ishami'] = ishami;
    data['chitfund'] = chitfund;
    data['aadhar'] = aadhar;
    data['passbook'] = passbook;
    data['debitcard'] = debitcard;
    data['cheque'] = cheque;
    data['pnote'] = pnote;
    data['greensheet'] = greensheet;
    data['forint'] = forint;
    data['intrate'] = intrate;
    data['rcvddate'] = rcvddate;
    data['asalu'] = asalu;
    data['asaluid'] = asaluid;
    data['colid'] = colid;
    data['modename'] = modename;
    data['opbal'] = opbal;
    data['customername'] = customername;
    data['rcvdid'] = rcvdid;
    data['rcvdnote'] = rcvdnote;
    data['paymentmodename'] = paymentmodename;
    return data;
  }
}
