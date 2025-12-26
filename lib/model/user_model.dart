import 'package:flutter/material.dart';

class UserModel {
  String? uid;
  String? apiKey;
  String? collector;
  String? name;
  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  String? role;
  String? branch;
  String? rolename;
  String? firm;

  UserModel(
      {this.uid,
      this.apiKey,
      this.collector,
      this.name,
      this.firstname,
      this.lastname,
      this.phone,
      this.email,
      this.role,
      this.branch,
      this.rolename,
      this.firm});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    apiKey = json['api_key'];
    collector = json['collector'];
    name = json['name'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    email = json['email'];
    role = json['role'];
    branch = json['branch'];
    rolename = json['rolename'];
    firm = json['firm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['api_key'] = apiKey;
    data['collector'] = collector;
    data['name'] = name;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['phone'] = phone;
    data['email'] = email;
    data['role'] = role;
    data['branch'] = branch;
    data['rolename'] = rolename;
    data['firm'] = firm;
    return data;
  }
}
