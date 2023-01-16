import 'package:flutter/material.dart';
import 'package:mibigbro/models/motorizadoModel.dart';
import 'package:mibigbro/screens/cotizacion/declaracion.dart';
import 'package:mibigbro/screens/cotizacion/firmar.dart';
import 'package:mibigbro/screens/cotizacion/resumen.dart';

class Aseguradoras extends StatelessWidget {
  final motorizadoModel? datosMotorizado;

  Aseguradoras({this.datosMotorizado});
  final appTitle = 'Aseguradora';

  static const TextStyle optionStyleTitle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 12.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);
  static const TextStyle optionStyleTitleSelect = TextStyle(
      color: Colors.white,
      fontSize: 12.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);

  static const TextStyle panelTitleStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 14.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w300);
  static const TextStyle panelStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 18.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);
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
          child: Center(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /* Text("Elija su aseguradora",
                          style: panelTitleStyle, textAlign: TextAlign.center), */
                      GestureDetector(
                        onTap: () {
                          /* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Declaracion(
                                    datosMotorizado: datosMotorizado)),
                          ); */
                          datosMotorizado!.idCompania = 1;
                          if (datosMotorizado!.camino == "nuevo_seguro") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FirmaPoliza(
                                      datosMotorizado: datosMotorizado)),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResumenSeguro(
                                      datosMotorizado: datosMotorizado)),
                            );
                          }
                        },
                        child: Container(
                            width: 150,
                            margin: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 0),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.red,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 5),
                                /* Text(
                                  "Alianza",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightBlue[900]),
                                  textAlign: TextAlign.center,
                                ), */
                                Image.asset(
                                  'assets/img/asegalianza.png',
                                  height: 100,
                                  fit: BoxFit.fitWidth,
                                ),
                              ],
                            )),
                      ),
                      /* Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              datosMotorizado.idCompania = 2;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Declaracion(
                                        datosMotorizado: datosMotorizado)),
                              );
                            },
                            child: Container(
                                height: 150,
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 0),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 5),
                                    Text(
                                      "Compañía 2",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[900]),
                                      textAlign: TextAlign.center,
                                    ),
                                    Image.asset(
                                      'assets/img/companialogo.png',
                                      height: 100,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ],
                                )),
                          )) */

                      /* Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              datosMotorizado.idCompania = 3;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Declaracion(
                                        datosMotorizado: datosMotorizado)),
                              );
                            },
                            child: Container(
                                height: 150,
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 0),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 5),
                                    Text(
                                      "Compañía 3",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[900]),
                                      textAlign: TextAlign.center,
                                    ),
                                    Image.asset(
                                      'assets/img/companialogo.png',
                                      height: 100,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ],
                                )),
                          )),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              datosMotorizado.idCompania = 4;
                              print(datosMotorizado.idCompania);
                              print(datosMotorizado.costo);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Declaracion(
                                        datosMotorizado: datosMotorizado)),
                              );
                            },
                            child: Container(
                                height: 150,
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 0),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 5),
                                    Text(
                                      "Compañía 4",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[900]),
                                      textAlign: TextAlign.center,
                                    ),
                                    Image.asset(
                                      'assets/img/companialogo.png',
                                      height: 100,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ],
                                )),
                          ))
                    ],
                  ), */
                      SizedBox(height: 30),
                    ],
                  )))),
    );
  }
}
