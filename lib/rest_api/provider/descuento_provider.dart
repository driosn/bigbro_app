import 'package:mibigbro/utils/key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DescuentoProvider {
  static const String _BASEURL = Key.BASEURL;

  static Future<http.Response> crearDeuda(
      String idUser, String codigoDescuento) async {
    String endpoint =
        "/api/descuento/buscardescuento?id_user=$idUser&codigo=$codigoDescuento";
    print(_BASEURL + endpoint);
    final respuesta = await http.get(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return respuesta;
  }
}
