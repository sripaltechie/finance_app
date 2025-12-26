import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chanda_finance/view_model/auth_view_model.dart';

import '../res/components/round_button.dart';
import '../utils/routes_name.dart';
import '../utils/utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _email.dispose();
    _password.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text("Login"))),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: emailFocusNode,
                  decoration: const InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email)),
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, emailFocusNode, passwordFocusNode);
                  },
                ),
                ValueListenableBuilder(
                    valueListenable: _obsecurePassword,
                    builder: (context, value, child) {
                      return TextFormField(
                          controller: _password,
                          obscureText: _obsecurePassword.value,
                          focusNode: passwordFocusNode,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_open_outlined),
                            suffixIcon: InkWell(
                                onTap: () {
                                  _obsecurePassword.value =
                                      !_obsecurePassword.value;
                                },
                                child: Icon(_obsecurePassword.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility)),
                          ));
                    }),
                SizedBox(
                  height: height * 0.1,
                ),
                RoundButton(
                  title: 'Login',
                  loading: authViewModel.loading,
                  onPress: () {
                    if (_email.text.isEmpty) {
                      Utils.flushBarErrorMessage('Please Enter Email', context);
                    } else if (_password.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          'Please Enter Password', context);
                    } else if (_password.text.length < 6) {
                      Utils.flushBarErrorMessage(
                          'Please Enter 6 digit password', context);
                    } else {
                      Map data = {
                        "name": _email.text.toString(),
                        "password": _password.text.toString()
                      };
                      // Map data = {"name": "sowj", "password": "123456"};

                      authViewModel.loginApi(data, context);
                      // Utils.showToast('api hit', "success", context);
                      // toast.success('Api Hit', context);
                    }
                  },
                ),
                SizedBox(height: height * .02),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, RoutesName.signUp),
                  child: const Text("Don't have an account? Sign Up"),
                )
              ]),
        ));
  }
}


//https://pub.dev/packages/cached_network_image