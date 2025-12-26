class DaybookPaymentmodeModel {
  int? id;
  String? name;
  int? amt;

  DaybookPaymentmodeModel({this.id, this.name, this.amt});

  DaybookPaymentmodeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amt = json['amt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['amt'] = amt;
    return data;
  }
}
