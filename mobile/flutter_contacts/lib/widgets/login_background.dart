import 'package:flutter/material.dart';
import 'package:flutter_contacts/widgets/widgets.dart';

class LoginBackground extends StatelessWidget {
  final Widget child;

  const LoginBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0x7303c0),
        child: Stack(children: [DiagonalHeader(), _HeaderIcon(), this.child]));
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 30.0),
      child: Icon(
        Icons.person_pin_circle,
        color: Colors.white,
        size: 100,
      ),
    );
  }
}
