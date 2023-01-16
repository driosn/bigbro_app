import 'package:flutter/material.dart';
import 'package:mibigbro/screens/poliza/revision.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SiniestroInformacion extends StatelessWidget {
  final appTitle = 'Siniestro';
  @override
  static const TextStyle titulo = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);
  static const TextStyle texto = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w400);
  static const TextStyle numeracion = TextStyle(
      color: Colors.red,
      fontSize: 18.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w400);
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
                  Text(
                      "En caso de un accidente o robo siga los siguientes pasos",
                      style: titulo,
                      textAlign: TextAlign.center),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            "1",
                            style: numeracion,
                            textAlign: TextAlign.left,
                          )),
                      Expanded(
                          flex: 6,
                          child: Text(
                            "Llame a número 80010-3070 o contactenos",
                            style: texto,
                            textAlign: TextAlign.left,
                          )),
                      Expanded(
                          flex: 2,
                          child: RawMaterialButton(
                            onPressed: () {},
                            elevation: 10.0,
                            fillColor: Colors.red,
                            child: Icon(
                              Icons.call,
                              size: 20.0,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(2.0),
                            shape: CircleBorder(),
                          ))
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            "",
                            style: numeracion,
                            textAlign: TextAlign.left,
                          )),
                      Expanded(
                          flex: 6,
                          child: Text(
                            "O contactenos por WhatsApp",
                            style: texto,
                            textAlign: TextAlign.left,
                          )),
                      Expanded(
                          flex: 2,
                          child: RawMaterialButton(
                            onPressed: () {},
                            elevation: 10.0,
                            fillColor: Colors.green,
                            child: FaIcon(FontAwesomeIcons.whatsapp,
                                color: Colors.white),
                            padding: EdgeInsets.all(7.0),
                            shape: CircleBorder(),
                          ))
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            "2",
                            style: numeracion,
                            textAlign: TextAlign.left,
                          )),
                      Expanded(
                          flex: 7,
                          child: Text(
                            "Provee información requerida por el personal",
                            style: texto,
                            textAlign: TextAlign.left,
                          )),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            "3",
                            style: numeracion,
                            textAlign: TextAlign.left,
                          )),
                      Expanded(
                          flex: 7,
                          child: Text(
                            "Dependiendo el tipo de siniestro recibirá pasos a seguir",
                            style: texto,
                            textAlign: TextAlign.left,
                          )),
                    ],
                  ),
                  SizedBox(height: 30),
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
                          "Volver",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  )
                ],
              ))),
    );
  }
}
