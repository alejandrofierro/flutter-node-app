import 'package:flutter/material.dart';

class NotifyService {
  //Globalkey
  static late GlobalKey<ScaffoldMessengerState> messengerKey =
      new GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String message, [Color color = Colors.white]) {
    final snackbar = new SnackBar(
      content: Text(message),
      backgroundColor: color,
    );

    messengerKey.currentState!.showSnackBar(snackbar);
  }
}
