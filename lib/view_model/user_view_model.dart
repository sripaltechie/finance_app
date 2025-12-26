import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chanda_finance/model/user_model.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    var userjson = jsonEncode(user.toJson());
    sp.setString('user', userjson);
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    var res = sp.getString('user');
    if (res != null && res != '') {
      UserModel user = UserModel.fromJson(jsonDecode(res.toString()));
      return user;
    }

    return UserModel();
  }

  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.clear();
  }
}
