class YesNoModel {
  List<Yesno>? yesno;

  YesNoModel({this.yesno});

  YesNoModel.fromJson(Map<String, dynamic> json) {
    if (json['yesno'] != null) {
      yesno = <Yesno>[];
      json['yesno'].forEach((v) {
        yesno!.add(new Yesno.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.yesno != null) {
      data['yesno'] = this.yesno!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Yesno {
  String? id;
  String? name;

  Yesno({this.id, this.name});

  Yesno.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
