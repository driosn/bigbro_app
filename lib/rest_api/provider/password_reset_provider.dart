import 'package:mibigbro/utils/key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PasswordResetProvider {
  static const String _BASEURL = Key.BASEURL;
  static Future<http.Response> consultarEmail(String email) async {
    String endpoint = "/api/password_reset/buscar_email/";
    return http.post(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );
  }

  static Future<http.Response> consultarCodigo(
      int idUser, String codigo, String password) async {
    String endpoint = "/api/password_reset/cambiar_password/";
    return http.post(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id_user': idUser,
        'password': password,
        'codigo': codigo,
      }),
    );
  }

  static Future<String> sendRequest(String endpoint) async {
    final res = await http.get(Uri.parse(_BASEURL + endpoint));
    print(res.body);
    return res.body;
  }
}
