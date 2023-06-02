import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginViewModel extends ChangeNotifier {
  String? token;

  Future<bool> login(String username, String password) async {
    const String apiUrl = "https://dummyjson.com/auth/login"; // Aquí va tu endpoint de login

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        "username": username,
        "password": password
      },
    );

    if (response.statusCode == 200) {
      final String responseString = response.body;

      // Aquí puedes manejar la respuesta. Por ejemplo, podrías decodificar un token JWT y almacenarlo para su uso posterior
      token = json.decode(responseString)['token'];
      // ignore: avoid_print
      print(token);

      return true;
    } else {
      // ignore: avoid_print
      print(response.statusCode);
      return false;
    }
  }
}
