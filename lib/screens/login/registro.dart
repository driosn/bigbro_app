import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:mibigbro/rest_api/provider/user_provider.dart';
import 'package:mibigbro/screens/perfil/datos_personales.dart';
import 'package:mibigbro/utils/storage.dart';
import 'package:url_launcher/url_launcher.dart';

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final ValueNotifier<bool> _passwordNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _confirmPasswordNotifier =
      ValueNotifier<bool>(false);

  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  final GlobalKey<FormState> _formKeyRegistroUsuario = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    StorageUtils.init();
  }

  _launchURL() async {
    const url = 'https://mibigbro.com/terminos.html';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                        'Crea una cuenta',
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
                horizontal: 24,
              ),
              child: Form(
                key: _formKeyRegistroUsuario,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: inputDecoration(
                          'Correo electrónico',
                          Icons.account_circle,
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
                    SizedBox(height: 20),
                    ValueListenableBuilder<bool>(
                      valueListenable: _passwordNotifier,
                      builder:
                          (BuildContext context, bool value, Widget? child) {
                        return TextFormField(
                          obscureText: !value,
                          decoration: inputDecoration(
                            'Contraseña',
                            value ? Icons.visibility_off : Icons.visibility,
                            () {
                              _passwordNotifier.value =
                                  !_passwordNotifier.value;
                            },
                          ),
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
                          },
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    ValueListenableBuilder<bool>(
                      valueListenable: _confirmPasswordNotifier,
                      builder:
                          (BuildContext context, bool value, Widget? child) {
                        return TextFormField(
                          obscureText: !value,
                          decoration: inputDecoration(
                            'Repite tu contraseña',
                            value ? Icons.visibility_off : Icons.visibility,
                            () {
                              _confirmPasswordNotifier.value =
                                  !_confirmPasswordNotifier.value;
                            },
                          ),
                          controller: _confirmPass,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Repite tu contraseña';
                            }
                            if (value != _pass.text) {
                              return 'La contraseña es diferente';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 12),
                    CheckboxListTileFormField(
                      contentPadding: EdgeInsets.zero,
                      title: Wrap(
                        children: [
                          Text(
                            'Al registrarte estás aceptando nuestros ',
                            style: TextStyle(
                              color: Color(0xff979797),
                              fontSize: 12,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _launchURL();
                            },
                            child: Text(
                              'Términos y Condiciones',
                              style: TextStyle(
                                color: Color(0xffE11C24),
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        ],
                      ),
                      checkColor: Colors.white,
                      activeColor: Theme.of(context).primaryColor,
                      errorColor: Colors.red,
                      initialValue: true,
                      onSaved: (bool? value) {},
                      validator: (bool? value) {
                        if (value!) {
                          return null;
                        } else {
                          return 'Debe aceptar';
                        }
                      },
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //     _launchURL();
                    //   },
                    //   child: new Text(
                    //     "Ver términos y condiciones de uso",
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 12,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                        elevation: MaterialStateProperty.all<double>(0.0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xff1D2766),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKeyRegistroUsuario.currentState!.validate()) {
                          bool usuarioCreadoCorrectamente = false;
                          var response = await UserProvider.createUser(
                              '/api/user/create/', _email.text, _pass.text);

                          var mensaje = "Error al ingresar nuevo usuario";
                          if (response.statusCode == 201) {
                            usuarioCreadoCorrectamente = true;
                            mensaje = "Usuario creado exitosamente";
                            Map<String, dynamic> datosRespuesta =
                                json.decode(response.body);

                            //print(datosRespuesta['id']);
                            StorageUtils.setInteger(
                                "id_usuario", datosRespuesta['id']);
                            //print(datosRespuesta['token']);
                            StorageUtils.setString(
                                "token", datosRespuesta['token']);
                            StorageUtils.setString(
                                "email", datosRespuesta['email']);
                            StorageUtils.setString(
                                "codigo", datosRespuesta['codigo']);
                          } else {
                            mensaje = "El usuario ya se encuentra registrado";
                          }
                          Fluttertoast.showToast(
                              msg: mensaje,
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontSize: 16.0);
                          if (usuarioCreadoCorrectamente) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              "home",
                              (r) => false,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DatosPersonales(
                                  mostrarRegistroExitoso: true,
                                ),
                              ),
                            );
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
                            'Registrar',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ),
                    ),

                    // TextButton(
                    //   color: Color(0xff9ED1FF),
                    //   textColor: Color(0xff1D2766),
                    //   disabledColor: Colors.grey,
                    //   disabledTextColor: Colors.black,
                    //   padding: EdgeInsets.all(8.0),
                    //   splashColor: Colors.blueAccent,
                    //   onPressed: () async {
                    //     if (_formKeyRegistroUsuario.currentState!
                    //         .validate()) {
                    //       var response = await UserProvider.createUser(
                    //           '/api/user/create/', _email.text, _pass.text);

                    //       var mensaje = "Error al ingresar nuevo usuario";
                    //       if (response.statusCode == 201) {
                    //         mensaje = "Usuario creado exitosamente";
                    //         Map<String, dynamic> datosRespuesta =
                    //             json.decode(response.body);

                    //         //print(datosRespuesta['id']);
                    //         StorageUtils.setInteger(
                    //             "id_usuario", datosRespuesta['id']);
                    //         //print(datosRespuesta['token']);
                    //         StorageUtils.setString(
                    //             "token", datosRespuesta['token']);
                    //         StorageUtils.setString(
                    //             "email", datosRespuesta['email']);
                    //         StorageUtils.setString(
                    //             "codigo", datosRespuesta['codigo']);
                    //       } else {
                    //         mensaje = "El usuario ya se encuentra registrado";
                    //       }
                    //       Fluttertoast.showToast(
                    //           msg: mensaje,
                    //           toastLength: Toast.LENGTH_LONG,
                    //           gravity: ToastGravity.BOTTOM,
                    //           timeInSecForIosWeb: 5,
                    //           backgroundColor: Colors.white,
                    //           textColor: Colors.black,
                    //           fontSize: 16.0);
                    //       if (response.statusCode == 201) {
                    //         Navigator.pushNamedAndRemoveUntil(
                    //           context,
                    //           "home",
                    //           (r) => false,
                    //         );
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => DatosPersonales(),
                    //           ),
                    //         );
                    //       }
                    //     }
                    //   },
                    //   child: Text(
                    //     "Registrarse",
                    //     style: TextStyle(fontSize: 14.0),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "¿Ya tienes una cuenta?  ",
                  style: TextStyle(
                    color: Color(0xff707070),
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Ingresar",
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
            const SizedBox(
              height: 42,
            ),
          ],
        ),
      ),
    );
  }
}
