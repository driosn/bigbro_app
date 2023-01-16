import 'package:flutter/material.dart';
import 'package:mibigbro/screens/cotizacion/calificacion.dart';
import 'package:mibigbro/screens/cotizacion/declaracion.dart';
import 'package:mibigbro/screens/cotizacion/firmar.dart';
import 'package:mibigbro/screens/home/home.dart';

class RenovacionPoliza extends StatelessWidget {
  final appTitle = 'Renovacion de póliza';
  @override
  static const TextStyle labelStyle = TextStyle(
      color: Colors.red,
      fontSize: 16.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);
  static const TextStyle infoStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w500);
  static const TextStyle infoPrecioStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 18.0,
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
      fontSize: 16.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w500);

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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    child: Row(
                      children: [
                        Icon(
                          Icons.autorenew,
                          size: 20.0,
                          color: Colors.red,
                        ),
                        Text("Renovación",
                            style: optionStyleTitle,
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
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
                                "Total:",
                                style: labelStyle,
                                textAlign: TextAlign.right,
                              ))),
                      Expanded(
                          flex: 1,
                          child: Text(
                            "200.00 Bs.",
                            style: infoPrecioStyle,
                            textAlign: TextAlign.left,
                          ))
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text(
                                "Tiempo asegurado:",
                                style: labelStyle,
                                textAlign: TextAlign.right,
                              ))),
                      Expanded(
                          flex: 1,
                          child: Text(
                            "<  1 Mes >",
                            style: infoPrecioStyle,
                            textAlign: TextAlign.left,
                          ))
                    ],
                  ),
                  SizedBox(height: 20),
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
                          "Aceptar",
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Calificacion()),
                          );
                        },
                        child: Text(
                          "Cancelar",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      )
                    ],
                  ),
                ],
              ))),
    );
  }
}
