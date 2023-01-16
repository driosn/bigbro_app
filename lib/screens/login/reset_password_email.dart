import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mibigbro/rest_api/provider/password_reset_provider.dart';
import 'package:mibigbro/rest_api/provider/user_provider.dart';
import 'package:mibigbro/screens/login/reset_password_codigo.dart';
import 'package:mibigbro/screens/login/reset_password_email.dart';
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
                          'Ingresa el correo registrado',
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
                  key: _formKeyPasswordResetEmail,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: inputDecoration(
                            'Correo electrónico',
                            Icons.email,
                            () {},
                          ),
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
                      SizedBox(height: 110),
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
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          child: Center(
                            child: Text(
                              "Enviar",
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Volver",
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
