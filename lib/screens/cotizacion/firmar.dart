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
import 'package:mibigbro/widgets/bigbro_scaffold.dart';
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
    return BigBroScaffold(
      title: 'Firma de la póliza',
      subtitle: 'Ingrese su firma en el recuadro',
      subtitleStyle: TextStyle(
        color: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 10),
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
                  height: 360,
                  width: 300,
                  backgroundColor: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _controller.clear();
                },
                child: Text(
                  "Borrar firma",
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _valueCheckTerminos = !(_valueCheckTerminos ?? true);
                      });
                    },
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 4,
                        color: Theme.of(context).primaryColor,
                      )),
                      child: _valueCheckTerminos ?? false
                          ? Center(
                              child: Icon(
                              Icons.check,
                              size: 14,
                              color: Theme.of(context).primaryColor,
                            ))
                          : SizedBox(),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: Text(
                    "Estoy de acuerdo con los términos y condiciones de la póliza",
                    style: TextStyle(color: Color(0xff1D2766), fontSize: 15),
                  )),
                ],
              ),
              SizedBox(
                height: 48,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              (_valueCheckTerminos!)
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey),
                        ),
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
                              final Uint8List dataFirma =
                                  await (_controller.toPngBytes()) as Uint8List;
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
          ),
        ),
      ),
    );
  }
}
