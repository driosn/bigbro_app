// import 'dart:async';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mibigbro/models/motorizadoModel.dart';
// import 'package:mibigbro/rest_api/provider/motorizado_provider.dart';

// import 'package:mibigbro/screens/cotizacion/aseguradoras.dart';
// import 'package:mibigbro/screens/cotizacion/inspeccion/pantalla3.dart';
// import 'package:mibigbro/screens/cotizacion/inspeccion/datos_imagen_tablero_dano.dart';
// import 'package:mibigbro/screens/cotizacion/resumen.dart';
// import 'package:mibigbro/utils/dialog.dart';

// class InspeccionPantalla2 extends StatefulWidget {
//   final motorizadoModel? datosMotorizado;
//   InspeccionPantalla2({this.datosMotorizado});

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
//   _InspeccionPantalla2State createState() => _InspeccionPantalla2State();
// }

// class _InspeccionPantalla2State extends State<InspeccionPantalla2> {
//   final appTitle = 'Datos del motorizado';

//   File? _imageFrontal;
//   File? _imageTrasera;

//   final picker = ImagePicker();

//   Future getImage(String tipoFoto) async {
//     final pickedFile =
//         await picker.getImage(source: ImageSource.camera, imageQuality: 20);

//     switch (tipoFoto) {
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

//       default:
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
//                 style: InspeccionPantalla2.panelTitleStyle,
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
//                     style: InspeccionPantalla2.panelStyle,
//                     textAlign: TextAlign.center,
//                   ),
//                   Text(detalle,
//                       style: InspeccionPantalla2.panelTitleStyleDialog,
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
//                       style: InspeccionPantalla2.panelTitleStyle,
//                       textAlign: TextAlign.center),
//                   Text(
//                       "Se debe tomar en un lugar iluminado y con el vehículo limpio",
//                       style: InspeccionPantalla2.panelTitleStyle,
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
//                                 image:
//                                     (_imageFrontal == null
//                                             ? ExactAssetImage(
//                                                 "assets/img/camara.png")
//                                             : FileImage(_imageFrontal!))
//                                         as ImageProvider<Object>),
//                             border: Border.all(
//                               color: Color(0xff1D2766),
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               if (_imageFrontal == null)
//                                 Text(
//                                   "Frontal",
//                                   style: InspeccionPantalla2.panelStyle,
//                                   textAlign: TextAlign.center,
//                                 ),
//                               SizedBox(height: 5),
//                               if (_imageFrontal == null)
//                                 Image.asset(
//                                   'assets/img/autofrontal.png',
//                                   width: 70,
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
//                                             "Foto frontal",
//                                             "La foto debe mostrar toda la parte delantera del vehículo y la placa",
//                                             'assets/img/autofrontal.png');
//                                       },
//                                       child: Icon(
//                                         Icons.info_outline,
//                                         size: 40.0,
//                                         color: Color(0xff1D2766),
//                                       )),
//                                   SizedBox(
//                                       width: 45,
//                                       child: RawMaterialButton(
//                                         onPressed: () {
//                                           getImage("FRONTAL");
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
//                                 image:
//                                     (_imageTrasera == null
//                                             ? ExactAssetImage(
//                                                 "assets/img/camara.png")
//                                             : FileImage(_imageTrasera!))
//                                         as ImageProvider<Object>),
//                             border: Border.all(
//                               color: Color(0xff1D2766),
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               if (_imageTrasera == null)
//                                 Text(
//                                   "Trasera",
//                                   style: InspeccionPantalla2.panelStyle,
//                                   textAlign: TextAlign.center,
//                                 ),
//                               SizedBox(height: 5),
//                               if (_imageTrasera == null)
//                                 Image.asset(
//                                   'assets/img/autotrasero.png',
//                                   width: 70,
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
//                                             "Foto trasera",
//                                             "La foto debe mostrar la parte trasera del vehículo con la placa visible",
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
//                                           getImage("TRASERA");
//                                         },
//                                         elevation: 10.0,
//                                         fillColor: Colors.red,
//                                         child: Icon(
//                                           Icons.camera_alt,
//                                           size: 20.0,
//                                           color: Colors.white,
//                                         ),
//                                         padding: EdgeInsets.all(5.0),
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

//                           if (_imageFrontal == null || _imageTrasera == null) {
//                             Fluttertoast.showToast(
//                                 msg:
//                                     "Debe tomar la foto frontal y trasera del automóvil",
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
//                             Response responseNuevaInspeccion =
//                                 await (MotorizadoProvider
//                                     .fotosInspeccionFrontalTrasera(
//                                         idAuto.toString(),
//                                         _imageFrontal!,
//                                         _imageTrasera!)) as Response<dynamic>;
//                             print(responseNuevaInspeccion.data["id"]);
//                             Timer(Duration(seconds: 3), () {
//                               dialog.ocultarDialogo();
//                               widget.datosMotorizado!.idInspeccion =
//                                   responseNuevaInspeccion.data["id"];
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => InspeccionPantalla4(
//                                         datosMotorizado:
//                                             widget.datosMotorizado)),
//                               );
//                             });
//                           }
//                           /* Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => InspeccionPantalla3(
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
