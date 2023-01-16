import 'dart:async';
import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mibigbro/models/motorizadoModel.dart';
import 'package:mibigbro/rest_api/provider/motorizado_provider.dart';
import 'package:mibigbro/screens/cotizacion/resumen.dart';
import 'package:mibigbro/utils/dialog.dart';
import 'package:mibigbro/widgets/bigbro_scaffold.dart';
import 'package:mibigbro/widgets/custom_dialog.dart';
import 'package:mibigbro/widgets/selector_foto.dart';

import '../firmar.dart';

class DatosImagenTableroDano extends StatefulWidget {
  DatosImagenTableroDano({
    required this.datosMotorizado,
  });

  final motorizadoModel datosMotorizado;

  @override
  _DatosImagenTableroDanoState createState() => _DatosImagenTableroDanoState();
}

class _DatosImagenTableroDanoState extends State<DatosImagenTableroDano> {
  File? imageTablero;
  File? imageDamage;

  final _pageController = PageController();
  double currentPage = 0.0;

  ValueNotifier<String> subtitleNotifier =
      ValueNotifier<String>('Foto del tablero del automóvil');

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(
        () {
          currentPage = _pageController.page ?? 0.0;

          if (currentPage == 2.0) {
            subtitleNotifier.value = 'Foto del automóvil';
          }

          if (currentPage == 1.0) {
            subtitleNotifier.value =
                'Foto de algun daño con el que cuente el automóvil (si corresponde)';
          }

          if (currentPage == 0.0)
            subtitleNotifier.value = 'Foto del tablero del automóvil';
        },
      );
    });
  }

  Future getImage(String tipoFoto) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 20);

    switch (tipoFoto) {
      case "TABLERO":
        {
          setState(() {
            if (pickedFile != null) {
              imageTablero = File(pickedFile.path);
            } else {
              print('No image selected.');
            }
          });
        }
        break;
      case "DAMAGE":
        {
          setState(() {
            if (pickedFile != null) {
              imageDamage = File(pickedFile.path);
            } else {
              print('No image selected.');
            }
          });
        }
        break;
      default:
        {
          setState(() {
            if (pickedFile != null) {
            } else {
              print('No image selected.');
            }
          });
        }

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: subtitleNotifier,
      builder: (context, subtitle, child) {
        return BigBroScaffold(
          title: 'Datos del motorizado',
          subtitle: subtitle,
          subtitleStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 46,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    width: double.infinity,
                    height: 440,
                    child: PageView(
                      controller: _pageController,
                      children: [
                        SelectorFoto(
                          onTapImagen: () {
                            getImage("TABLERO");
                          },
                          imagen: imageTablero,
                          onTapInfo: () {
                            CustomDialog(
                              context: context,
                              iconColor: Theme.of(context).accentColor,
                              icon: Icon(
                                Icons.camera_alt_outlined,
                                size: 40,
                                color: Colors.white,
                              ),
                              content: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Tomar en cuenta para la foto',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    'Foto del tablero',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                      'La foto debe mostrar todo el tablero del automóvil, asegurate de que se pueda ver la marca de la radio'),
                                  const SizedBox(
                                    height: 32,
                                  )
                                ],
                              ),
                            );
                          },
                          placeHolderAsset: 'assets/img/foto_tablero.png',
                          description:
                              'Se debe tomar la fotografía en un lugar iluminado y con el tablero encendido',
                        ),
                        SelectorFoto(
                          onTapImagen: () {
                            getImage("DAMAGE");
                          },
                          imagen: imageDamage,
                          onTapInfo: () {
                            CustomDialog(
                              context: context,
                              iconColor: Theme.of(context).accentColor,
                              icon: Icon(
                                Icons.camera_alt_outlined,
                                size: 40,
                                color: Colors.white,
                              ),
                              content: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Tomar en cuenta para la foto',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    'Foto del daño',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                      'Si su automóvil tiene algún daño debe incluir una fotografía'),
                                  const SizedBox(
                                    height: 32,
                                  )
                                ],
                              ),
                            );
                          },
                          placeHolderAsset: 'assets/img/foto_dano.png',
                          description:
                              'Se debe tomar la fotografía en un lugar iluminado y con el automóvil limpio',
                        ),
                        _PreviewFotos(
                          imageFrontal: imageTablero,
                          imageTrasera: imageDamage,
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
                      //       backgroundColor: MaterialStateProperty.all(
                      //         Colors.white,
                      //       ),
                      //       shape: MaterialStateProperty.all(
                      //         RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(8),
                      //           side: BorderSide(
                      //             width: 1.0,
                      //             color: Theme.of(context).primaryColor,
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
                            backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
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
                              guardar();
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 750),
                                curve: Curves.linear,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  guardar() async {
    int? idAuto = widget.datosMotorizado.idAutomovil;

    if (imageTablero == null) {
      Fluttertoast.showToast(
          msg: "Debe tomar una fotografía del tablero",
          webPosition: "center",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 7,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 20.0);
    } else {
      DialogoProgreso dialog = DialogoProgreso(context, "Guardando");
      dialog.mostrarDialogo();
      var responseNuevaInspeccion =
          await MotorizadoProvider.fotosInspeccionTablero(
              widget.datosMotorizado.idAutomovil.toString(),
              widget.datosMotorizado.idInspeccion.toString(),
              imageDamage,
              imageTablero!);
      Timer(Duration(seconds: 3), () {
        dialog.ocultarDialogo();
        if (responseNuevaInspeccion != 400) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => Aseguradoras(
          //       datosMotorizado: widget.datosMotorizado,
          //     ),
          //   ),
          // );
          widget.datosMotorizado.idCompania = 1;
          if (widget.datosMotorizado.camino == "nuevo_seguro") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FirmaPoliza(datosMotorizado: widget.datosMotorizado)),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ResumenSeguro(datosMotorizado: widget.datosMotorizado)),
            );
          }
        }
      });
    }
  }
}

class _PreviewFotos extends StatelessWidget {
  final File? imageFrontal;
  final File? imageTrasera;

  const _PreviewFotos({
    Key? key,
    required this.imageFrontal,
    required this.imageTrasera,
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
                      child: imageFrontal == null
                          ? Container()
                          : Image.file(imageFrontal!),
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
                      child: imageTrasera == null
                          ? Container()
                          : Image.file(imageTrasera!),
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 14,
          ),
          Text(
            'Valida que las fotografías se encuentren nítidas antes de continuar',
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
