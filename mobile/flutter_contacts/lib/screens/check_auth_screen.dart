import 'package:flutter/material.dart';
import 'package:flutter_contacts/services/auth_service.dart';
import 'package:provider/provider.dart';

class CheckAuthScren extends StatelessWidget {
  const CheckAuthScren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
        body: Center(
      child: FutureBuilder(
        future: authService.readToken(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) return Center(child: Text('Waiting...'));

          Future.microtask(() {
            Navigator.of(context).pushReplacementNamed('/login');
          });

          return Container();
        },
      ),
    ));
  }
}
