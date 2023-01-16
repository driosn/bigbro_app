// import 'dart:async';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mibigbro/models/motorizadoModel.dart';
// import 'package:mibigbro/rest_api/provider/motorizado_provider.dart';

// import 'package:mibigbro/screens/cotizacion/aseguradoras.dart';
// import 'package:mibigbro/screens/cotizacion/inspeccion/datos_imagen_tablero_dano.dart';
// import 'package:mibigbro/utils/dialog.dart';

// class InspeccionPantalla3 extends StatefulWidget {
//   final motorizadoModel? datosMotorizado;
//   InspeccionPantalla3({this.datosMotorizado});

//   static const TextStyle panelTitleStyle = TextStyle(
//       color: Color(0xff1D2766),
//       fontSize: 14.0,
//       fontFamily: 'Manrope',
//       fontWeight: FontWeight.w300);
//   static const TextStyle panelTitleStyleDialog = TextStyle(
//       color: Color(0xff1D2766),
//       fontSize: 20.0,
//       fontFamily: 'Manrope',
//       fontWeight: FontWeight.w300);
//   static const TextStyle panelStyle = TextStyle(
//       color: Color(0xff1D2766),
//       fontSize: 18.0,
//       height: 1,
//       fontFamily: 'Manrope',
//       fontWeight: FontWeight.w700);

//   @override
//   _InspeccionPantalla3State createState() => _InspeccionPantalla3State();
// }

// class _InspeccionPantalla3State extends State<InspeccionPantalla3> {
//   final appTitle = 'Datos del motorizado';
//   final TextEditingController _placaController = TextEditingController();
//   File? _imageRuat;
//   File? _imageFrontal;
//   File? _imageTrasera;
//   File? _imageLateralIzquierdo;
//   File? _imageLateralDerecho;
//   File? _imageVelocimetro;
//   File? _imageLlantaRespuesto;
//   File? _imageTablero;

//   final picker = ImagePicker();

//   Future getImage(String tipoFoto) async {
//     final pickedFile =
//         await picker.getImage(source: ImageSource.camera, imageQuality: 20);

//     switch (tipoFoto) {
//       case "RUAT":
//         {
//           setState(() {
//             if (pickedFile != null) {
//               _imageRuat = File(pickedFile.path);
//             } else {
//               print('No image selected.');
//             }
//           });
//         }
//         break;
//       case "FRONTAL":
//         {
//           setState(() {
//             if (pickedFile != null) {
//               _imageFrontal = File(pickedFile.path);
//             } else {
//               print('No image selected.');
//             }
//           });
//         }
//         break;
//       case "TRASERA":
//         {
//           setState(() {
//             if (pickedFile != null) {
//               _imageTrasera = File(pickedFile.path);
//             } else {
//               print('No image selected.');
//             }
//           });
//         }
//         break;
//       case "IZQUIERDA":
//         {
//           setState(() {
//             if (pickedFile != null) {
//               _imageLateralIzquierdo = File(pickedFile.path);
//             } else {
//               print('No image selected.');
//             }
//           });
//         }
//         break;
//       case "DERECHA":
//         {
//           setState(() {
//             if (pickedFile != null) {
//               _imageLateralDerecho = File(pickedFile.path);
//             } else {
//               print('No image selected.');
//             }
//           });
//         }
//         break;
//       case "VELOCIMETRO":
//         {
//           setState(() {
//             if (pickedFile != null) {
//               _imageVelocimetro = File(pickedFile.path);
//             } else {
//               print('No image selected.');
//             }
//           });
//         }
//         break;
//       case "LLANTA":
//         {
//           setState(() {
//             if (pickedFile != null) {
//               _imageLlantaRespuesto = File(pickedFile.path);
//             } else {
//               print('No image selected.');
//             }
//           });
//         }
//         break;
//       case "TABLERO":
//         {
//           setState(() {
//             if (pickedFile != null) {
//               _imageTablero = File(pickedFile.path);
//             } else {
//               print('No image selected.');
//             }
//           });
//         }
//         break;
//       default:
//         {
//           setState(() {
//             if (pickedFile != null) {
//               _imageRuat = File(pickedFile.path);
//             } else {
//               print('No image selected.');
//             }
//           });
//         }

