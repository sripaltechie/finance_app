class creditorsListModel {
  List<CreditorsList>? creditorsList;

  creditorsListModel({this.creditorsList});

  creditorsListModel.fromJson(Map<String, dynamic> json) {
    if (json['creditors'] != null) {
      creditorsList = <CreditorsList>[];
      json['creditors'].forEach((v) {
        creditorsList!.add(new CreditorsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.creditorsList != null) {
      data['creditorsList'] =
          this.creditorsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreditorsList {
  int? customer;
  String? customername;
  dynamic intrate;
  dynamic amount;
  int? interest;
  String? lastintmonth;
  String? inttilldate;

  CreditorsList(
      {this.customer,
      this.customername,
      this.intrate,
      this.amount,
      this.interest,
      this.lastintmonth,
      this.inttilldate});

  CreditorsList.fromJson(Map<String, dynamic> json) {
    customer = json['customer'];
    customername = json['customername'];
    intrate = json['intrate'];
    amount = json['amount'];
    interest = json['interest'];
    lastintmonth = json['lastintmonth'];
    inttilldate = json['inttilldate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer'] = this.customer;
    data['customername'] = this.customername;
    data['intrate'] = this.intrate;
    data['amount'] = this.amount;
    data['interest'] = this.interest;
    data['lastintmonth'] = this.lastintmonth;
    data['inttilldate'] = this.inttilldate;
    return data;
  }
}
