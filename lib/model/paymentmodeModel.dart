class PaymentmodeModel {
  int? id;
  int? paymentmode;
  String? modename;
  int? opbal;
  int? credit;
  int? debit;

  PaymentmodeModel(
      {this.id,
      this.paymentmode,
      this.modename,
      this.opbal,
      this.credit,
      this.debit});

  PaymentmodeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentmode = json['paymentmode'];
    modename = json['modename'];
    opbal = json['opbal'];
    credit = json['credit'];
    debit = json['debit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['paymentmode'] = paymentmode;
    data['modename'] = modename;
    data['opbal'] = opbal;
    data['credit'] = credit;
    data['debit'] = debit;
    return data;
  }
}
