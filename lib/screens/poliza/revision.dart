import 'package:flutter/material.dart';
import 'package:mibigbro/screens/cotizacion/calificacion.dart';
import 'package:mibigbro/screens/home/home.dart';
import 'package:mibigbro/screens/poliza/poliza.dart';

class RevisionPoliza extends StatelessWidget {
  final appTitle = 'Revisión de documentos';
  @override
  static const TextStyle labelStyle = TextStyle(
      color: Colors.red,
      fontSize: 14.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);
  static const TextStyle texto = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w300);
  static const TextStyle titulo = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 22.0,
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
            title: Text('Pago de seguro'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Para terminar de asegurar su vehículo enviamos un correo electrónico con el enlace para realizar el pago.'),
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
              TextButton(
                child: Text('Finalizar'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
              ),
            ],
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
              padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/img/revision.png',
                    width: 150,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text("Revisión", style: titulo, textAlign: TextAlign.center),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            "Nos encontramos revisando tus documentos enviados, esto demorará 1 día. Al finalizar la revisión te llegará una notificación.",
                            style: texto,
                            textAlign: TextAlign.center,
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
                        onPressed: () {
/*                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Poliza()),
                          ); */
                          //_showMyDialog();
                          /*  Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          ); */
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Calificacion()),
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