//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Future<void> _showMyDialogIndicaciones(
//         String title, String detalle, String pathImage) async {
//       return showDialog<void>(
//         context: context,
//         barrierDismissible: false, // user must tap button!
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Tomar en cuenta para la foto',
//                 style: InspeccionPantalla3.panelTitleStyle,
//                 textAlign: TextAlign.center),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: <Widget>[
//                   /* Image.asset(
//                     pathImage,
//                     width: 50,
//                   ), */
//                   Icon(
//                     Icons.camera_alt_rounded,
//                     size: 50.0,
//                     color: Color(0xff1D2766),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     title,
//                     style: InspeccionPantalla3.panelStyle,
//                     textAlign: TextAlign.center,
//                   ),
//                   Text(detalle,
//                       style: InspeccionPantalla3.panelTitleStyleDialog,
//                       textAlign: TextAlign.center),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('Cerrar'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//           color: Color(0xff1D2766), //change your color here
//         ),
//         actions: <Widget>[
//           Padding(
//               padding: EdgeInsets.only(right: 20.0),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.pushNamedAndRemoveUntil(
//                       context, "/home", (r) => false);
//                 },
//                 child: Icon(
//                   Icons.home_outlined,
//                   size: 26.0,
//                 ),
//               ))
//         ],
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         title: Text(appTitle, style: TextStyle(color: Color(0xff1D2766))),
//       ),
//       body: SingleChildScrollView(
//           child: Container(
//               padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text("Fotos del motorizado",
//                       style: InspeccionPantalla3.panelTitleStyle,
//                       textAlign: TextAlign.center),
//                   Text(
//                       "Se debe tomar las fotos de frente al vehículo en un lugar iluminado y con el vehículo limpio",
//                       style: InspeccionPantalla3.panelTitleStyle,
//                       textAlign: TextAlign.center),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                           width: 250,
//                           height: 200,
//                           margin: EdgeInsets.only(
//                               left: 10, right: 10, top: 10, bottom: 0),
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                                 fit: BoxFit.fill,
//                                 image: (_imageLateralIzquierdo == null
//                                     ? ExactAssetImage("assets/img/camara.png")
//                                     : FileImage(_imageLateralIzquierdo!)) as ImageProvider<Object>),
//                             border: Border.all(
//                               color: Color(0xff1D2766),
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               if (_imageLateralIzquierdo == null)
//                                 Text(
//                                   "Frontal lateral izquierda",
//                                   style: InspeccionPantalla3.panelStyle,
//                                   textAlign: TextAlign.center,
//                                 ),
//                               SizedBox(height: 5),
//                               if (_imageLateralIzquierdo == null)
//                                 Image.asset(
//                                   'assets/img/autolateral2.png',
//                                   width: 100,
//                                   fit: BoxFit.fitWidth,
//                                 ),
//                               SizedBox(height: 5),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   GestureDetector(
//                                       onTap: () {
//                                         _showMyDialogIndicaciones(
//                                             "Foto lado izquierdo",
//                                             "Se debe ver la parte lateral del vehículo. Se debe ver con claridad los aros de las llantas y los retrovisores.",
//                                             'assets/img/autofrontal.png');
//                                       },
//                                       child: Icon(
//                                         Icons.info_outline,
//                                         size: 45.0,
//                                         color: Color(0xff1D2766),
//                                       )),
//                                   SizedBox(
//                                       width: 40,
//                                       child: RawMaterialButton(
//                                         onPressed: () {
//                                           getImage("IZQUIERDA");
//                                         },
//                                         elevation: 10.0,
//                                         fillColor: Colors.red,
//                                         child: Icon(
//                                           Icons.camera_alt,
//                                           size: 20.0,
//                                           color: Colors.white,
//                                         ),
//                                         padding: EdgeInsets.all(2.0),
//                                         shape: CircleBorder(),
//                                       ))
//                                 ],
//                               )
//                             ],
//                           )),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                           width: 250,
//                           height: 200,
//                           margin: EdgeInsets.only(
//                               left: 10, right: 10, top: 10, bottom: 0),
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                                 fit: BoxFit.fill,
//                                 image: (_imageLateralDerecho == null
//                                     ? ExactAssetImage("assets/img/camara.png")
//                                     : FileImage(_imageLateralDerecho!)) as ImageProvider<Object>),
//                             border: Border.all(
//                               color: Color(0xff1D2766),
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               if (_imageLateralDerecho == null)
//                                 Text(
//                                   "Frontal lateral derecha",
//                                   style: InspeccionPantalla3.panelStyle,
//                                   textAlign: TextAlign.center,
//                                 ),
//                               SizedBox(height: 5),
//                               if (_imageLateralDerecho == null)
//                                 Image.asset(
//                                   'assets/img/autolateral1.png',
//                                   width: 100,
//                                   fit: BoxFit.fitWidth,
//                                 ),
//                               SizedBox(height: 5),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   GestureDetector(
//                                       onTap: () {
//                                         _showMyDialogIndicaciones(
//                                             "Foto lado derecho",
//                                             "Se debe ver la parte lateral del vehículo. Se debe ver con claridad los aros de las llantas y los retrovisores",
//                                             'assets/img/autofrontal.png');
//                                       },
//                                       child: Icon(
//                                         Icons.info_outline,
//                                         size: 45.0,
//                                         color: Color(0xff1D2766),
//                                       )),
//                                   SizedBox(
//                                       width: 40,
//                                       child: RawMaterialButton(
//                                         onPressed: () {
//                                           getImage("DERECHA");
//                                         },
//                                         elevation: 10.0,
//                                         fillColor: Colors.red,
//                                         child: Icon(
//                                           Icons.camera_alt,
//                                           size: 20.0,
//                                           color: Colors.white,
//                                         ),
//                                         padding: EdgeInsets.all(2.0),
//                                         shape: CircleBorder(),
//                                       ))
//                                 ],
//                               )
//                             ],
//                           )),
//                     ],
//                   ),
//                   SizedBox(height: 30),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       TextButton(
//                         color: Color(0xff1D2766),
//                         textColor: Colors.white,
//                         disabledColor: Colors.grey,
//                         disabledTextColor: Colors.black,
//                         padding: EdgeInsets.all(8.0),
//                         splashColor: Colors.blueAccent,
//                         onPressed: () async {
//                           int? idAuto = widget.datosMotorizado!.idAutomovil;

