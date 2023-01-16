import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mibigbro/rest_api/provider/password_reset_provider.dart';
import 'package:mibigbro/rest_api/provider/user_provider.dart';
import 'package:mibigbro/screens/login/reset_password_codigo.dart';
import 'package:mibigbro/utils/dialog.dart';
import 'package:mibigbro/utils/storage.dart';
import 'registro.dart';
import '../home/home.dart';

class PasswordResetEmail extends StatefulWidget {
  @override
  _PasswordResetEmailState createState() => _PasswordResetEmailState();
}

class _PasswordResetEmailState extends State<PasswordResetEmail> {
  final TextEditingController _email = TextEditingController();

  final GlobalKey<FormState> _formKeyPasswordResetEmail =
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
    );
  }

  @override
  void initState() {
    super.initState();
    //StorageUtils.init();
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
                  Image.asset(
                    'assets/img/logo_bigbro.png',
                    width: 80,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(height: 40),
                  Form(
                      key: _formKeyPasswordResetEmail,
                      child: Column(
                        children: <Widget>[
                          Text("Ingrese el correo registrado",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(height: 10),
                          TextFormField(
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              decoration: inputDecoration(
                                  'Correo electrónico', Icons.email),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Correo electrónico es requerido';
                                }
                                if (!RegExp(
                                        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                    .hasMatch(value)) {
                                  return 'Ingrese un correo electrónico valido';
                                }

                                return null;
                              }),
                          SizedBox(height: 20),
                          TextButton(
                            // color: Color(0xff9ED1FF),
                            // textColor: Color(0xff1D2766),
                            // disabledColor: Colors.grey,
                            // disabledTextColor: Colors.black,
                            // padding: EdgeInsets.all(8.0),
                            // splashColor: Colors.blueAccent,
                            onPressed: () async {
                              if (_formKeyPasswordResetEmail.currentState!
                                  .validate()) {
                                DialogoProgreso dialog =
                                    DialogoProgreso(context, "Enviando");
                                dialog.mostrarDialogo();
                                var response =
                                    await PasswordResetProvider.consultarEmail(
                                        _email.text);
                                print(response.statusCode);
                                print(response.body);
                                dialog.ocultarDialogo();
                                if (response.statusCode == 200) {
                                  Map<String, dynamic> datosRespuesta =
                                      json.decode(response.body);

                                  //print(datosRespuesta['id']);
                                  StorageUtils.setInteger(
                                      "id_usuario", datosRespuesta['id_user']);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PasswordResetCodigo()),
                                  );
                                } else {
                                  dialog.ocultarDialogo();
                                  Fluttertoast.showToast(
                                      msg: "Correo electrónico no encontrado",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 5,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.black,
                                      fontSize: 16.0);
                                }
                              }
                            },
                            child: Text(
                              "Enviar",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      )),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: new Text(
                      "Volver",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
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
