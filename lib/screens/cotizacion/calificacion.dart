import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mibigbro/models/motorizadoModel.dart';
import 'package:mibigbro/rest_api/provider/calificacion_provider.dart';

class Calificacion extends StatefulWidget {
  final motorizadoModel? datosMotorizado;

  Calificacion({this.datosMotorizado});
  static const TextStyle labelStyle = TextStyle(
      color: Colors.red,
      fontSize: 14.0,
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
  _CalificacionState createState() => _CalificacionState();
}

class _CalificacionState extends State<Calificacion> {
  final appTitle = 'Ayúdanos a mejorar';
  Image? imgCara1;
  Image? imgCara2;
  Image? imgCara3;
  Image? imgCara4;
  Image? imgCara5;
  int puntos = 5;
  final _controllerMensaje = TextEditingController();

  Image imagenCara1Act = Image.asset(
    'assets/img/cara1full.png',
    width: 50,
  );

  Image imagenCara1Des = Image.asset(
    'assets/img/cara1.png',
    width: 50,
  );

  Image imagenCara2Act = Image.asset(
    'assets/img/cara2full.png',
    width: 50,
  );

  Image imagenCara2Des = Image.asset(
    'assets/img/cara2.png',
    width: 50,
  );

  Image imagenCara3Act = Image.asset(
    'assets/img/cara3full.png',
    width: 50,
  );

  Image imagenCara3Des = Image.asset(
    'assets/img/cara3.png',
    width: 50,
  );

  Image imagenCara4Act = Image.asset(
    'assets/img/cara4full.png',
    width: 50,
  );

  Image imagenCara4Des = Image.asset(
    'assets/img/cara4.png',
    width: 50,
  );

  Image imagenCara5Act = Image.asset(
    'assets/img/cara5full.png',
    width: 50,
  );

  Image imagenCara5Des = Image.asset(
    'assets/img/cara5.png',
    width: 50,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imgCara1 = imagenCara1Act;
    imgCara2 = imagenCara2Des;
    imgCara3 = imagenCara3Des;
    imgCara4 = imagenCara4Des;
    imgCara5 = imagenCara5Des;
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
              padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: Column(
                children: [
                  Text("Elige tu experiencia.",
                      style: Calificacion.infoStyle,
                      textAlign: TextAlign.center),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            imgCara1 = imagenCara1Act;
                            imgCara2 = imagenCara2Des;
                            imgCara3 = imagenCara3Des;
                            imgCara4 = imagenCara4Des;
                            imgCara5 = imagenCara5Des;
                            puntos = 5;
                          });
                        },
                        child: imgCara1,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            imgCara1 = imagenCara1Des;
                            imgCara2 = imagenCara2Act;
                            imgCara3 = imagenCara3Des;
                            imgCara4 = imagenCara4Des;
                            imgCara5 = imagenCara5Des;
                            puntos = 4;
                          });
                        },
                        child: imgCara2,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            imgCara1 = imagenCara1Des;
                            imgCara2 = imagenCara2Des;
                            imgCara3 = imagenCara3Act;
                            imgCara4 = imagenCara4Des;
                            imgCara5 = imagenCara5Des;
                            puntos = 3;
                          });
                        },
                        child: imgCara3,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            imgCara1 = imagenCara1Des;
                            imgCara2 = imagenCara2Des;
                            imgCara3 = imagenCara3Des;
                            imgCara4 = imagenCara4Act;
                            imgCara5 = imagenCara5Des;
                            puntos = 2;
                          });
                        },
                        child: imgCara4,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            imgCara1 = imagenCara1Des;
                            imgCara2 = imagenCara2Des;
                            imgCara3 = imagenCara3Des;
                            imgCara4 = imagenCara4Des;
                            imgCara5 = imagenCara5Act;
                            puntos = 1;
                          });
                        },
                        child: imgCara5,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("Gracias!",
                      style: Calificacion.infoStyle,
                      textAlign: TextAlign.center),
                  Text("Por favor coméntanos un poco de tu experiencia.",
                      style: Calificacion.infoStyle,
                      textAlign: TextAlign.center),
                  SizedBox(height: 10),
                  Container(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff1D2766),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Card(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _controllerMensaje,
                                  maxLines: 8,
                                  decoration: InputDecoration.collapsed(
                                      hintText: "Escribe aqui ....."),
                                ),
                              ))
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          var calificacionCreada =
                              await CalificacionProvider.create(
                                  puntos,
                                  _controllerMensaje.text,
                                  widget.datosMotorizado!.idPoliza);

                          Map<String, dynamic>? datosRespuestaCalificacion =
                              json.decode(calificacionCreada.body);
                          print(calificacionCreada.body);
                          if (calificacionCreada.statusCode == 201) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, "home", (r) => false);
                          }
                        },
                        child: Text(
                          "Finalizar",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      )
                    ],
                  )
                ],
              ))),
    );
  }
}
