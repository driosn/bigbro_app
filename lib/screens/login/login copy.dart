// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:mibigbro/rest_api/provider/user_provider.dart';
// import 'package:mibigbro/screens/login/reset_password_email.dart';
// import 'package:mibigbro/utils/storage.dart';
// import 'registro.dart';
// import '../home/home.dart';

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final TextEditingController _email = TextEditingController();
//   final TextEditingController _pass = TextEditingController();

//   final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();

//   InputDecoration inputDecoration(String text, IconData icono) {
//     return InputDecoration(
//       filled: true,
//       fillColor: Colors.white,
//       hintStyle: TextStyle(fontSize: 12),
//       hintText: text,
//       suffixIcon: Icon(icono, color: Color(0xff1D2766)),
//       border: InputBorder.none,
//       contentPadding: EdgeInsets.all(10),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     //StorageUtils.init();
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
//                   Image.asset(
//                     'assets/img/logo_bigbro.png',
//                     width: 80,
//                     fit: BoxFit.fitWidth,
//                   ),
//                   SizedBox(height: 40),
//                   Form(
//                       key: _formKeyLogin,
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
//                               controller: _pass,
//                               decoration:
//                                   inputDecoration('Contraseña', Icons.lock),
//                               validator: (String? value) {
//                                 if (value!.isEmpty) {
//                                   return 'Contraseña es requerido';
//                                 }
//                                 // else if (RegExp(
//                                 //             r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
//                                 //         .hasMatch(value) ==
//                                 //     false) {
//                                 //   return 'La contraseña debe ser más de 6 caracteres, \n contener una letra, un número y un símbolo';
//                                 // }
//                                 return null;
//                               }),
//                           SizedBox(height: 20),
//                           TextButton(
//                             color: Color(0xff9ED1FF),
//                             textColor: Color(0xff1D2766),
//                             disabledColor: Colors.grey,
//                             disabledTextColor: Colors.black,
//                             padding: EdgeInsets.all(8.0),
//                             splashColor: Colors.blueAccent,
//                             onPressed: () async {
//                               if (_formKeyLogin.currentState!.validate()) {
//                                 var response = await UserProvider.createUser(
//                                     '/api/user/token/',
//                                     _email.text,
//                                     _pass.text);
//                                 /* print(response.statusCode);
//                                 print(response.body); */
//                                 if (response.statusCode == 200) {
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
//                                       "codigo", datosRespuesta['codigo'] ?? '');
//                                   Navigator.pushNamedAndRemoveUntil(
//                                       context, "home", (r) => false);
//                                 } else {
//                                   Fluttertoast.showToast(
//                                       msg: "Correo o contraseña incorrectos",
//                                       toastLength: Toast.LENGTH_LONG,
//                                       gravity: ToastGravity.BOTTOM,
//                                       timeInSecForIosWeb: 5,
//                                       backgroundColor: Colors.white,
//                                       textColor: Colors.black,
//                                       fontSize: 16.0);
//                                 }
//                               }
//                             },
//                             child: Text(
//                               "Ingresar",
//                               style: TextStyle(fontSize: 14.0),
//                             ),
//                           ),
//                         ],
//                       )),
//                   SizedBox(height: 10),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => PasswordResetEmail()),
//                       );
//                     },
//                     child: new Text(
//                       "Olvidé mi contraseña",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Registro()),
//                       );
//                     },
//                     child: new Text(
//                       "Crear una cuenta",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 40),
//                   Text(
//                     "Plataforma de",
//                     style: TextStyle(color: Colors.white, fontSize: 9.0),
//                   ),
//                   SizedBox(height: 5),
//                   Image.asset(
//                     'assets/img/asegalianza_claro.png',
//                     height: 70,
//                     fit: BoxFit.fitWidth,
//                   ),
//                   SizedBox(height: 5),
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
