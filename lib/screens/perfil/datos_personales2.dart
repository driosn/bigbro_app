import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mibigbro/models/datosPersonalesModel.dart';
import 'package:mibigbro/rest_api/provider/datos_personales_provider.dart';
import 'package:mibigbro/utils/dialog.dart';
import 'package:mibigbro/utils/storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mibigbro/utils/key.dart' as llavero;
import 'package:dots_indicator/dots_indicator.dart';

// Create a Form widget.
class DatosPersonales2 extends StatefulWidget {
  final datosPersonalesModel? datosPersonalesData;
  DatosPersonales2({this.datosPersonalesData});
  @override
  DatosPersonalesState2 createState() {
    return DatosPersonalesState2();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class DatosPersonalesState2 extends State<DatosPersonales2> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  String _BASEURL = llavero.Key.BASEURL;
  final _formKey = GlobalKey<FormState>();
  File? _imageCiFrontal;
  File? _imageCiTrasera;
  String? ciFrontaCargado;
  String? ciTraseraCargado;
  final picker = ImagePicker();
  int? idDatosPersonales = 0;
  String textoCiFrontal = "Foto frontal de su carnet de identidad";
  String textoCiTrasera = "Foto posterior de su carnet de identidad";

  final _pageController = PageController();
  double currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page ?? 0.0;
      });
    });
  }

  Future cargarDatosPersonales() async {
    int idUsuario = StorageUtils.getInteger('id_usuario');

    var respuestaDatosPersonales =
        await DatosPersonalesProvider.buscar(idUsuario.toString());
    if (respuestaDatosPersonales.statusCode == 200) {
      var datosPersonalesGuardados = json.decode(respuestaDatosPersonales.body);
      print(datosPersonalesGuardados);
      idDatosPersonales = datosPersonalesGuardados["id"];

      ciFrontaCargado = (datosPersonalesGuardados["ci_frontal"] != null)
          ? _BASEURL + datosPersonalesGuardados["ci_frontal"]
          : null;
      if (ciFrontaCargado != null) {
        textoCiFrontal = "";
      }

      ciTraseraCargado = (datosPersonalesGuardados["ci_trasero"] != null)
          ? _BASEURL + datosPersonalesGuardados["ci_trasero"]
          : null;
      if (ciTraseraCargado != null) {
        textoCiTrasera = "";
      }
    }

    return respuestaDatosPersonales;
  }

  Future getImage(String tipoFoto) async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 20);
    if (tipoFoto == "ciFrontal") {
      setState(() {
        if (pickedFile != null) {
          _imageCiFrontal = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } else {
      setState(() {
        if (pickedFile != null) {
          _imageCiTrasera = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return FutureBuilder(
        future: cargarDatosPersonales(),
        builder: (context, snapshot) {
          //var datosPaquete = json.decode(respuestaPaquetes.body);
          if (snapshot.hasData) {
            return Scaffold(
                body: Column(
              children: [
                Container(
                  height: 190,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.only(
                    top: kToolbarHeight,
                    left: 16,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          color: Theme.of(context).accentColor,
                          onPressed: () => Navigator.pop(context),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Datos Personales',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Actualizar mi perfil',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              height: 440,
                              child: PageView(
                                controller: _pageController,
                                children: [
                                  _FotoFrontal(
                                    imageCiFrontal: _imageCiFrontal,
                                    ciFrontalCargado: ciFrontaCargado,
                                    onTap: () {
                                      getImage('ciFrontal');
                                    },
                                  ),
                                  _FotoTrasera(
                                    imageCiTrasera: _imageCiTrasera,
                                    ciTraseraCargado: ciTraseraCargado,
                                    onTap: () {
                                      getImage('ciTrasera');
                                    },
                                  ),
                                  _PreviewFotos(
                                    imageCiFrontal: _imageCiFrontal,
                                    ciFrontalCargado: ciFrontaCargado,
                                    ciTraseraCargado: ciTraseraCargado,
                                    imageCiTrasera: _imageCiTrasera,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            DotsIndicator(
                              dotsCount: 3,
                              position: currentPage,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                // Expanded(
                                //   child: ElevatedButton(
                                //     style: ButtonStyle(
                                //       elevation: MaterialStateProperty.all(0.0),
                                //       backgroundColor:
                                //           MaterialStateProperty.all(
                                //         Colors.white,
                                //       ),
                                //       shape: MaterialStateProperty.all(
                                //         RoundedRectangleBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(8),
                                //           side: BorderSide(
                                //             width: 1.0,
                                //             color:
                                //                 Theme.of(context).primaryColor,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //     child: Container(
                                //       padding: const EdgeInsets.symmetric(
                                //         vertical: 10,
                                //       ),
                                //       child: Text(
                                //         'Repetir',
                                //         style: TextStyle(
                                //           color: Theme.of(context).primaryColor,
                                //           fontWeight: FontWeight.w600,
                                //         ),
                                //       ),
                                //     ),
                                //     onPressed: () {},
                                //   ),
                                // ),
                                // const SizedBox(
                                //   width: 22,
                                // ),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0.0),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Theme.of(context).primaryColor,
                                      ),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          side: BorderSide(
                                            width: 1.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: Text(
                                        'Continuar',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (_pageController.page == 2.0) {
                                        bool imagenCiFrontal =
                                            ciFrontaCargado != null ||
                                                _imageCiFrontal != null;
                                        bool imagenCiTrasera =
                                            ciTraseraCargado != null ||
                                                _imageCiTrasera != null;

                                        print(imagenCiFrontal);
                                        print(imagenCiTrasera);

                                        if (_formKey.currentState!.validate() &&
                                            imagenCiFrontal &&
                                            imagenCiTrasera) {
                                          DialogoProgreso dialog =
                                              DialogoProgreso(
                                                  context, "Guardando");
                                          dialog.mostrarDialogo();
                                          var respuestaDatosPersonales =
                                              await DatosPersonalesProvider
                                                  .updateFotos(
                                                      idDatosPersonales
                                                          .toString(),
                                                      _imageCiFrontal,
                                                      _imageCiTrasera,
                                                      widget
                                                          .datosPersonalesData!
                                                          .nombre,
                                                      widget
                                                          .datosPersonalesData!
                                                          .apellidoPaterno,
                                                      widget
                                                          .datosPersonalesData!
                                                          .apellidoMaterno,
                                                      widget
                                                          .datosPersonalesData!
                                                          .idUser,
                                                      widget
                                                          .datosPersonalesData!
                                                          .ocupacion,
                                                      widget
                                                          .datosPersonalesData!
                                                          .ciudad);

                                          print("Actualizar 2");
                                          Timer(Duration(seconds: 3), () {
                                            dialog.ocultarDialogo();

                                            Navigator.pushNamedAndRemoveUntil(
                                                context, "home", (r) => false);
                                          });
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Ingrese su ocupación, actividad y fotos de su documento de identidad",
                                              webPosition: "center",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 7,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                              fontSize: 20.0);
                                        }
                                      } else {
                                        _pageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 750),
                                          curve: Curves.linear,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     getImage("ciTrasera");
                            //   },
                            //   child: Container(
                            //     margin: EdgeInsets.only(
                            //         left: 24, right: 24, top: 24, bottom: 12),
                            //     padding: EdgeInsets.all(24),
                            //     height: 150,
                            //     width: 300,
                            //     decoration: BoxDecoration(
                            //       image: DecorationImage(
                            //           fit: BoxFit.scaleDown,
                            //           image: _imageCiTrasera == null
                            //               ? (ciTraseraCargado == null
                            //                       ? ExactAssetImage(
                            //                           "assets/img/camara.png",
                            //                         )
                            //                       : NetworkImage(
                            //                           ciTraseraCargado!))
                            //                   as ImageProvider<Object>
                            //               : FileImage(_imageCiTrasera!)),
                            //       border: Border.all(
                            //         color: Colors.red,
                            //         width: 2,
                            //       ),
                            //       borderRadius: BorderRadius.circular(12),
                            //     ),
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Text(textoCiTrasera,
                            //             textAlign: TextAlign.center),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(height: 15),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     TextButton(
                            //       color: Color(0xff1D2766),
                            //       textColor: Colors.white,
                            //       disabledColor: Colors.grey,
                            //       disabledTextColor: Colors.black,
                            //       padding: EdgeInsets.all(8.0),
                            //       splashColor: Colors.blueAccent,
                            // onPressed: () async {
                            //   bool imagenCiFrontal =
                            //       ciFrontaCargado != null ||
                            //           _imageCiFrontal != null;
                            //   bool imagenCiTrasera =
                            //       ciTraseraCargado != null ||
                            //           _imageCiTrasera != null;

                            //   print(imagenCiFrontal);
                            //   print(imagenCiTrasera);

                            //   if (_formKey.currentState!.validate() &&
                            //       imagenCiFrontal &&
                            //       imagenCiTrasera) {
                            //     DialogoProgreso dialog =
                            //         DialogoProgreso(context, "Guardando");
                            //     dialog.mostrarDialogo();
                            //     var respuestaDatosPersonales =
                            //         await DatosPersonalesProvider
                            //             .updateFotos(
                            //                 idDatosPersonales.toString(),
                            //                 _imageCiFrontal,
                            //                 _imageCiTrasera,
                            //                 widget.datosPersonalesData!
                            //                     .nombre,
                            //                 widget.datosPersonalesData!
                            //                     .apellidoPaterno,
                            //                 widget.datosPersonalesData!
                            //                     .apellidoMaterno,
                            //                 widget.datosPersonalesData!
                            //                     .idUser,
                            //                 widget.datosPersonalesData!
                            //                     .ocupacion,
                            //                 widget.datosPersonalesData!
                            //                     .ciudad);

                            //     print("Actualizar 2");
                            //     Timer(Duration(seconds: 3), () {
                            //       dialog.ocultarDialogo();

                            //       Navigator.pushNamedAndRemoveUntil(
                            //           context, "home", (r) => false);
                            //     });
                            //   } else {
                            //     Fluttertoast.showToast(
                            //         msg:
                            //             "Ingrese su ocupación, actividad y fotos de su documento de identidad",
                            //         webPosition: "center",
                            //         toastLength: Toast.LENGTH_LONG,
                            //         gravity: ToastGravity.BOTTOM,
                            //         timeInSecForIosWeb: 7,
                            //         backgroundColor: Colors.black,
                            //         textColor: Colors.white,
                            //         fontSize: 20.0);
                            //   }
                            // },
                            //       child: Text(
                            //         "Guardar",
                            //         style: TextStyle(fontSize: 14.0),
                            //       ),
                            //     ),
                            // ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

class _FotoFrontal extends StatelessWidget {
  final File? imageCiFrontal;
  final VoidCallback onTap;
  final String? ciFrontalCargado;

  const _FotoFrontal({
    Key? key,
    required this.imageCiFrontal,
    required this.onTap,
    required this.ciFrontalCargado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Container(
              height: 370,
              width: 280,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color(0xffEC1C24),
                ),
              ),
              child: imageCiFrontal == null
                  ? ciFrontalCargado != null
                      ? Image.network(ciFrontalCargado!)
                      : Image.asset('assets/img/ci_placeholder.png')
                  : Image.file(imageCiFrontal!),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            'Toma una fotografía de la parte frontal de tu cédula de identidad',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _FotoTrasera extends StatelessWidget {
  final File? imageCiTrasera;
  final VoidCallback onTap;
  final String? ciTraseraCargado;

  const _FotoTrasera({
    Key? key,
    required this.imageCiTrasera,
    required this.onTap,
    required this.ciTraseraCargado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Container(
              height: 370,
              width: 280,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color(0xffEC1C24),
                ),
              ),
              child: imageCiTrasera == null
                  ? ciTraseraCargado != null
                      ? Image.network(ciTraseraCargado!)
                      : Image.asset('assets/img/ci_placeholder.png')
                  : Image.file(imageCiTrasera!),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            'Toma una fotografía de la parte posterior de tu cédula de identidad',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewFotos extends StatelessWidget {
  final File? imageCiFrontal;
  final File? imageCiTrasera;
  final String? ciFrontalCargado;
  final String? ciTraseraCargado;

  const _PreviewFotos({
    Key? key,
    required this.imageCiFrontal,
    required this.imageCiTrasera,
    required this.ciFrontalCargado,
    required this.ciTraseraCargado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              height: 370,
              width: 280,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xffEC1C24),
                        ),
                      ),
                      child: imageCiFrontal == null
                          ? ciFrontalCargado != null
                              ? Image.network(ciFrontalCargado!)
                              : Container()
                          : Image.file(imageCiFrontal!),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xffEC1C24),
                        ),
                      ),
                      child: imageCiTrasera == null
                          ? ciTraseraCargado != null
                              ? Image.network(ciTraseraCargado!)
                              : Container()
                          : Image.file(imageCiTrasera!),
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 14,
          ),
          Text(
            'Valida que las fotografías se encuentren nítidas antes de  continuar',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
