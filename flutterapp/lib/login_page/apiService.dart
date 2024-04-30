import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkService {
  static const String baseUrl = 'http://localhost:8080/api/account';

  static Future<String> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return "Login successful";
    } else if (response.statusCode == 401) {
      // Check if response body contains error message
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('error')) {
        return responseBody['error'];
      } else {
        return "Invalid username or password";
      }
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<String> signUp(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return "success";
    } else if (response.statusCode == 422) {
      return "Please choose a different username";
    } else {
      throw Exception('Failed to sign up');
    }
  }
}
