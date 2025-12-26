class collectionReportModel {
  Collectionreport? collectionreport;

  collectionReportModel({this.collectionreport});

  collectionReportModel.fromJson(Map<String, dynamic> json) {
    collectionreport = json['collectionreport'] != null
        ? new Collectionreport.fromJson(json['collectionreport'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collectionreport != null) {
      data['collectionreport'] = this.collectionreport!.toJson();
    }
    return data;
  }
}

class Collectionreport {
  List<CollectionList>? collectionList;
  List<CollectionRcvd>? collectionRcvd;
  List<CollectionList>? onlinecollection;

  Collectionreport({this.collectionList, this.collectionRcvd});

  Collectionreport.fromJson(Map<String, dynamic> json) {
    if (json['collectionList'] != null) {
      collectionList = <CollectionList>[];
      json['collectionList'].forEach((v) {
        collectionList!.add(new CollectionList.fromJson(v));
      });
    }
    if (json['collectionRcvd'] != null) {
      collectionRcvd = <CollectionRcvd>[];
      json['collectionRcvd'].forEach((v) {
        collectionRcvd!.add(new CollectionRcvd.fromJson(v));
      });
    }
    if (json['onlinecollection'] != null) {
      onlinecollection = <CollectionList>[];
      json['onlinecollection'].forEach((v) {
        onlinecollection!.add(new CollectionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collectionList != null) {
      data['collectionList'] =
          this.collectionList!.map((v) => v.toJson()).toList();
    }
    if (this.collectionRcvd != null) {
      data['collectionRcvd'] =
          this.collectionRcvd!.map((v) => v.toJson()).toList();
    }
    if (this.onlinecollection != null) {
      data['onlinecollection'] =
          this.onlinecollection!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CollectionList {
  dynamic id;
  String? date;
  String? customername;
  dynamic tYpe;
  String? tablename;
  dynamic chiti;
  String? note;
  dynamic collector;
  String? collectorname;
  dynamic paymentmode;
  String? pmid;
  // List<Null>? pmtrans;
  String? paymentmodename;
  dynamic amount;
  dynamic customer;
  dynamic forint;
  String? type;

  CollectionList(
      {this.id,
      this.date,
      this.customername,
      this.tYpe,
      this.tablename,
      this.chiti,
      this.note,
      this.collector,
      this.collectorname,
      this.paymentmode,
      this.pmid,
      // this.pmtrans,
      this.paymentmodename,
      this.amount,
      this.customer,
      this.forint,
      this.type});

  CollectionList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    customername = json['customername'];
    tYpe = json['tYpe'];
    tablename = json['tablename'];
    chiti = json['chiti'];
    note = json['note'];
    collector = json['collector'];
    collectorname = json['collectorname'];
    paymentmode = json['paymentmode'];
    pmid = json['pmid'];
    // if (json['pmtrans'] != null) {
    //   pmtrans = <Null>[];
    //   json['pmtrans'].forEach((v) {
    //     pmtrans!.add(new Null.fromJson(v));
    //   });
    // }
    paymentmodename = json['paymentmodename'];
    amount = json['amount'];
    customer = json['customer'];
    forint = json['forint'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['customername'] = this.customername;
    data['tYpe'] = this.tYpe;
    data['tablename'] = this.tablename;
    data['chiti'] = this.chiti;
    data['note'] = this.note;
    data['collector'] = this.collector;
    data['collectorname'] = this.collectorname;
    data['paymentmode'] = this.paymentmode;
    data['pmid'] = this.pmid;
    // if (this.pmtrans != null) {
    //   data['pmtrans'] = this.pmtrans!.map((v) => v!.toJson()).toList();
    // }
    data['paymentmodename'] = this.paymentmodename;
    data['amount'] = this.amount;
    data['customer'] = this.customer;
    data['forint'] = this.forint;
    data['type'] = this.type;
    return data;
  }
}

class CollectionRcvd {
  int? id;
  String? date;
  int? collector;
  dynamic amount;
  String? collectiondate;
  String? note;
  String? created;
  String? updated;
  int? deleted;
  String? name;
  String? phone;
  int? status;
  int? uid;
  String? firstname;
  String? lastname;
  String? apiKey;
  String? password;
  int? role;
  int? firm;
  int? branch;
  String? lastlogin;
  String? username;
  String? uidfullname;
  String? uidphone;
  String? type;

  CollectionRcvd(
      {this.id,
      this.date,
      this.collector,
      this.amount,
      this.collectiondate,
      this.note,
      this.created,
      this.updated,
      this.deleted,
      this.name,
      this.phone,
      this.status,
      this.uid,
      this.firstname,
      this.lastname,
      this.apiKey,
      this.password,
      this.role,
      this.firm,
      this.branch,
      this.lastlogin,
      this.username,
      this.uidfullname,
      this.uidphone,
      this.type});

  CollectionRcvd.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    collector = json['collector'];
    amount = json['amount'];
    collectiondate = json['collectiondate'];
    note = json['note'];
    created = json['created'];
    updated = json['updated'];
    deleted = json['deleted'];
    name = json['name'];
    phone = json['phone'];
    status = json['status'];
    uid = json['uid'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    apiKey = json['api_key'];
    password = json['password'];
    role = json['role'];
    firm = json['firm'];
    branch = json['branch'];
    lastlogin = json['lastlogin'];
    username = json['username'];
    uidfullname = json['uidfullname'];
    uidphone = json['uidphone'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['collector'] = this.collector;
    data['amount'] = this.amount;
    data['collectiondate'] = this.collectiondate;
    data['note'] = this.note;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['deleted'] = this.deleted;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['uid'] = this.uid;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['api_key'] = this.apiKey;
    data['password'] = this.password;
    data['role'] = this.role;
    data['firm'] = this.firm;
    data['branch'] = this.branch;
    data['lastlogin'] = this.lastlogin;
    data['username'] = this.username;
    data['uidfullname'] = this.uidfullname;
    data['uidphone'] = this.uidphone;
    data['type'] = this.type;
    return data;
  }
}
