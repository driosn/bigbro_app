import 'dart:io';

import 'package:mibigbro/models/motorizadoModel.dart';
import 'package:mibigbro/utils/key.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:mibigbro/utils/storage.dart';

class PolizaProvider {
  static const String _BASEURL = Key.BASEURL;
  static String _token = StorageUtils.getString("token");

  static Future<http.Response> create(motorizadoModel motorizado) async {
    String endpoint = "/api/poliza/create/";
    String producto = "PAQUETE";
    if (motorizado.tipoCotizacion == "PRECIOAMEDIDA") {
      producto = "POR MONTO";
    }
    if (motorizado.tipoCotizacion == "DIASAMEDIDA") {
      producto = "POR DIAS";
    }
    final respuesta = http.post(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "vigencia_inicio": motorizado.inicioVigencia,
        "vigencia_final": motorizado.finVigencia,
        "nro_dias": motorizado.nroDias,
        "coberturas": motorizado.coberturas,
        "usuario": motorizado.idUser,
        "datos_personales": motorizado.idUser,
        "automovil": motorizado.idAutomovil,
        "inspeccion": motorizado.idInspeccion,
        "compania": motorizado.idCompania,
        "url_slip": motorizado.urlSlip,
        "nro_renovacion": motorizado.nroRenovacion
      }),
    );

    return respuesta;
  }

  static Future<http.Response> detalle(int idPoliza) async {
    String id = idPoliza.toString();

    String url = '/api/poliza/detail/$id';
    print(url);
    final respuesta = await http.get(
      Uri.parse(_BASEURL + url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token'
      },
    );
    return respuesta;
  }

  static Future<http.Response> polizasByIdUser(
      String idUsuario, String estado) async {
    String endpoint = "/api/poliza/lista/?id_user=$idUsuario&estado=$estado";

    final respuesta = await http.get(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token'
      },
    );
    return respuesta;
  }

  static Future<http.Response> traerTodasLasPolizasPorIdUser(
      String idUsuario) async {
    String endpoint = "/api/poliza/lista/?id_user=$idUsuario";
    final respuesta = await http.get(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token'
      },
    );
    return respuesta;
  }

  static Future<http.Response> polizasPorEstado(
      String idUsuario, String estado) async {
    String endpoint = "/api/poliza/lista/?id_user=$idUsuario&estado=$estado";

    final respuesta = await http.get(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token'
      },
    );
    return respuesta;
  }

  static Future<http.Response> anularPoliza(
      String idUsuario, String motivo) async {
    String endpoint = "/api/poliza/anular/$idUsuario";
    final respuesta = http.post(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token'
      },
      body: jsonEncode(<String, dynamic>{"motivo": motivo}),
    );

    return respuesta;
  }

  static Future<http.Response> pagarPrimeraCuota(
      String idPoliza, String idDescuento) async {
    String endpoint = "/api/transaccion/pagoprimeradeuda?poliza=$idPoliza";
    if (int.parse(idDescuento) != 0) {
      endpoint =
          "/api/transaccion/pagoprimeradeuda?poliza=$idPoliza&id_descuento=$idDescuento";
    }
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

  static Future<http.Response> simularPago(String idTransaccion) async {
    String endpoint =
        "/api/transaccion/respuesta?transaction_id=$idTransaccion&error=0&message=OK&cancel_order=0&prueba=TRUE";
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

  static Future<http.Response> pagarIdCuota(
      String idUser, String idDeuda) async {
    String endpoint = "/api/deuda/cobrar/$idUser?deudas=$idDeuda";

    final respuesta = await http.get(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token'
      },
    );
    return respuesta;
  }

  static Future<http.Response> deudasByIdUser(
      String idUsuario, String estado, String marca) async {
    String endpoint = "/api/deuda/list/?id_user=$idUsuario&estado=$estado";
    if (marca != "") {
      endpoint =
          "/api/deuda/list/?id_user=$idUsuario&estado=$estado&marca=$marca";
    }

    ///api/deuda/list/?id_user=2&marca=volks&estado=PENDIENTE
    print(_BASEURL + endpoint);
    final respuesta = await http.get(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token'
      },
    );
    return respuesta;
  }

  static Future<http.Response> generarSlip(motorizadoModel motorizado) async {
    String endpoint = "/api/poliza/slip/";
    final respuesta = http.post(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token'
      },
      body: jsonEncode(<String, dynamic>{
        "vigencia_inicio": motorizado.inicioVigencia,
        "vigencia_fin": motorizado.finVigencia,
        "id_stock": motorizado.idStock,
        "id_auto": motorizado.idAutomovil,
        "id_datos_personales": motorizado.idUser,
        "prima": double.parse(motorizado.costo ?? '0.0') / 6.96,
      }),
    );

    return respuesta;
  }

  static Future<http.Response> descargarCertificado(int? idPoliza) async {
    String id = idPoliza.toString();
    String endpoint = "/api/alianza/descargar_certificado/?id_poliza=$id";

    print(_BASEURL + endpoint);
    final respuesta = await http.get(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token'
      },
    );
    return respuesta;
  }

  /* static Future<Response> actulizarAutoInspeccion(
      String idAuto, File ruat, String placa) async {
    var dio = Dio();
    String ruatName = ruat.path.split('/').last;
    String endpoint = "/api/automovil/update/$idAuto";
    print(ruat.path);
    FormData formData = new FormData.fromMap({
      "placa": placa,
      "ruat": await MultipartFile.fromFile(ruat.path, filename: ruatName),
    });
    Response response = await dio.patch(_BASEURL + endpoint, data: formData);
    if (response.statusCode == 400) {
      return null;
    }
    return response;
  }

  static Future<Response> fotosInspeccion(
      String idAuto,
      File frontal,
      File trasero,
      File lateralIzquierdo,
      File lateralDerecho,
      File velocimetro,
      File llanta,
      File tablero) async {
    var dio = Dio();
    String frontalName = frontal.path.split('/').last;
    String traceroName = trasero.path.split('/').last;
    String laterialIzquierdoName = lateralIzquierdo.path.split('/').last;
    String lateralDerechoName = lateralDerecho.path.split('/').last;
    String velocimetroName = velocimetro.path.split('/').last;
    String llantaName = llanta.path.split('/').last;
    String tableroName = tablero.path.split('/').last;

    String endpoint = "/api/inspeccion/create/";

    FormData formData = new FormData.fromMap({
      "automovil": idAuto,
      "foto_frontal":
          await MultipartFile.fromFile(frontal.path, filename: frontalName),
      "foto_trasero":
          await MultipartFile.fromFile(frontal.path, filename: traceroName),
      "lateral_izq": await MultipartFile.fromFile(frontal.path,
          filename: laterialIzquierdoName),
      "lateral_der": await MultipartFile.fromFile(frontal.path,
          filename: lateralDerechoName),
      "velocimetro":
          await MultipartFile.fromFile(frontal.path, filename: velocimetroName),
      "llanta":
          await MultipartFile.fromFile(frontal.path, filename: llantaName),
      "tablero":
          await MultipartFile.fromFile(tablero.path, filename: tableroName),
    });
    Response response = await dio.post(_BASEURL + endpoint, data: formData);
    if (response.statusCode == 400) {
      return null;
    }
    return response;
  }

  static Future<http.Response> getDatos(String endpoint) async {
    final respuesta = await http.get(_BASEURL + endpoint);
    return respuesta;
  } */
}
