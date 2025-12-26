class CustomersListModel {
  List<Customers>? customers;

  CustomersListModel({this.customers});

  CustomersListModel.fromJson(Map<String, dynamic> json) {
    if (json['customers'] != null) {
      customers = <Customers>[];
      json['customers'].forEach((v) {
        customers!.add(new Customers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customers != null) {
      data['customers'] = this.customers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customers {
  int? id;
  int? sNO;
  String? firstname;
  String? lastName;
  String? fullname;
  String? phoneNo;
  int? hami;
  int? ishami;
  int? chitfund;
  String? hamiFirstName;
  String? hamiLastName;
  String? hamiPhoneNo;
  int? aadhar;
  int? passbook;
  int? debitcard;
  int? cheque;
  int? pnote;
  int? greensheet;
  String? note;
  int? forint;
  dynamic intrate;
  String? created;
  String? updated;

  Customers(
      {this.id,
      this.sNO,
      this.firstname,
      this.lastName,
      this.fullname,
      this.phoneNo,
      this.hami,
      this.ishami,
      this.chitfund,
      this.hamiFirstName,
      this.hamiLastName,
      this.hamiPhoneNo,
      this.aadhar,
      this.passbook,
      this.debitcard,
      this.cheque,
      this.pnote,
      this.greensheet,
      this.note,
      this.forint,
      this.intrate,
      this.created,
      this.updated});

  Customers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sNO = json['SNO'];
    firstname = json['Firstname'];
    lastName = json['LastName'];
    fullname = json['fullname'];
    phoneNo = json['PhoneNo'];
    hami = json['hami'];
    ishami = json['ishami'];
    chitfund = json['chitfund'];
    hamiFirstName = json['HamiFirstName'];
    hamiLastName = json['HamiLastName'];
    hamiPhoneNo = json['HamiPhoneNo'];
    aadhar = json['aadhar'];
    passbook = json['passbook'];
    debitcard = json['debitcard'];
    cheque = json['cheque'];
    pnote = json['pnote'];
    greensheet = json['greensheet'];
    note = json['note'];
    forint = json['forint'];
    intrate = json['intrate'];
    created = json['Created'];
    updated = json['Updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['SNO'] = sNO;
    data['Firstname'] = firstname;
    data['LastName'] = lastName;
    data['fullname'] = fullname;
    data['PhoneNo'] = phoneNo;
    data['hami'] = hami;
    data['ishami'] = ishami;
    data['chitfund'] = chitfund;
    data['HamiFirstName'] = hamiFirstName;
    data['HamiLastName'] = hamiLastName;
    data['HamiPhoneNo'] = hamiPhoneNo;
    data['aadhar'] = aadhar;
    data['passbook'] = passbook;
    data['debitcard'] = debitcard;
    data['cheque'] = cheque;
    data['pnote'] = pnote;
    data['greensheet'] = greensheet;
    data['note'] = note;
    data['forint'] = forint;
    data['intrate'] = intrate;
    data['Created'] = created;
    data['Updated'] = updated;
    return data;
  }
}
