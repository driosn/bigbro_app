import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mibigbro/models/motorizadoModel.dart';
import 'package:mibigbro/rest_api/provider/datos_personales_provider.dart';
import 'package:mibigbro/rest_api/provider/poliza_provider.dart';
import 'package:mibigbro/screens/cotizacion/declaracion.dart';
import 'package:mibigbro/screens/cotizacion/resumen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';

class FirmaPoliza extends StatefulWidget {
  final motorizadoModel? datosMotorizado;
  FirmaPoliza({this.datosMotorizado});
  @override
  _FirmaPolizaState createState() => _FirmaPolizaState();
}

class _FirmaPolizaState extends State<FirmaPoliza> {
  final appTitle = 'Firma de póliza';
  File? _imageFirma;
  bool? _valueCheckTerminos = true;
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print("Value changed"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff1D2766), //change your color here
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/home", (r) => false);
                },
                child: Icon(
                  Icons.home_outlined,
                  size: 26.0,
                ),
              ))
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(appTitle, style: TextStyle(color: Color(0xff1D2766))),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            value: _valueCheckTerminos,
                            activeColor: Color(0xff1D2766),
                            onChanged: (newValue) {
                              setState(() {
                                _valueCheckTerminos = newValue;
                              });
                            },
                          )),
                      Expanded(
                          child: Text(
                        "Estoy de acuerdo con los términos y condiciones de la póliza",
                        style:
                            TextStyle(color: Color(0xff1D2766), fontSize: 15),
                      )),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("Ingrese su firma en el recuadro",
                      style: TextStyle(
                          color: Color(0xff1D2766),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center),
                  Container(
                    margin:
                        EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 20),
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff1D2766),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Signature(
                      controller: _controller,
                      height: 300,
                      width: 300,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  TextButton(
                      // color: Color(0xff1D2766),
                      // textColor: Colors.white,
                      // disabledColor: Colors.grey,
                      // disabledTextColor: Colors.black,
                      // padding: EdgeInsets.all(8.0),
                      // splashColor: Colors.blueAccent,
                      onPressed: () {
                        _controller.clear();
                      },
                      child: Text(
                        "Borrar firma",
                        style: TextStyle(fontSize: 14.0),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Así mismo autorizo a Sudamericana a administrar mi seguro, verificar mis datos mediante el formulario UIF y utilizar mi firma electrónica en la recepción del certificado",
                      style: TextStyle(color: Color(0xff1D2766), fontSize: 16),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          flex: 1,
                          child: TextButton(
                            // color: _valueCheckTerminos!
                            //     ? Color(0xff1D2766)
                            //     : Colors.grey,
                            // textColor: _valueCheckTerminos!
                            //     ? Colors.white
                            //     : Colors.black,
                            // disabledColor: Colors.grey,
                            // disabledTextColor: Colors.black,
                            // padding: EdgeInsets.all(8.0),
                            // splashColor: Colors.blueAccent,
                            onPressed: () async {
                              if (_valueCheckTerminos!) {
                                /* print(widget.datosMotorizado.coberturas);
                                print(widget.datosMotorizado.inicioVigencia);
                                print(widget.datosMotorizado.finVigencia);
                                print(widget.datosMotorizado.costo); */
                                /* 
                                print("Poliza creada");
                                print(polizaCreada.body);
                                Map<String, dynamic> datosRespuestaPoliza =
                                    json.decode(polizaCreada.body);
                                widget.datosMotorizado.idPoliza =
                                    datosRespuestaPoliza["id"];
                                print(widget.datosMotorizado.idPoliza); */

                                if (_controller.isNotEmpty) {
                                  final Uint8List dataFirma = await (_controller
                                      .toPngBytes()) as Uint8List;
                                  var respuestaDatosPersonales =
                                      await DatosPersonalesProvider.updateFirma(
                                          dataFirma);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResumenSeguro(
                                            datosMotorizado:
                                                widget.datosMotorizado)),
                                  );
                                }
                              }
                            },
                            child: _valueCheckTerminos!
                                ? Text(
                                    "Continuar",
                                    style: TextStyle(fontSize: 14.0),
                                  )
                                : Text(
                                    "Debe aceptar los términos y condiciones",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                          ))
                    ],
                  )
                ],
              ))),
    );
  }
}
