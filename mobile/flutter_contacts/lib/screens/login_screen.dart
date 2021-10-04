import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/providers/login_form_provider.dart';
import 'package:flutter_contacts/services/auth_service.dart';
import 'package:flutter_contacts/services/services.dart';
import 'package:flutter_contacts/ui/input_decorations.dart';
import 'package:flutter_contacts/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          // color: Color(0xff615AAB),
          child: LoginBackground(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                  ),
                  CardContainer(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ChangeNotifierProvider(
                          create: (_) => LoginFormProvider(),
                          child: _LoginForm(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Create New Account',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
          )),
    ));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              onChanged: (value) => loginForm.username = value,
              decoration: InputDecorations.loginInputDecoration(
                  hintText: 'Username',
                  labelText: 'User',
                  prefixIcon: Icons.person_outline),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              onChanged: (value) => loginForm.password = value,
              decoration: InputDecorations.loginInputDecoration(
                  hintText: '*****',
                  labelText: 'Password',
                  prefixIcon: Icons.lock_outline),
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authService =
                          Provider.of<AuthService>(context, listen: false);
                      if (!loginForm.isValidForm()) return;
                      loginForm.isLoading = false;

                      final String? errorMsg = await authService.login(
                          loginForm.username, loginForm.password);

                      if (errorMsg == null) {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        NotifyService.showSnackBar(errorMsg, Colors.red);
                        print(errorMsg);
                        loginForm.isLoading = false;
                      }
                    },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
