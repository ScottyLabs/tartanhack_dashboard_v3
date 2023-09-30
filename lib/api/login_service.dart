import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'package:tartanhacks_dashboard_v3/env.dart' as env;

class LoginService {
  static Map<String, String> headers = {"Content-type": "application/json"};

  static Future<User> checkCredentials(String email, String password) async {
    String body = json.encode({
      'email': email,
      'password': password,
    });

    Uri uri = Uri.https(env.baseUrl, 'auth/login');
    final response = await http.post(uri, body: body, headers: headers);
    if (response.statusCode == 200) {
      User loginData;
      var data = json.decode(response.body);
      loginData = User.fromJson(data);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user', json.encode(data));

      return loginData;
    } else {
      return Future.error('${response.statusCode}: ${response.body}');
    }
  }

  Future<bool> resetPassword(String email) async {
    String body = json.encode({
      'email': email
    });

    Uri uri = Uri.https(env.baseUrl, 'auth/request-reset');
    final response = await http.post(uri, body: body, headers: headers);
    return response.statusCode == 200;
  }
}