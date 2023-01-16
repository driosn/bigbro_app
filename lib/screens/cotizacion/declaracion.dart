import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mibigbro/models/motorizadoModel.dart';
import 'package:mibigbro/screens/cotizacion/firmar.dart';
import 'package:url_launcher/url_launcher.dart';

class Declaracion extends StatefulWidget {
  final motorizadoModel? datosMotorizado;
  Declaracion({this.datosMotorizado});

  static const TextStyle titleStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);
  static const TextStyle infoStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w300);
  static const TextStyle infoPrecioStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);

  @override
  _DeclaracionState createState() => _DeclaracionState();
}

class _DeclaracionState extends State<Declaracion> {
  final appTitle = 'Declaración';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff1D2766), //change your color here
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(appTitle, style: TextStyle(color: Color(0xff1D2766))),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Column(
                children: [
                  Text("Resumen de tu seguro",
                      style: Declaracion.titleStyle,
                      textAlign: TextAlign.center),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            "Mediante la presente, declaro voluntariamente que la información proporcionada a Sudamericana Seguros y Reaseguros mediante de miBigBro, sobre mi persona así como los datos y características del vehículo a ser asegurado son veraces y fidedignos para todos los efectos legales consiguientes.",
                            style: Declaracion.infoStyle,
                            textAlign: TextAlign.center,
                          ))
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            "De igual forma declaro que me adhiero voluntariamente, a los términos y condiciones pactados en la(s) póliza(s) de seguro(s) a ser emitida a mi favor, obligándome a pagar la correspondiente prima de seguro.",
                            style: Declaracion.infoStyle,
                            textAlign: TextAlign.center,
                          ))
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          _launchTerminosURL();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.file_download,
                              size: 20.0,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 150,
                              child: Text(
                                "Descargar borrador de términos y condiciones",
                                style: TextStyle(fontSize: 12.0),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FirmaPoliza(
                                    datosMotorizado: widget.datosMotorizado)),
                          );
                        },
                        child: Text(
                          "Firmar",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  )
                ],
              ))),
    );
  }

  _launchTerminosURL() async {
    const url = 'http://181.188.186.158:8000/media/terminos.pdf';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
