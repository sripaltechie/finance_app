import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chanda_finance/utils/routes_name.dart';

import '../res/components/round_button.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
final TextEditingController _userName = TextEditingController();
final TextEditingController _firstName = TextEditingController();
final TextEditingController _lastName = TextEditingController();
final TextEditingController _phone = TextEditingController();
final TextEditingController _email = TextEditingController();
final TextEditingController _password = TextEditingController();
FocusNode userNameFocusNode = FocusNode();
FocusNode firstNameFocusNode = FocusNode();
FocusNode lastNameFocusNode = FocusNode();
FocusNode phoneFocusNode = FocusNode();
FocusNode emailFocusNode = FocusNode();
FocusNode passwordFocusNode = FocusNode();

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text("SignUp"))),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _userName,
                  keyboardType: TextInputType.text,
                  focusNode: userNameFocusNode,
                  decoration: const InputDecoration(
                      hintText: 'User Name',
                      labelText: 'User Name',
                      prefixIcon: Icon(Icons.verified_user)),
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, userNameFocusNode, firstNameFocusNode);
                  },
                ),
                TextFormField(
                  controller: _firstName,
                  keyboardType: TextInputType.text,
                  focusNode: firstNameFocusNode,
                  decoration: const InputDecoration(
                      hintText: 'First Name',
                      labelText: 'First Name',
                      prefixIcon: Icon(Icons.person)),
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, firstNameFocusNode, lastNameFocusNode);
                  },
                ),
                TextFormField(
                  controller: _lastName,
                  keyboardType: TextInputType.text,
                  focusNode: lastNameFocusNode,
                  decoration: const InputDecoration(
                      hintText: 'Last Name',
                      labelText: 'Last Name',
                      prefixIcon: Icon(Icons.person)),
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, lastNameFocusNode, phoneFocusNode);
                  },
                ),
                TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  focusNode: phoneFocusNode,
                  decoration: const InputDecoration(
                      hintText: 'Phone No.',
                      labelText: 'Phone No.',
                      prefixIcon: Icon(Icons.person)),
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, phoneFocusNode, emailFocusNode);
                  },
                ),
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
                  height: height * 0.05,
                ),
                RoundButton(
                  title: 'Sign Up',
                  loading: authViewModel.signUpLoading,
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
                        "name": _userName.text.toString(),
                        "firstname": _firstName.text.toString(),
                        "lastname": _lastName.text.toString(),
                        "phone": _phone.text.toString(),
                        "email": _email.text.toString(),
                        "password": _password.text.toString()
                      };
                      authViewModel.signUpApi(data, context);

                      // toast.success('Api Hit', context);
                    }
                  },
                ),
                SizedBox(height: height * .02),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, RoutesName.login),
                  child: const Text("Already have an account? Login"),
                )
              ]),
        ));
  }
}
