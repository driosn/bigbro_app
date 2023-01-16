import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mibigbro/models/motorizadoModel.dart';
import 'package:mibigbro/rest_api/provider/motorizado_provider.dart';
import 'package:mibigbro/screens/cotizacion/inspeccion/datos_imagen_frontal_trasera.dart';
import 'package:mibigbro/utils/dialog.dart';
import 'package:mibigbro/widgets/bigbro_scaffold.dart';
import 'package:mibigbro/widgets/custom_dialog.dart';
import 'package:mibigbro/widgets/selector_foto.dart';

class DatosImagenRuat extends StatefulWidget {
  final motorizadoModel datosMotorizado;
  final FormularioDatosBasicos formularioDatosBasicos;

  DatosImagenRuat({
    required this.datosMotorizado,
    required this.formularioDatosBasicos,
  });

  @override
  _DatosImagenRuatState createState() => _DatosImagenRuatState();
}

class _DatosImagenRuatState extends State<DatosImagenRuat> {
  File? imageRuat;

  @override
  Widget build(BuildContext context) {
    return BigBroScaffold(
      title: 'Datos del motorizado',
      subtitle: 'Foto del documento RUAT',
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
              SelectorFoto(
                onTapImagen: () {
                  getImage("RUAT");
                },
                imagen: imageRuat,
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
                        Text(
                          'Tomar en cuenta para la foto',
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
                            'En la foto debe estar visible el RUAT del vehículo a asegurar'),
                        const SizedBox(
                          height: 32,
                        )
                      ],
                    ),
                  );
                },
                placeHolderAsset: 'assets/img/foto_ruat.png',
                description:
                    'En la fotografía debe estar visible el RUAT del vehículo a asegurar',
              ),
              const SizedBox(
                height: 24,
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
                        int? idAuto = widget.datosMotorizado.idAutomovil;

                        if (imageRuat == null) {
                          Fluttertoast.showToast(
                              msg:
                                  // "Debe llenar todos los datos y la foto del RUAT",
                                  "Debe subir foto del RUAT",
                              webPosition: "center",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 7,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 20.0);
                        } else {
                          DialogoProgreso dialog =
                              DialogoProgreso(context, "Guardando");
                          dialog.mostrarDialogo();
                          Response? responseActualizarAuto =
                              await MotorizadoProvider.actulizarAutoInspeccion(
                            idAuto.toString(),
                            imageRuat!,
                            widget.formularioDatosBasicos.placaPrimeraParte +
                                widget.formularioDatosBasicos.placaSegundaParte,
                            widget.formularioDatosBasicos.chasis,
                            widget.formularioDatosBasicos.color,
                            widget.formularioDatosBasicos.motor,
                            widget.formularioDatosBasicos.numeroAsientos,
                            widget.formularioDatosBasicos.cilindrada,
                            widget.formularioDatosBasicos.toneladas,
                          );

                          Timer(Duration(seconds: 3), () {
                            dialog.ocultarDialogo();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DatosImagenFrontalTrasera(
                                  datosMotorizado: widget.datosMotorizado,
                                ),
                              ),
                            );
                          });
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
  }

  Future getImage(String tipoFoto) async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 20);

    switch (tipoFoto) {
      case "RUAT":
        {
          setState(() {
            if (pickedFile != null) {
              imageRuat = File(pickedFile.path);
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
              imageRuat = File(pickedFile.path);
            } else {
              print('No image selected.');
            }
          });
        }

        break;
    }
  }
}

class FormularioDatosBasicos {
  const FormularioDatosBasicos({
    required this.placaPrimeraParte,
    required this.placaSegundaParte,
    required this.chasis,
    required this.color,
    required this.motor,
    required this.numeroAsientos,
    required this.cilindrada,
    required this.toneladas,
  });

  final String placaPrimeraParte;
  final String placaSegundaParte;
  final String chasis;
  final String color;
  final String motor;
  final String numeroAsientos;
  final String cilindrada;
  final String toneladas;
}
