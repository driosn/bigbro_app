import 'package:mibigbro/utils/key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mibigbro/utils/storage.dart';

class CalificacionProvider {
  static const String _BASEURL = Key.BASEURL;
  static String _token = StorageUtils.getString("token");

  static Future<http.Response> create(
      int puntos, String mensaje, int? idPoliza) async {
    String endpoint = "/api/calificacion/create/";

    final respuesta = http.post(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token'
      },
      body: jsonEncode(<String, dynamic>{
        "nro_calificacion": puntos,
        "opinion": mensaje,
        "poliza": idPoliza
      }),
    );

    return respuesta;
  }
}
