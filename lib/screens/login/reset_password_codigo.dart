import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mibigbro/rest_api/provider/password_reset_provider.dart';
import 'package:mibigbro/rest_api/provider/user_provider.dart';
import 'package:mibigbro/screens/login/reset_password_email.dart';
import 'package:mibigbro/utils/storage.dart';
import 'registro.dart';
import '../home/home.dart';

class PasswordResetCodigo extends StatefulWidget {
  @override
  _PasswordResetCodigoState createState() => _PasswordResetCodigoState();
}

class _PasswordResetCodigoState extends State<PasswordResetCodigo> {
  final TextEditingController _code = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _repeatPassword = TextEditingController();

  final GlobalKey<FormState> _formKeyPasswordResetCodigoUsuario =
      GlobalKey<FormState>();

  final ValueNotifier<bool> _showPasswordNotifier = ValueNotifier(false);
  final ValueNotifier<bool> _repeatShowPasswordNotifier = ValueNotifier(false);

  InputDecoration inputDecoration(
      String text, IconData icono, VoidCallback onTap) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintStyle: TextStyle(fontSize: 12),
      hintText: text,
      suffixIcon: GestureDetector(
        onTap: onTap,
        child: Icon(
          icono,
          color: Color(0xffCDD4D9),
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffCDD4D9),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffCDD4D9),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffCDD4D9),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
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
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/img/headerpainter.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: double.infinity,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 120),
                      child: Center(
                        child: Text(
                          'Ingresa nueva contraseña',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        'assets/img/logo-mibigbro-dark.png',
                        width: 150,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
                child: Form(
                  key: _formKeyPasswordResetCodigoUsuario,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        obscureText: false,
                        controller: _code,
                        decoration: inputDecoration(
                          'Código',
                          Icons.code,
                          () {},
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Código es requerido';
                          }
                          // else if (RegExp(
                          //             r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
                          //         .hasMatch(value) ==
                          //     false) {
                          //   return 'La contraseña debe ser más de 6 caracteres, \n contener una letra, un número y un símbolo';
                          // }
                          return null;
                        },
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: _showPasswordNotifier,
                        builder:
                            (BuildContext context, bool value, Widget? child) {
                          return TextFormField(
                            obscureText: !value,
                            controller: _password,
                            decoration: inputDecoration('Nueva contraseña',
                                value ? Icons.visibility_off : Icons.visibility,
                                () {
                              _showPasswordNotifier.value =
                                  !_showPasswordNotifier.value;
                            }),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Nueva contraseña es requerido';
                              }
                              // else if (RegExp(
                              //             r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
                              //         .hasMatch(value) ==
                              //     false) {
                              //   return 'La contraseña debe ser más de 6 caracteres, \n contener una letra, un número y un símbolo';
                              // }
                              return null;
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: _repeatShowPasswordNotifier,
                        builder:
                            (BuildContext context, bool value, Widget? child) {
                          return TextFormField(
                            obscureText: !value,
                            controller: _repeatPassword,
                            decoration: inputDecoration('Repite tu contraseña',
                                value ? Icons.visibility_off : Icons.visibility,
                                () {
                              _repeatShowPasswordNotifier.value =
                                  !_repeatShowPasswordNotifier.value;
                            }),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Repetir contraseña es repetido';
                              }
                              // else if (RegExp(
                              //             r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
                              //         .hasMatch(value) ==
                              //     false) {
                              //   return 'La contraseña debe ser más de 6 caracteres, \n contener una letra, un número y un símbolo';
                              // }
                              return null;
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                          elevation: MaterialStateProperty.all<double>(0.0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xff1D2766),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKeyPasswordResetCodigoUsuario.currentState!
                              .validate()) {
                            int idUsuario =
                                StorageUtils.getInteger('id_usuario');

                            var response =
                                await PasswordResetProvider.consultarCodigo(
                                    idUsuario, _code.text, _password.text);
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
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          child: Center(
                            child: Text(
                              "Ingresar",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No tengo cuenta  ",
                    style: TextStyle(
                      color: Color(0xff707070),
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Registro()),
                      );
                    },
                    child: Text(
                      "Registrar",
                      style: TextStyle(
                        color: Color(0xffEC1C24),
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

// class HeaderPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint();
//     paint.color = Color;
//     paint.style = PaintingStyle.fill;

//     Path path = Path();

//     final height = size.height;
//     final width = size.width;

//     path.moveTo(0.0, 0.0);
//     path.lineTo(0.0, height * 0.65);
//     path.quadraticBezierTo(
//       width * 0.1,
//       height * 0.70,
//       width * 0.2,
//       height * 0.75,
//     );
//     path.lineTo(0.0, 0.0);
//     path.lineTo(width * 0.8, height * 0.75);

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
