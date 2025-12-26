import 'package:chanda_finance/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../repository/auth_repository.dart';
import '../utils/routes_name.dart';
import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myrepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myrepo.loginApi(data).then((value) {
      setLoading(false);
      if (value.Apistatus == "success") {
        UserModel user = UserModel.fromJson(value.data['session']);
        final userPreference =
            Provider.of<UserViewModel>(context, listen: false);
        userPreference.saveUser(user);
        Utils.showResponseToast(value, context);
        Navigator.pushReplacementNamed(context, RoutesName.home);
        if (kDebugMode) {
          print(value.toString());
        }
      } else {
        Utils.showResponseToast(value, context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    _myrepo.signUpApi(data).then((dynamic value) {
      setSignUpLoading(false);
      if (value['status'] == "success") {
        Utils.showToast(value["message"], "success", context);
        Navigator.pushNamed(context, RoutesName.login);
        if (kDebugMode) {
          print(value.toString());
        }
      } else {
        Utils.showResponseToast(value, context);
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }
}
