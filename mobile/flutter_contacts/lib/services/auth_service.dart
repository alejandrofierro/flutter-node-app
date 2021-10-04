import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = '192.168.0.105:8000';

  final storage = new FlutterSecureStorage();

  Future<String?> login(String username, String password) async {
    final Map<String, dynamic> authData = {
      'username': username,
      'password': password
    };

    final url = Uri.http(_baseUrl, '/api/auth/login');

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(authData));

    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodedResp['token']);
      return null;
    } else {
      return decodedResp['msg'];
    }
  }

  //Logout method -> delete jwt
  Future logout() async {
    await storage.delete(key: 'token');
  }

  //Validation for jwt
  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
