// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:mibigbro/models/datosPersonalesModel.dart';
// import 'package:mibigbro/rest_api/provider/datos_personales_provider.dart';
// import 'package:mibigbro/utils/dialog.dart';
// import 'package:mibigbro/utils/storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mibigbro/utils/key.dart' as llavero;

// // Create a Form widget.
// class DatosPersonales2 extends StatefulWidget {
//   final datosPersonalesModel? datosPersonalesData;
//   DatosPersonales2({this.datosPersonalesData});
//   @override
//   DatosPersonalesState2 createState() {
//     return DatosPersonalesState2();
//   }
// }

// // Create a corresponding State class. This class holds data related to the form.
// class DatosPersonalesState2 extends State<DatosPersonales2> {
//   // Create a global key that uniquely identifies the Form widget
//   // and allows validation of the form.
//   String _BASEURL = llavero.Key.BASEURL;
//   final _formKey = GlobalKey<FormState>();
//   File? _imageCiFrontal;
//   File? _imageCiTrasera;
//   String? ciFrontaCargado;
//   String? ciTraseraCargado;
//   final picker = ImagePicker();
//   int? idDatosPersonales = 0;
//   String textoCiFrontal = "Foto frontal de su carnet de identidad";
//   String textoCiTrasera = "Foto trasera de su carnet de identidad";

//   Future cargarDatosPersonales() async {
//     int idUsuario = StorageUtils.getInteger('id_usuario');

//     var respuestaDatosPersonales =
//         await DatosPersonalesProvider.buscar(idUsuario.toString());
//     if (respuestaDatosPersonales.statusCode == 200) {
//       var datosPersonalesGuardados = json.decode(respuestaDatosPersonales.body);
//       print(datosPersonalesGuardados);
//       idDatosPersonales = datosPersonalesGuardados["id"];

//       ciFrontaCargado = (datosPersonalesGuardados["ci_frontal"] != null)
//           ? _BASEURL + datosPersonalesGuardados["ci_frontal"]
//           : null;
//       if (ciFrontaCargado != null) {
//         textoCiFrontal = "";
//       }

//       ciTraseraCargado = (datosPersonalesGuardados["ci_trasero"] != null)
//           ? _BASEURL + datosPersonalesGuardados["ci_trasero"]
//           : null;
//       if (ciTraseraCargado != null) {
//         textoCiTrasera = "";
//       }
//     }

//     return respuestaDatosPersonales;
//   }

