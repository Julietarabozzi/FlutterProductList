// login_view_model.dart

// login_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginService {
  Future<String?> login(String username, String password) async {
    const String apiUrl = "https://dummyjson.com/auth/login"; 

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        "username": username,
        "password": password
      },
    );

    if (response.statusCode == 200) {
      final String responseString = response.body;
      return json.decode(responseString)['token'];
    } else {
      throw Exception('Failed to login');
    }
  }
}
