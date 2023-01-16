// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:checkbox_formfield/checkbox_formfield.dart';
// import 'package:mibigbro/rest_api/provider/user_provider.dart';
// import 'package:mibigbro/screens/perfil/datos_personales.dart';
// import 'package:mibigbro/utils/storage.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'login.dart';

// class Registro extends StatefulWidget {
//   @override
//   _RegistroState createState() => _RegistroState();
// }

// class _RegistroState extends State<Registro> {
//   final TextEditingController _email = TextEditingController();
//   final TextEditingController _pass = TextEditingController();
//   final TextEditingController _confirmPass = TextEditingController();

//   final GlobalKey<FormState> _formKeyRegistroUsuario = GlobalKey<FormState>();
//   InputDecoration inputDecoration(String text, IconData icono) {
//     return InputDecoration(
//         filled: true,
//         fillColor: Colors.white,
//         hintStyle: TextStyle(fontSize: 12),
//         hintText: text,
//         suffixIcon: Icon(icono, color: Color(0xff1D2766)),
//         border: InputBorder.none,
//         contentPadding: EdgeInsets.all(10),
//         errorStyle: TextStyle(color: Colors.white));
//   }

//   @override
//   void initState() {
//     super.initState();
//     StorageUtils.init();
//   }

//   _launchURL() async {
//     const url = 'https://mibigbro.com/terminos.html';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff1D2766),
//       body: Center(
//         child: Padding(
//             padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
//             child: SingleChildScrollView(
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                   SizedBox(height: 40),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         'assets/img/logo_bigbro.png',
//                         width: 80,
//                         fit: BoxFit.fitWidth,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 24),
//                   Form(
//                       key: _formKeyRegistroUsuario,
//                       child: Column(
//                         children: <Widget>[
//                           TextFormField(
//                               controller: _email,
//                               keyboardType: TextInputType.emailAddress,
//                               decoration: inputDecoration(
//                                   'Correo electronico', Icons.account_circle),
//                               validator: (String? value) {
//                                 if (value!.isEmpty) {
//                                   return 'Correo electronico es requerido';
//                                 }
//                                 if (!RegExp(
//                                         r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
//                                     .hasMatch(value)) {
//                                   return 'Ingrese un correo electronico valido';
//                                 }

//                                 return null;
//                               }),
//                           SizedBox(height: 20),
//                           TextFormField(
//                               obscureText: true,
//                               decoration:
//                                   inputDecoration('Contraseña', Icons.lock),
//                               controller: _pass,
//                               validator: (String? value) {
//                                 if (value!.isEmpty) {
//                                   return 'Contraseña es requerido';
//                                 } else if (RegExp(
//                                             r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
//                                         .hasMatch(value) ==
//                                     false) {
//                                   return 'La contraseña debe ser más de 6 caracteres, \n contener una letra, un número y un símbolo';
//                                 }
//                                 return null;
//                               }),
//                           SizedBox(height: 20),
//                           TextFormField(
//                             obscureText: true,
//                             decoration: inputDecoration(
//                                 'Repita su contraseña', Icons.lock),
//                             controller: _confirmPass,
//                             validator: (String? value) {
//                               if (value!.isEmpty) {
//                                 return 'Repita su contraseña es requerido';
//                               }
//                               if (value != _pass.text) {
//                                 return 'La contraseña es diferente';
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(height: 20),
//                           CheckboxListTileFormField(
//                             title: Text(
//                                 'Estoy de acuerdo con los términos y condiciones',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w300,
//                                 )),
//                             checkColor: Colors.black,
//                             activeColor: Colors.white,
//                             errorColor: Colors.red,
//                             initialValue: true,
//                             onSaved: (bool? value) {},
//                             validator: (bool? value) {
//                               if (value!) {
//                                 return null;
//                               } else {
//                                 return 'Debe aceptar';
//                               }
//                             },
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               _launchURL();
//                             },
//                             child: new Text(
//                               "Ver términos y condiciones de uso",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           TextButton(
//                             color: Color(0xff9ED1FF),
//                             textColor: Color(0xff1D2766),
//                             disabledColor: Colors.grey,
//                             disabledTextColor: Colors.black,
//                             padding: EdgeInsets.all(8.0),
//                             splashColor: Colors.blueAccent,
//                             onPressed: () async {
//                               if (_formKeyRegistroUsuario.currentState!
//                                   .validate()) {
//                                 var response = await UserProvider.createUser(
//                                     '/api/user/create/',
//                                     _email.text,
//                                     _pass.text);

//                                 var mensaje = "Error al ingresar nuevo usuario";
//                                 if (response.statusCode == 201) {
//                                   mensaje = "Usuario creado exitosamente";
//                                   Map<String, dynamic> datosRespuesta =
//                                       json.decode(response.body);

//                                   //print(datosRespuesta['id']);
//                                   StorageUtils.setInteger(
//                                       "id_usuario", datosRespuesta['id']);
//                                   //print(datosRespuesta['token']);
//                                   StorageUtils.setString(
//                                       "token", datosRespuesta['token']);
//                                   StorageUtils.setString(
//                                       "email", datosRespuesta['email']);
//                                   StorageUtils.setString(
//                                       "codigo", datosRespuesta['codigo']);
//                                 } else {
//                                   mensaje =
//                                       "El usuario ya se encuentra registrado";
//                                 }
//                                 Fluttertoast.showToast(
//                                     msg: mensaje,
//                                     toastLength: Toast.LENGTH_LONG,
//                                     gravity: ToastGravity.BOTTOM,
//                                     timeInSecForIosWeb: 5,
//                                     backgroundColor: Colors.white,
//                                     textColor: Colors.black,
//                                     fontSize: 16.0);
//                                 if (response.statusCode == 201) {
//                                   Navigator.pushNamedAndRemoveUntil(
//                                     context,
//                                     "home",
//                                     (r) => false,
//                                   );
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => DatosPersonales(),
//                                     ),
//                                   );
//                                 }
//                               }
//                             },
//                             child: Text(
//                               "Registrarse",
//                               style: TextStyle(fontSize: 14.0),
//                             ),
//                           ),
//                         ],
//                       )),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: new Text(
//                       "Ya tengo cuenta",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                   Image.asset(
//                     'assets/img/asegalianza_claro.png',
//                     width: 80,
//                     fit: BoxFit.fitWidth,
//                   ),
//                   SizedBox(height: 12),
//                   Text(
//                     "Plataforma de",
//                     style: TextStyle(color: Colors.white, fontSize: 9.0),
//                   ),
//                   Image.asset(
//                     'assets/img/logo_sudamericana.png',
//                     width: 150,
//                     fit: BoxFit.fitWidth,
//                   ),
//                 ]))),
//       ),
//     );
//   }
// }