//   Future getImage(String tipoFoto) async {
//     final pickedFile =
//         await picker.getImage(source: ImageSource.camera, imageQuality: 20);
//     if (tipoFoto == "ciFrontal") {
//       setState(() {
//         if (pickedFile != null) {
//           _imageCiFrontal = File(pickedFile.path);
//         } else {
//           print('No image selected.');
//         }
//       });
//     } else {
//       setState(() {
//         if (pickedFile != null) {
//           _imageCiTrasera = File(pickedFile.path);
//         } else {
//           print('No image selected.');
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Build a Form widget using the _formKey created above.
//     return FutureBuilder(
//         future: cargarDatosPersonales(),
//         builder: (context, snapshot) {
//           //var datosPaquete = json.decode(respuestaPaquetes.body);
//           if (snapshot.hasData) {
//             return Scaffold(
//                 appBar: AppBar(
//                   iconTheme: IconThemeData(
//                     color: Color(0xff1D2766), //change your color here
//                   ),
//                   centerTitle: true,
//                   backgroundColor: Colors.white,
//                   title: Text("Datos personales",
//                       style: TextStyle(color: Color(0xff1D2766))),
//                 ),
//                 body: Form(
//                   key: _formKey,
//                   child: SingleChildScrollView(
//                     child: Center(
//                       child: Padding(
//                           padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               Text("Actualizar mi perfil",
//                                   style: TextStyle(color: Color(0xff1D2766))),
//                               GestureDetector(
//                                 onTap: () {
//                                   getImage("ciFrontal");
//                                 },
//                                 child: Container(
//                                     margin: EdgeInsets.only(
//                                         left: 24,
//                                         right: 24,
//                                         top: 24,
//                                         bottom: 12),
//                                     padding: EdgeInsets.all(24),
//                                     height: 150,
//                                     width: 300,
//                                     decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                           fit: BoxFit.scaleDown,
//                                           image: _imageCiFrontal == null
//                                               ? (ciFrontaCargado == null
//                                                       ? ExactAssetImage(
//                                                           "assets/img/camara.png")
//                                                       : NetworkImage(
//                                                           ciFrontaCargado!))
//                                                   as ImageProvider<Object>
//                                               : FileImage(_imageCiFrontal!)),
//                                       border: Border.all(
//                                         color: Colors.red,
//                                         width: 2,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           textoCiFrontal,
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ],
//                                     )),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   getImage("ciTrasera");
//                                 },
//                                 child: Container(
//                                     margin: EdgeInsets.only(
//                                         left: 24,
//                                         right: 24,
//                                         top: 24,
//                                         bottom: 12),
//                                     padding: EdgeInsets.all(24),
//                                     height: 150,
//                                     width: 300,
//                                     decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                           fit: BoxFit.scaleDown,
//                                           image: _imageCiTrasera == null
//                                               ? (ciTraseraCargado == null
//                                                       ? ExactAssetImage(
//                                                           "assets/img/camara.png")
//                                                       : NetworkImage(
//                                                           ciTraseraCargado!))
//                                                   as ImageProvider<Object>
//                                               : FileImage(_imageCiTrasera!)),
//                                       border: Border.all(
//                                         color: Colors.red,
//                                         width: 2,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(textoCiTrasera,
//                                             textAlign: TextAlign.center),
//                                       ],
//                                     )),
//                               ),
//                               SizedBox(height: 15),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   TextButton(
//                                     color: Color(0xff1D2766),
//                                     textColor: Colors.white,
//                                     disabledColor: Colors.grey,
//                                     disabledTextColor: Colors.black,
//                                     padding: EdgeInsets.all(8.0),
//                                     splashColor: Colors.blueAccent,
//                                     onPressed: () async {
//                                       bool imagenCiFrontal =
//                                           ciFrontaCargado != null ||
//                                               _imageCiFrontal != null;
//                                       bool imagenCiTrasera =
//                                           ciTraseraCargado != null ||
//                                               _imageCiTrasera != null;

//                                       print(imagenCiFrontal);
//                                       print(imagenCiTrasera);

//                                       if (_formKey.currentState!.validate() &&
//                                           imagenCiFrontal &&
//                                           imagenCiTrasera) {
//                                         DialogoProgreso dialog =
//                                             DialogoProgreso(
//                                                 context, "Guardando");
//                                         dialog.mostrarDialogo();
//                                         var respuestaDatosPersonales =
//                                             await DatosPersonalesProvider
//                                                 .updateFotos(
//                                                     idDatosPersonales
//                                                         .toString(),
//                                                     _imageCiFrontal,
//                                                     _imageCiTrasera,
//                                                     widget.datosPersonalesData!
//                                                         .nombre,
//                                                     widget.datosPersonalesData!
//                                                         .apellidoPaterno,
//                                                     widget.datosPersonalesData!
//                                                         .apellidoMaterno,
//                                                     widget.datosPersonalesData!
//                                                         .idUser,
//                                                     widget.datosPersonalesData!
//                                                         .ocupacion,
//                                                     widget.datosPersonalesData!
//                                                         .ciudad);

//                                         print("Actualizar 2");
//                                         Timer(Duration(seconds: 3), () {
//                                           dialog.ocultarDialogo();

//                                           Navigator.pushNamedAndRemoveUntil(
//                                               context, "home", (r) => false);
//                                         });
//                                       } else {
//                                         Fluttertoast.showToast(
//                                             msg:
//                                                 "Ingrese su ocupación, actividad y fotos de su documento de identidad",
//                                             webPosition: "center",
//                                             toastLength: Toast.LENGTH_LONG,
//                                             gravity: ToastGravity.BOTTOM,
//                                             timeInSecForIosWeb: 7,
//                                             backgroundColor: Colors.black,
//                                             textColor: Colors.white,
//                                             fontSize: 20.0);
//                                       }
//                                     },
//                                     child: Text(
//                                       "Guardar",
//                                       style: TextStyle(fontSize: 14.0),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           )),
//                     ),
//                   ),
//                 ));
//           } else {
//             return Scaffold(
//               body: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//         });
//   }
// }
