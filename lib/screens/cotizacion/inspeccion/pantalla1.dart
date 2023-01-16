import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mibigbro/models/motorizadoModel.dart';

import 'package:mibigbro/screens/cotizacion/inspeccion/datos_imagen_ruat.dart';
import 'package:mibigbro/widgets/bigbro_scaffold.dart';
import 'package:mibigbro/widgets/selector_numero.dart';

class InspeccionPantalla1 extends StatefulWidget {
  final motorizadoModel? datosMotorizado;

  InspeccionPantalla1({this.datosMotorizado});

  static const TextStyle panelTitleStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 14.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);
  static const TextStyle panelTitleStyleDialog = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w300);
  static const TextStyle panelStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 18.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w300);

  @override
  _InspeccionPantalla1State createState() => _InspeccionPantalla1State();
}

class _InspeccionPantalla1State extends State<InspeccionPantalla1> {
  final _formKeyDetalleMotorizado = GlobalKey<FormState>();
  final appTitle = 'Datos del motorizado';
  // final TextEditingController _placaController = TextEditingController();
  final TextEditingController _placaPrimeraParteController =
      TextEditingController();
  final TextEditingController _placaSegundaParteController =
      TextEditingController();
  final TextEditingController _chasisController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _motorController = TextEditingController();
  final TextEditingController _asientosController = TextEditingController();
  final TextEditingController _cilindradaController = TextEditingController();
  final TextEditingController _toneladasController = TextEditingController();
  File? _imageRuat;

  int numeroAsientos = 2;

  final picker = ImagePicker();

