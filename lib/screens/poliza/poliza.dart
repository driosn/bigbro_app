import 'package:flutter/material.dart';
import 'package:mibigbro/screens/cotizacion/calificacion.dart';
import 'package:mibigbro/screens/cotizacion/declaracion.dart';
import 'package:mibigbro/screens/cotizacion/firmar.dart';
import 'package:mibigbro/screens/home/home.dart';
import 'package:mibigbro/screens/poliza/polizacompleta.dart';
import 'package:mibigbro/screens/poliza/renovacion.dart';
import 'package:mibigbro/screens/poliza/siniestro.dart';

class Poliza extends StatelessWidget {
  final appTitle = 'Póliza';
  @override
  static const TextStyle labelStyle = TextStyle(
      color: Colors.red,
      fontSize: 14.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);
  static const TextStyle infoStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 14.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w300);
  static const TextStyle infoPrecioStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);

  static const TextStyle optionStyleTitle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 14.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);
  static const TextStyle optionStyleText = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 12.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w300);

  static const TextStyle panelTitleStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 14.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w600);
  static const TextStyle panelStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 20.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Image.asset(
                    'assets/img/logo2.png',
                    width: 300,
                  ),
                  Text('Tu auto está asegurado! miBigBro esta contigo!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff1D2766),
                          fontSize: 18.0,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        // color: Color(0xff1D2766),
                        // textColor: Colors.white,
                        // disabledColor: Colors.grey,
                        // disabledTextColor: Colors.black,
                        // padding: EdgeInsets.all(8.0),
                        // splashColor: Colors.blueAccent,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Calificacion()),
                          );
                        },
                        child: Text(
                          "Aceptar",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    }

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
                  Text("Información de su Póliza",
                      style: optionStyleTitle, textAlign: TextAlign.center),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Text(
                                "Numero de Póliza:",
                                style: labelStyle,
                                textAlign: TextAlign.right,
                              ))),
                      Expanded(
                          flex: 1,
                          child: Text(
                            "123456789",
                            style: infoStyle,
                            textAlign: TextAlign.left,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text(
                                "Modelo de automotor:",
                                style: labelStyle,
                                textAlign: TextAlign.right,
                              ))),
                      Expanded(
                          flex: 1,
                          child: Text(
                            "Gol",
                            style: infoStyle,
                            textAlign: TextAlign.left,
                          ))
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                "Coberturas:",
                                style: labelStyle,
                                textAlign: TextAlign.right,
                              ))),
                      Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Daños propios",
                                style: infoStyle,
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Conmoción social",
                                style: infoStyle,
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Robo parcial",
                                style: infoStyle,
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Pérdida total por accidente",
                                style: infoStyle,
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Pérdida total por robo",
                                style: infoStyle,
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Accidentes personales",
                                style: infoStyle,
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Rehabilitación automática RP",
                                style: infoStyle,
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Auxillo mecánico",
                                style: infoStyle,
                                textAlign: TextAlign.left,
                              )
                            ],
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Text(
                                "Inicio de cobertura:",
                                style: labelStyle,
                                textAlign: TextAlign.right,
                              ))),
                      Expanded(
                          flex: 1,
                          child: Text(
                            "1 - 05 - 2020, 15:30 ",
                            style: infoStyle,
                            textAlign: TextAlign.left,
                          ))
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Text(
                                "Fin de cobertura:",
                                style: labelStyle,
                                textAlign: TextAlign.right,
                              ))),
                      Expanded(
                          flex: 1,
                          child: Text(
                            "1 - 06 - 2020, 15:30 ",
                            style: infoStyle,
                            textAlign: TextAlign.left,
                          ))
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Text(
                                "Número de Asistencia:",
                                style: labelStyle,
                                textAlign: TextAlign.right,
                              ))),
                      Expanded(
                          flex: 1,
                          child: Text(
                            "72020202",
                            style: infoStyle,
                            textAlign: TextAlign.left,
                          ))
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        // color: Color(0xff1D2766),
                        // textColor: Colors.white,
                        // disabledColor: Colors.grey,
                        // disabledTextColor: Colors.black,
                        // padding: EdgeInsets.all(8.0),
                        // splashColor: Colors.blueAccent,
                        onPressed: () {},
                        child: Text(
                          "Descargar",
                          style: TextStyle(fontSize: 14.0),
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
                          _showMyDialog();
                        },
                        child: Text(
                          "Continuar",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /* Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RenovacionPoliza()),
                            );
                          },
                          child: Container(
                              width: 50,
                              height: 110,
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/img/polizarenovar.png',
                                    width: 20,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Renovación",
                                    style: optionStyleTitle,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Renueve tu seguro",
                                    style: optionStyleText,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              )),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PolizaCompleta()),
                            );
                          },
                          child: Container(
                              width: 50,
                              height: 110,
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/img/poliza.png',
                                    width: 20,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Póliza",
                                    style: optionStyleTitle,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Ver la póliza completa",
                                    style: optionStyleText,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              )),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SiniestroInformacion()),
                                );
                              },
                              child: Container(
                                  width: 50,
                                  height: 110,
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/img/polizasiniestro.png',
                                        width: 30,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Declarar siniestro",
                                        style: optionStyleTitle,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Declare un siniestro",
                                        style: optionStyleText,
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ))))
                    ],
                  ) */
                ],
              ))),
    );
  }
}
