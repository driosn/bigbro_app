import 'dart:io';

import 'package:mibigbro/utils/key.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:mibigbro/utils/storage.dart';

class HomeProvider {
  static const String _BASEURL = Key.BASEURL;
  static String _token = StorageUtils.getString("token");

  static Future<http.Response> cargarDatos(
      String idUsuario, String estado) async {
    String endpoint = "/api/user/home/$idUsuario?poliza=$estado";
    print(endpoint);
    final respuesta = await http.get(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token'
      },
    );
    return respuesta;
  }
}
