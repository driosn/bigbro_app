import 'package:flutter/material.dart';
import 'package:mibigbro/models/motorizadoModel.dart';
import 'package:mibigbro/screens/cotizacion/calificacion.dart';
import 'package:mibigbro/utils/storage.dart';

class Mensajefinal extends StatelessWidget {
  final motorizadoModel? datosMotorizado;

  Mensajefinal({this.datosMotorizado});
  static const TextStyle titleStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 20.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);
  static const TextStyle subtitleStyle = TextStyle(
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
  Widget build(BuildContext context) {
    var appTitle = "Seguro preaprobado";
    var textoAviso =
        "Antes de continuar con el pago, tus datos seran verificados.";

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
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Column(
                children: [
                  Icon(
                    Icons.done_rounded,
                    size: 70.0,
                    color: Color(0xff1D2766),
                  ),
                  SizedBox(height: 10),
                  Text("Tu seguro fue preaprobado",
                      style: Mensajefinal.titleStyle,
                      textAlign: TextAlign.center),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            textoAviso,
                            style: Mensajefinal.infoStyle,
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
                            "En un maximo de 24 horas le enviaremos el enlace para que realice el pago y obtener su certificado.",
                            style: Mensajefinal.infoStyle,
                            textAlign: TextAlign.center,
                          ))
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            "Gracias por elegir miBigBro",
                            style: Mensajefinal.subtitleStyle,
                            textAlign: TextAlign.center,
                          ))
                    ],
                  ),
                  SizedBox(height: 20),
                  if (StorageUtils.getString('email') != "usertest@email.com")
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
                                  builder: (context) => Calificacion(
                                      datosMotorizado: datosMotorizado)),
                            );
                          },
                          child: Text(
                            "Finalizar",
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
