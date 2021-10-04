import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  //Global key -> Login Form
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String username = '';
  String password = '';
  bool isLoading = false;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
