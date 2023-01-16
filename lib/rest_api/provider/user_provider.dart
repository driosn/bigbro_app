import 'package:mibigbro/utils/key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider {
  static const String _BASEURL = Key.BASEURL;

  static Future<http.Response> createUser(
      String endpoint, String email, String password) async {
    return http.post(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'name': email,
      }),
    );
  }

  static Future<String> sendRequest(String endpoint) async {
    final res = await http.get(Uri.parse(_BASEURL + endpoint));
    print(res.body);
    return res.body;
  }
}
