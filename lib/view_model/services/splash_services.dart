// import 'dart:html';
// import 'dart:js';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chanda_finance/model/user_model.dart';
import 'package:chanda_finance/utils/routes_name.dart';
import 'package:chanda_finance/view_model/user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      if (value.uid == null || value.uid == '') {
        // Navigator.pushNamed(context, RoutesName.login);
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushReplacementNamed(context, RoutesName.login);
      } else {
        await Future.delayed(const Duration(seconds: 2));
        // Navigator.pushNamed(context, RoutesName.home);
        Navigator.pushReplacementNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