//                           if (_imageLateralIzquierdo == null ||
//                               _imageLateralDerecho == null) {
//                             Fluttertoast.showToast(
//                                 msg:
//                                     "Debe tomar las fotos lateral izquierda y derecha del vehículo",
//                                 webPosition: "center",
//                                 toastLength: Toast.LENGTH_LONG,
//                                 gravity: ToastGravity.BOTTOM,
//                                 timeInSecForIosWeb: 7,
//                                 backgroundColor: Colors.black,
//                                 textColor: Colors.white,
//                                 fontSize: 20.0);
//                           } else {
//                             DialogoProgreso dialog =
//                                 DialogoProgreso(context, "Guardando");
//                             dialog.mostrarDialogo();
//                             var responseNuevaInspeccion =
//                                 await MotorizadoProvider.fotosInspeccionLateral(
//                                     widget.datosMotorizado!.idAutomovil
//                                         .toString(),
//                                     widget.datosMotorizado!.idInspeccion
//                                         .toString(),
//                                     _imageLateralIzquierdo!,
//                                     _imageLateralDerecho!);
//                             Timer(Duration(seconds: 3), () {
//                               dialog.ocultarDialogo();
//                               if (responseNuevaInspeccion != 400) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => InspeccionPantalla4(
//                                           datosMotorizado:
//                                               widget.datosMotorizado)),
//                                 );
//                               }
//                             });
//                           }

//                           /* Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => InspeccionPantalla4(
//                                     datosMotorizado: widget.datosMotorizado)),
//                           ); */
//                         },
//                         child: Text(
//                           "Siguiente",
//                           style: TextStyle(fontSize: 14.0),
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ))),
//     );
//   }
// }
