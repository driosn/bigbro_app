import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:mibigbro/rest_api/provider/password_reset_provider.dart';
import 'package:mibigbro/rest_api/provider/user_provider.dart';
import 'package:mibigbro/utils/dialog.dart';
import 'package:mibigbro/utils/storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login.dart';

class PasswordResetCodigo extends StatefulWidget {
  @override
  _PasswordResetCodigoState createState() => _PasswordResetCodigoState();
}

class _PasswordResetCodigoState extends State<PasswordResetCodigo> {
  final TextEditingController _codigo = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  final GlobalKey<FormState> _formKeyPasswordResetCodigoUsuario =
      GlobalKey<FormState>();
  InputDecoration inputDecoration(String text, IconData icono) {
    return InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(fontSize: 12),
        hintText: text,
        suffixIcon: Icon(icono, color: Color(0xff1D2766)),
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(10),
        errorStyle: TextStyle(color: Colors.white));
  }

  @override
  void initState() {
    super.initState();
    StorageUtils.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D2766),
      body: Center(
        child: Padding(
            padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                  SizedBox(height: 40),
                  Image.asset(
                    'assets/img/logo_bigbro.png',
                    width: 80,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(height: 40),
                  Form(
                      key: _formKeyPasswordResetCodigoUsuario,
                      child: Column(
                        children: <Widget>[
                          Text("Ingrese el código enviado a su correo",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(height: 10),
                          TextFormField(
                              controller: _codigo,
                              keyboardType: TextInputType.number,
                              decoration:
                                  inputDecoration('Código', Icons.code_sharp),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Ingrese su código';
                                }
                                return null;
                              }),
                          SizedBox(height: 20),
                          TextFormField(
                              obscureText: true,
                              decoration: inputDecoration(
                                  'Nueva contraseña', Icons.lock),
                              controller: _pass,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Contraseña es requerido';
                                } else if (RegExp(
                                            r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
                                        .hasMatch(value) ==
                                    false) {
                                  return 'La contraseña debe ser más de 6 caracteres, \n contener una letra, un número y un símbolo';
                                }
                                return null;
                              }),
                          SizedBox(height: 20),
                          TextFormField(
                            obscureText: true,
                            decoration: inputDecoration(
                                'Repita su contraseña nueva', Icons.lock),
                            controller: _confirmPass,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Repita su contraseña es requerido';
                              }
                              if (value != _pass.text) {
                                return 'La contraseña es diferente';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextButton(
                            // color: Color(0xff9ED1FF),
                            // textColor: Color(0xff1D2766),
                            // disabledColor: Colors.grey,
                            // disabledTextColor: Colors.black,
                            // padding: EdgeInsets.all(8.0),
                            // splashColor: Colors.blueAccent,
                            onPressed: () async {
                              if (_formKeyPasswordResetCodigoUsuario
                                  .currentState!
                                  .validate()) {
                                int idUsuario =
                                    StorageUtils.getInteger('id_usuario');

                                var response =
                                    await PasswordResetProvider.consultarCodigo(
                                        idUsuario, _codigo.text, _pass.text);
                                print(response.statusCode);
                                print(response.body);

                                if (response.statusCode == 200) {
                                  Map<String, dynamic>? datosRespuesta =
                                      json.decode(response.body);
                                  print(datosRespuesta);
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, "login", (r) => false);
                                  Fluttertoast.showToast(
                                      msg: "Se actualizo su contraseña",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.black,
                                      fontSize: 16.0);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Código invalido",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.black,
                                      fontSize: 16.0);
                                }
                              }
                            },
                            child: Text(
                              "Cambiar contraseña",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: 40),
                  Text(
                    "Plataforma de",
                    style: TextStyle(color: Colors.white, fontSize: 9.0),
                  ),
                  Image.asset(
                    'assets/img/logo_sudamericana.png',
                    width: 150,
                    fit: BoxFit.fitWidth,
                  ),
                ]))),
      ),
    );
  }
}
