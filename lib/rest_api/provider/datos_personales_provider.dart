import 'dart:io';

import 'package:mibigbro/utils/key.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:mibigbro/utils/storage.dart';
import 'package:path_provider/path_provider.dart';

class DatosPersonalesProvider {
  static const String _BASEURL = Key.BASEURL;
  static String _token = StorageUtils.getString("token");

  static Future<http.Response> buscar(String idUsuario) async {
    String endpoint = "/api/datos_personales/usuario_id/$idUsuario";
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

  static Future<http.Response> create(
      String nombre,
      String apPaterno,
      String apMaterno,
      String? tipoDocumento,
      String nroDocumento,
      String? extDocumento,
      String fechaNacimiento,
      String? genero,
      String? estadoCivil,
      String telefono,
      String direccion,
      int? ocupacion,
      String actividad,
      int usuario,
      int? pais,
      int? ciudad,
      String nacionalidad) async {
    String endpoint = "/api/datos_personales/create/";

    final respuesta = http.post(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token'
      },
      body: jsonEncode(<String, dynamic>{
        "nombre": nombre,
        "apellido_paterno": apPaterno,
        "apellido_materno": apMaterno,
        "tipo_documento": tipoDocumento,
        "numero_documento": nroDocumento,
        "extension": extDocumento,
        "fecha_nacimiento": fechaNacimiento,
        "genero": genero,
        "estado_civil": estadoCivil,
        "nro_celular": telefono,
        "usuario": usuario,
        "pais_residencia": pais,
        "nacionalidad": nacionalidad,
        "ciudad": ciudad,
        "direccion_domicilio": direccion,
        "direccion_comercial": direccion,
        "actividad": actividad,
        "profesion": ocupacion,
      }),
    );

    return respuesta;
  }

  static Future<http.Response> update(
      String nombre,
      String apPaterno,
      String apMaterno,
      String? tipoDocumento,
      String nroDocumento,
      String? extDocumento,
      String fechaNacimiento,
      String? genero,
      String? estadoCivil,
      String telefono,
      String direccion,
      int? ocupacion,
      String actividad,
      int usuario,
      int? pais,
      int? ciudad,
      String nacionalidad) async {
    String endpoint = "/api/datos_personales/update/$usuario";
    final respuesta = http.put(
      Uri.parse(_BASEURL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token'
      },
      body: jsonEncode(<String, dynamic>{
        "nombre": nombre,
        "apellido_paterno": apPaterno,
        "apellido_materno": apMaterno,
        "tipo_documento": tipoDocumento,
        "numero_documento": nroDocumento,
        "extension": extDocumento,
        "fecha_nacimiento": fechaNacimiento,
        "genero": genero,
        "estado_civil": estadoCivil,
        "nro_celular": telefono,
        "usuario": usuario,
        "pais_residencia": pais,
        "nacionalidad": nacionalidad,
        "ciudad": ciudad,
        "direccion_domicilio": direccion,
        "direccion_comercial": direccion,
        "actividad": actividad,
        "profesion": ocupacion,
      }),
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
  } */

  static Future<Response?> updateFotos(
      String idDatosPersonales,
      File? ciFrontal,
      File? ciTrasero,
      nombre,
      apPaterno,
      apMaterno,
      usuario,
      profesion,
      ciudad) async {
    var dio = Dio();

    String endpoint = "/api/datos_personales/update/$usuario";

    var datosEnviar = {
      "nombre": nombre,
      "apellido_paterno": apPaterno,
      "apellido_materno": apMaterno,
      "usuario": usuario,
      "profesion": profesion,
      "ciudad": ciudad
    };
    if (ciFrontal != null) {
      String frontalName = ciFrontal.path.split('/').last;
      datosEnviar["ci_frontal"] =
          await MultipartFile.fromFile(ciFrontal.path, filename: frontalName);
    }
    if (ciTrasero != null) {
      String traceroName = ciTrasero.path.split('/').last;
      datosEnviar["ci_trasero"] =
          await MultipartFile.fromFile(ciTrasero.path, filename: traceroName);
    }

    FormData formData = new FormData.fromMap(datosEnviar);
    dio.options.headers["Authorization"] = "Token $_token";
    Response response = await dio.put(_BASEURL + endpoint, data: formData);
    if (response.statusCode == 400) {
      return null;
    }
    print(response.data);
    return response;
  }

  static Future<Response> updateFotoUser(File fotoUser, nombre, apPaterno,
      apMaterno, usuario, ocupacion, ciudad) async {
    var dio = Dio();
    String fotoName = fotoUser.path.split('/').last;

    String endpoint = "/api/datos_personales/update/$usuario";
    print(_BASEURL + endpoint);
    print(fotoName);
    try {
      FormData formData = new FormData.fromMap({
        "imagen":
            await MultipartFile.fromFile(fotoUser.path, filename: fotoName),
        "nombre": nombre,
        "apellido_paterno": apPaterno,
        "apellido_materno": apMaterno,
        "usuario": usuario,
        "profesion": ocupacion,
        "ciudad": ciudad,
      });
      dio.options.headers["Authorization"] = "Token $_token";
      Response response = await dio.put(_BASEURL + endpoint, data: formData);
      return response;
      print(response);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<Response?> updateFirma(var firma) async {
    var dio = Dio();

    int idUser = StorageUtils.getInteger("id_usuario");
    String nombre = StorageUtils.getString("nombre");
    String apellidoPaterno = StorageUtils.getString("apellido_paterno");
    String apellidoMaterno = StorageUtils.getString("apellido_materno");
    int idProfesion = StorageUtils.getInteger("id_profesion");
    int idCiudad = StorageUtils.getInteger("id_ciudad");

    //File('image.jpg').writeAsBytes(imageBytes);

    String endpoint = "/api/datos_personales/update/$idUser";

    final tempDir = await getTemporaryDirectory();
    String nameFirma = "firma_$idUser.png";
    File fileFirma = await File('${tempDir.path}/$nameFirma').create();
    fileFirma.writeAsBytesSync(firma);

    Response? response;
    try {
      FormData formData = new FormData.fromMap({
        "firma":
            await MultipartFile.fromFile(fileFirma.path, filename: nameFirma),
        "nombre": nombre,
        "apellido_paterno": apellidoPaterno,
        "apellido_materno": apellidoMaterno,
        "usuario": idUser,
        "profesion": idProfesion,
        "ciudad": idCiudad,
      });
      dio.options.headers["Authorization"] = "Token $_token";
      response = await dio.put(_BASEURL + endpoint, data: formData);

      print(response.data);
    } catch (e) {
      print(e);
    }

    return response;
  }

  static Future<http.Response> getDatos(String endpoint) async {
    final respuesta = await http.get(Uri.parse(_BASEURL + endpoint));
    return respuesta;
  }
}
