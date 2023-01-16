import 'package:mibigbro/models/motorizadoModel.dart';
import 'package:mibigbro/utils/key.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:mibigbro/utils/storage.dart';

class TarifadorProvider {
  static const String _BASEURL = Key.BASEURL;
  static String _token = StorageUtils.getString("token");

  static Future<http.Response> getPaquetes(String? valor, int? ciudad, int? uso,
      String coberturas, String franquicia) async {
    String nombreCiudad;
    String nombreUso;

    nombreCiudad = obtenerCiudad(ciudad);
    nombreUso = obtenerUso(uso);

    String url =
        '/api/tarifador/paqueteresumenbs?valor=$valor&ciudad=$nombreCiudad&uso=$nombreUso&coberturas=$coberturas&franquicia=$franquicia';
    final respuesta = await http.get(Uri.parse(_BASEURL + url));
    return respuesta;
  }

  static Future<http.Response> getPaquetesNuevo(
      int valor, int? renovacion) async {
    String endpoint = "/api/stocks/rater";
    return http.post(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token'
      },
      body: jsonEncode(<String, Object?>{
        'renovation_number': renovacion,
        'insured_value': valor,
      }),
    );
  }

  static Future<http.Response> getPaquetesStocksQuotes(
      motorizadoModel datosMotorizado) async {
    final brandId = datosMotorizado.marca!;
    final cityId = datosMotorizado.ciudad!;
    final modelId = datosMotorizado.modelo!;
    final useId = datosMotorizado.uso!;
    final valorId = datosMotorizado.valor;
    final renovacion = datosMotorizado.nroRenovacion;

    String endpoint =
        '/api/stocks/quotes?city=$cityId&branch=$brandId&model=$modelId&use=$useId&insured_value=$valorId&renovation=$renovacion';

    return http.get(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token'
      },
    );
  }

  static Future<http.Response> getPaquetesCredito(String? valor, int? ciudad,
      int? uso, String? coberturas, String? franquicia, String? periodo) async {
    String nombreCiudad;
    String nombreUso;

    nombreCiudad = obtenerCiudad(ciudad);
    nombreUso = obtenerUso(uso);

    String url =
        '/api/tarifador/paqueteresumenbs?valor=$valor&ciudad=$nombreCiudad&uso=$nombreUso&coberturas=$coberturas&franquicia=$franquicia&modalidad=$periodo';
    final respuesta = await http.get(Uri.parse(_BASEURL + url));
    return respuesta;
  }

  static Future<http.Response> getDiasPorMonto(String? valor, int? ciudad,
      int? uso, String coberturas, String franquicia, String? monto) async {
    String nombreCiudad;
    String nombreUso;

    nombreCiudad = obtenerCiudad(ciudad);
    nombreUso = obtenerUso(uso);

    String url =
        '/api/tarifador/monto?valor=$valor&ciudad=$nombreCiudad&uso=$nombreUso&coberturas=$coberturas&franquicia=$franquicia&monto=$monto';
    final respuesta = await http.get(Uri.parse(_BASEURL + url));
    return respuesta;
  }

  static Future<http.Response> getMontoPorDias(String? valor, int? ciudad,
      int? uso, String coberturas, String franquicia, String? dias) async {
    String nombreCiudad;
    String nombreUso;

    nombreCiudad = obtenerCiudad(ciudad);
    nombreUso = obtenerUso(uso);

    String url =
        '/api/tarifador/dias?valor=$valor&ciudad=$nombreCiudad&uso=$nombreUso&coberturas=$coberturas&franquicia=$franquicia&dias=$dias';
    final respuesta = await http.get(
      Uri.parse(_BASEURL + url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token'
      },
    );
    return respuesta;
  }

  static String obtenerCiudad(int? ciudad) {
    String nombreCiudad;
    switch (ciudad) {
      case 1:
        {
          nombreCiudad = "BENI";
        }
        break;
      case 2:
        {
          nombreCiudad = "CHUQUISACA";
        }
        break;
      case 3:
        {
          nombreCiudad = "COCHABAMBA";
        }
        break;
      case 4:
        {
          nombreCiudad = "LAPAZ";
        }
        break;
      case 5:
        {
          nombreCiudad = "ORURO";
        }
        break;
      case 6:
        {
          nombreCiudad = "PANDO";
        }
        break;
      case 7:
        {
          nombreCiudad = "POTOSI";
        }
        break;
      case 8:
        {
          nombreCiudad = "SANTACRUZ";
        }
        break;
      case 9:
        {
          nombreCiudad = "TARIJA";
        }
        break;
      default:
        {
          nombreCiudad = "LAPAZ";
        }
        break;
    }

    return nombreCiudad;
  }

  static String obtenerUso(int? uso) {
    String nombreUso;
    switch (uso) {
      case 1:
        {
          nombreUso = "PARTICULAR";
        }
        break;
      case 2:
        {
          nombreUso = "PUBLICO";
        }
        break;
      default:
        {
          nombreUso = "PARTICULAR";
        }
        break;
    }

    return nombreUso;
  }
}