  Future getImage(String tipoFoto) async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 20);

    switch (tipoFoto) {
      case "RUAT":
        {
          setState(() {
            if (pickedFile != null) {
              _imageRuat = File(pickedFile.path);
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
              _imageRuat = File(pickedFile.path);
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
    Future<void> _showMyDialogIndicaciones(
        String title, String detalle, String pathImage) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Tomar en cuenta para la foto',
                style: InspeccionPantalla1.panelTitleStyle,
                textAlign: TextAlign.center),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  /* Image.asset(
                    pathImage,
                    width: 50,
                  ), */
                  Icon(
                    Icons.camera_alt_rounded,
                    size: 50.0,
                    color: Color(0xff1D2766),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    style: InspeccionPantalla1.panelStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(detalle,
                      style: InspeccionPantalla1.panelTitleStyleDialog,
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return BigBroScaffold(
      title: appTitle,
      subtitle: 'Ingrese los datos del certificado CRPVA de su automóvil',
      body: SingleChildScrollView(
        child: Form(
          key: _formKeyDetalleMotorizado,
          child: Container(
            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          maxLength: 4,
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                            FilteringTextInputFormatter.allow(
                              RegExp("[0-9]"),
                            )
                          ],
                          controller: _placaPrimeraParteController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese la primera parte de la placa';
                            }

                            if (value.toLowerCase().contains(RegExp("[0-9]"))) {
                            } else {
                              return 'La primera parte de la placa debe contener 4 números.';
                            }

                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Placa Primera Parte',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff1D2766),
                                ),
                              )),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '-',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1D2766),
                          fontSize: 32.0,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          maxLength: 3,
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                            FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z]"),
                            )
                          ],
                          controller: _placaSegundaParteController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese la segunda parte de la placa';
                            }

                            if (value.contains(RegExp("[a-zA-Z]"))) {
                            } else {
                              return 'La segunda parte de la placa debe contener 3 letras.';
                            }

                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Placa Segunda Parte',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff1D2766),
                                ),
                              )),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.info, color: Color(0xff1D2766)),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/img/placa-bolivia.jpeg',
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      '*Ejemplo de placa válida en Bolivia',
                                    )
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('Aceptar'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  maxLength: 25,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"))
                  ],
                  controller: _chasisController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el chasis';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Número de chasis',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff1D2766),
                        ),
                      )),
                ),
                TextFormField(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]"))
                  ],
                  controller: _colorController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el color del vehículo';
                    }
                    return null;
                  },
                  maxLength: 25,
                  decoration: const InputDecoration(
                    labelText: 'Color',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff1D2766),
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  maxLength: 25,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"))
                  ],
                  controller: _motorController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el número del motor';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Número de motor',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff1D2766),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Número de asientos'),
                ),
                const SizedBox(
                  height: 12,
                ),
                SelectorNumero(
                  valorMinimo: numeroAsientos,
                  valorInicial: numeroAsientos,
                  valorMaximo: 30,
                  onChanged: (nuevonNumAsientos) {
                    numeroAsientos = nuevonNumAsientos!;
                  },
                ),
                // TextFormField(
                //   keyboardType: TextInputType.number,
                //   inputFormatters: <TextInputFormatter>[
                //     FilteringTextInputFormatter.allow(
                //       RegExp(r"^[0-9]{0,2}$"),
                //     )
                //   ],
                //   controller: _asientosController,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Ingrese el número de asientos';
                //     }
                //     return null;
                //   },
                //   decoration: const InputDecoration(
                //       labelText: 'Número asientos',
                //       enabledBorder: UnderlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Color(0xff1D2766),
                //         ),
                //       )),
                // ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    UpperCaseTextFormatter(),
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.allow(
                      RegExp(r"^[0-9]{0,5}$"),
                    )
                  ],
                  controller: _cilindradaController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese la cilindrada del vehículo';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Cilindrada',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff1D2766),
                        ),
                      )),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    UpperCaseTextFormatter(),
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.allow(
                      RegExp(r"^[0-9]{0,1}$"),
                    )
                  ],
                  controller: _toneladasController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el peso del vehículo';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Peso (Toneladas)',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff1D2766),
                        ),
                      )),
                ),
                SizedBox(height: 30),
                // Text("Foto del documento RUAT",
                //     style: InspeccionPantalla1.panelTitleStyle,
                //     textAlign: TextAlign.center),
                // SizedBox(height: 10),
                // Text(
                //     "En la foto debe estar visible el RUAT del vehículo a asegurar.",
                //     style: InspeccionPantalla1.panelStyle,
                //     textAlign: TextAlign.center),
                // SizedBox(height: 30),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: () {},
                //       child: Container(
                //           width: 250,
                //           height: 200,
                //           padding: EdgeInsets.all(10),
                //           decoration: BoxDecoration(
                //             image: DecorationImage(
                //                 fit: BoxFit.scaleDown,
                //                 image: (_imageRuat == null
                //                     ? ExactAssetImage("assets/img/camara.png")
                //                     : FileImage(
                //                         _imageRuat!)) as ImageProvider<Object>),
                //             border: Border.all(
                //               color: Color(0xff1D2766),
                //               width: 1,
                //             ),
                //             borderRadius: BorderRadius.circular(12),
                //           ),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: [
                //               if (_imageRuat == null)
                //                 Text(
                //                   "RUAT",
                //                   style: InspeccionPantalla1.panelStyle,
                //                   textAlign: TextAlign.center,
                //                 ),
                //               if (_imageRuat == null)
                //                 Icon(
                //                   Icons.note,
                //                   size: 40.0,
                //                   color: Color(0xff1D2766),
                //                 ),
                //               // Row(
                //               //   mainAxisAlignment:
                //               //       MainAxisAlignment.spaceAround,
                //               //   children: [
                //               //     GestureDetector(
                //               //         onTap: () {
                //               //           _showMyDialogIndicaciones(
                //               //               "Foto RUAT",
                //               //               "La foto debe mostrar el documento completo",
                //               //               'assets/img/autofrontal.png');
                //               //         },
                //               //         child: Icon(
                //               //           Icons.info_outline,
                //               //           size: 50.0,
                //               //           color: Color(0xff1D2766),
                //               //         )),
                //               //     // SizedBox(
                //               //     //     width: 40,
                //               //     //     height: 40,
                //               //     //     child: RawMaterialButton(
                //               //     //       onPressed: () {
                //               //     //         getImage("RUAT");
                //               //     //       },
                //               //     //       elevation: 10.0,
                //               //     //       fillColor: Colors.red,
                //               //     //       child: Icon(
                //               //     //         Icons.camera_alt,
                //               //     //         size: 20.0,
                //               //     //         color: Colors.white,
                //               //     //       ),
                //               //     //       padding: EdgeInsets.all(2.0),
                //               //     //       shape: CircleBorder(),
                //               //     //     ))
                //               //   ],
                //               // )
                //             ],
                //           )),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        int? idAuto = widget.datosMotorizado!.idAutomovil;

                        if (!_formKeyDetalleMotorizado.currentState!
                            .validate()) {
                          Fluttertoast.showToast(
                              msg:
                                  // "Debe llenar todos los datos y la foto del RUAT",
                                  "Debe llenar todos los datos",
                              webPosition: "center",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 7,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 20.0);
                        } else {
                          // DialogoProgreso dialog =
                          //     DialogoProgreso(context, "Guardando");
                          // dialog.mostrarDialogo();
                          // Response? responseActualizarAuto =
                          //     await MotorizadoProvider
                          //         .actulizarAutoInspeccion(
                          //             idAuto.toString(),
                          //             _imageRuat!,
                          //             _placaPrimeraParteController.text +
                          //                 _placaSegundaParteController.text,
                          //             _chasisController.text,
                          //             _colorController.text,
                          //             _motorController.text,
                          //             numeroAsientos.toString(),
                          //             // _asientosController.text,
                          //             _cilindradaController.text,
                          //             _toneladasController.text);

                          // Timer(Duration(seconds: 3), () {
                          //   dialog.ocultarDialogo();
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => InspeccionPantalla2(
                          //             datosMotorizado:
                          //                 widget.datosMotorizado)),
                          //   );
                          // });
                          Timer(Duration(seconds: 1), () {
                            // dialog.ocultarDialogo();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DatosImagenRuat(
                                  datosMotorizado: widget.datosMotorizado!,
                                  formularioDatosBasicos:
                                      FormularioDatosBasicos(
                                    chasis: _chasisController.text,
                                    cilindrada: _cilindradaController.text,
                                    color: _colorController.text,
                                    motor: _motorController.text,
                                    numeroAsientos: numeroAsientos.toString(),
                                    placaPrimeraParte:
                                        _placaPrimeraParteController.text,
                                    placaSegundaParte:
                                        _placaSegundaParteController.text,
                                    toneladas: _toneladasController.text,
                                  ),
                                ),
                              ),
                            );
                          });
                        }

                        /* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InspeccionPantalla2(
                                    datosMotorizado: widget.datosMotorizado)),
                          ); */
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        child: Text(
                          "Siguiente",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
