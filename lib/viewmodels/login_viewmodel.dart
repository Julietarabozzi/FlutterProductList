// login_view_model.dart

import 'package:flutter/material.dart';
import '../Services/login_service.dart';

class LoginViewModel extends ChangeNotifier {
  String? token;
  final LoginService loginService;

  LoginViewModel({required this.loginService});

  Future<bool> login(String username, String password) async {
    try {
      token = await loginService.login(username, password);
      print(token);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
