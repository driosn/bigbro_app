import 'dart:io';

import 'package:mibigbro/utils/key.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:mibigbro/utils/storage.dart';

class MotorizadoProvider {
  static const String _BASEURL = Key.BASEURL;
  static String _token = StorageUtils.getString("token");

  static Future<http.Response> createMotorizado(
      double valorAsegurado,
      int usuario,
      int? uso,
      int? ciudad,
      int? modelo,
      int? year,
      String otroModelo) async {
    String endpoint = "/api/automovil/create/";
    final respuesta = await http.post(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token'
      },
      body: jsonEncode(<String, dynamic>{
        "valor_asegurado": valorAsegurado,
        "usuario": usuario,
        "uso": uso,
        "otro_modelo": otroModelo,
        "ciudad": ciudad,
        "clase": 1,
        "modelo": modelo,
        "year": year
      }),
    );

    return respuesta;
  }

  static Future<http.Response> updateMotorizado(
      String idAuto,
      double valorAsegurado,
      int usuario,
      int uso,
      int ciudad,
      int modelo,
      int year,
      String otroModelo) async {
    String endpoint = "/api/automovil/update/$idAuto";
    final respuesta = await http.put(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token'
      },
      body: jsonEncode(<String, dynamic>{
        "valor_asegurado": valorAsegurado,
        "usuario": usuario,
        "uso": uso,
        "otro_modelo": otroModelo,
        "ciudad": ciudad,
        "modelo": modelo,
        "year": year
      }),
    );

    return respuesta;
  }

  static Future<Response?> actulizarAutoInspeccion(
      String idAuto,
      File ruat,
      String placa,
      String chasis,
      String color,
      String motor,
      String asientos,
      String cilindrada,
      String toneladas) async {
    var dio = Dio();
    String ruatName = ruat.path.split('/').last;
    String endpoint = "/api/automovil/update/$idAuto";
    print(ruat.path);
    FormData formData = new FormData.fromMap({
      "placa": placa,
      "chasis": chasis,
      "color": color,
      "motor": motor,
      "asientos_nro": asientos,
      "cilindrada": cilindrada,
      "toneladas": toneladas,
      "ruat": await MultipartFile.fromFile(ruat.path, filename: ruatName),
    });
    dio.options.headers["Authorization"] = "Token $_token";
    Response response = await dio.patch(_BASEURL + endpoint, data: formData);
    if (response.statusCode == 400) {
      return null;
    }
    return response;
  }

  static Future<Response?> fotosInspeccionPantalla2(
    String idAuto,
    File frontal,
    File trasero,
  ) async {
    var dio = Dio();
    String frontalName = frontal.path.split('/').last;
    String traceroName = trasero.path.split('/').last;

    String endpoint = "/api/inspeccion/create/";

    FormData formData = new FormData.fromMap({
      "automovil": idAuto,
      "foto_frontal":
          await MultipartFile.fromFile(frontal.path, filename: frontalName),
      "foto_trasero":
          await MultipartFile.fromFile(frontal.path, filename: traceroName),
    });
    dio.options.headers["Authorization"] = "Token $_token";
    Response response = await dio.post(_BASEURL + endpoint, data: formData);
    if (response.statusCode == 400) {
      return null;
    }
    return response;
  }

  static Future<Response?> fotosInspeccion(
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
    dio.options.headers["Authorization"] = "Token $_token";
    Response response = await dio.post(_BASEURL + endpoint, data: formData);
    if (response.statusCode == 400) {
      return null;
    }
    return response;
  }

  static Future<Response?> fotosInspeccionFrontalTrasera(
      String idAuto, File frontal, File trasero) async {
    var dio = Dio();
    String frontalName = frontal.path.split('/').last;
    String traceroName = trasero.path.split('/').last;
    String endpoint = "/api/inspeccion/create/";
    FormData formData = new FormData.fromMap({
      "automovil": idAuto,
      "foto_frontal":
          await MultipartFile.fromFile(frontal.path, filename: frontalName),
      "foto_trasero":
          await MultipartFile.fromFile(frontal.path, filename: traceroName),
    });
    dio.options.headers["Authorization"] = "Token $_token";
    Response response = await dio.post(_BASEURL + endpoint, data: formData);
    if (response.statusCode == 400) {
      return null;
    }
    return response;
  }

  static Future fotosInspeccionLateral(String idAuto, String idInspeccion,
      File lateralIzquierda, File lateralDerecho) async {
    var dio = Dio();
    String lateralIzquierdaName = lateralIzquierda.path.split('/').last;
    String lateralDerechoName = lateralDerecho.path.split('/').last;
    String endpoint = "/api/inspeccion/update/$idInspeccion";
    FormData formData = new FormData.fromMap({
      "automovil": idAuto,
      "lateral_izq": await MultipartFile.fromFile(lateralIzquierda.path,
          filename: lateralIzquierdaName),
      "lateral_der": await MultipartFile.fromFile(lateralDerecho.path,
          filename: lateralDerechoName),
    });

    try {
      print(_BASEURL + endpoint);
      dio.options.headers["Authorization"] = "Token $_token";
      Response response = await dio.put(_BASEURL + endpoint, data: formData);
      return response.statusCode;
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        print(e.response!.statusCode);
        print(e.response!.data);
      } else {
        print(e.message);
      }
    }
    return 400;
  }

  static Future fotosInspeccionTablero(
      String idAuto, String idInspeccion, File? damage, File tablero) async {
    var dio = Dio();

    String tableroName = tablero.path.split('/').last;
    String endpoint = "/api/inspeccion/update/$idInspeccion";

    var datosEnviar = {
      "automovil": idAuto,
      "tablero":
          await MultipartFile.fromFile(tablero.path, filename: tableroName),
    };

    if (damage != null) {
      String damageName = damage.path.split('/').last;
      datosEnviar["damage"] =
          await MultipartFile.fromFile(damage.path, filename: damageName);
    }
    FormData formData = new FormData.fromMap(datosEnviar);

    try {
      print(_BASEURL + endpoint);
      dio.options.headers["Authorization"] = "Token $_token";
      Response response = await dio.put(_BASEURL + endpoint, data: formData);
      return response.statusCode;
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        print(e.response!.statusCode);
        print(e.response!.data);
      } else {
        print(e.message);
      }
    }
    return 400;
  }

  static Future fotosInspeccionObservadas(
      String idAuto,
      String idInspeccion,
      File frontal,
      File trasero,
      File lateralIzquierda,
      File lateralDerecho,
      File velocimetro,
      File llanta,
      File tablero) async {
    var dio = Dio();

    String endpoint = "/api/inspeccion/update/$idInspeccion";
    Map<String, dynamic> datosEnviar = {"automovil": idAuto};

    if (frontal != null) {
      String frontalName = frontal.path.split('/').last;
      datosEnviar["foto_frontal"] =
          await MultipartFile.fromFile(frontal.path, filename: frontalName);
    }

    if (trasero != null) {
      String traseroName = trasero.path.split('/').last;
      datosEnviar["foto_trasero"] =
          await MultipartFile.fromFile(trasero.path, filename: traseroName);
    }

    if (lateralIzquierda != null) {
      String laterialIzquierdoName = lateralIzquierda.path.split('/').last;
      datosEnviar["lateral_izq"] = await MultipartFile.fromFile(
          lateralIzquierda.path,
          filename: laterialIzquierdoName);
    }

    if (lateralDerecho != null) {
      String lateralDerechoName = lateralDerecho.path.split('/').last;
      datosEnviar["lateral_der"] = await MultipartFile.fromFile(
          lateralDerecho.path,
          filename: lateralDerechoName);
    }

    if (velocimetro != null) {
      String velocimetroName = velocimetro.path.split('/').last;
      datosEnviar["velocimetro"] = await MultipartFile.fromFile(
          velocimetro.path,
          filename: velocimetroName);
    }

    if (llanta != null) {
      String llantaName = llanta.path.split('/').last;
      datosEnviar["llanta"] =
          await MultipartFile.fromFile(llanta.path, filename: llantaName);
    }

    if (tablero != null) {
      String tableroName = tablero.path.split('/').last;
      datosEnviar["tablero"] =
          await MultipartFile.fromFile(tablero.path, filename: tableroName);
    }

    try {
      FormData formData = new FormData.fromMap(datosEnviar);
      dio.options.headers["Authorization"] = "Token $_token";
      Response response = await dio.put(_BASEURL + endpoint, data: formData);
      print(response);
      print(response.data);
      return response.statusCode;
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        print(e.response!.statusCode);
        print(e.response!.data);
      } else {
        print(e.message);
        // print(e.request);
      }
    }
    return 400;
  }

  static Future<http.Response> autosByIdUser(String idUsuario) async {
    String endpoint = "/api/poliza/lista_renovar/?id_user=$idUsuario";
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

  static Future<http.Response> actualizarValor(
      String valorAsegurado, int? idAuto) async {
    String endpoint = "/api/automovil/update/$idAuto";
    final respuesta = await http.patch(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token'
      },
      body: jsonEncode(<String, dynamic>{
        "valor_asegurado": valorAsegurado,
      }),
    );

    return respuesta;
  }

  static Future<http.Response> detalle(int? idAutomoivl) async {
    String id = idAutomoivl.toString();

    String url = '/api/automovil/detail/$id';
    print(url);
    final respuesta = await http.get(Uri.parse(_BASEURL + url));
    return respuesta;
  }

  static Future<http.Response> getDatos(String endpoint) async {
    print(_BASEURL + endpoint);
    final respuesta = await http.get(
      Uri.parse(_BASEURL + endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $_token'
      },
    );
    return respuesta;
  }
}
