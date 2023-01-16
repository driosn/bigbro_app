import 'package:flutter/material.dart';
import 'package:mibigbro/screens/cotizacion/declaracion.dart';
import 'package:mibigbro/screens/home/home.dart';
import 'package:mibigbro/utils/storage.dart';
import 'package:share_plus/share_plus.dart';

class Compartir extends StatelessWidget {
  final appTitle = 'Comparte tu experiencia';
  @override
  static const TextStyle titulo = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 18.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);
  static const TextStyle infoStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w300);

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
                  SizedBox(height: 30),
                  Image.asset(
                    'assets/img/compartir.png',
                    width: 200,
                  ),
                  SizedBox(height: 30),
                  Text("Gracias!", style: titulo, textAlign: TextAlign.center),
                  Text("Comparte tu experiencia con tus amigos.",
                      style: infoStyle, textAlign: TextAlign.center),
                  Text(
                      "Si ellos adquieren la póliza por tu referencia obtienes beneficios.",
                      style: infoStyle,
                      textAlign: TextAlign.center),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          String codigoCompartir =
                              StorageUtils.getString('codigo');
                          Share.share(
                              'Esta App me pareció genial!, Si adquieres un seguro vehicular (a partir de 6 meses) en esta app recibes un descuento, solo debes ingresar el siguiente código $codigoCompartir antes de pagar.No esperes más y descárgala! en http://www.mibigbro.com');
                        },
                        child: Text(
                          "Compartir",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, "home", (r) => false);
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
