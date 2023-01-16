import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mibigbro/screens/automovil/datos_motorizado.dart';
import 'package:mibigbro/screens/cotizacion/compartir.dart';
import 'package:mibigbro/screens/cotizacion/paquetes.dart';
import 'package:mibigbro/utils/storage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Ofertas extends StatelessWidget {
  @override
  static const TextStyle texto = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 20.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w600);
  int puntosAcumulados = StorageUtils.getInteger('puntos');

  Widget build(BuildContext context) {
    int puntosFaltantes =
        (180 - puntosAcumulados) <= 0 ? 0 : 180 - puntosAcumulados;

    Future<void> _showMyDialogAcumular() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Tu tienes:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff1D2766),
                          fontSize: 14.0,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w700)),
                  Text.rich(
                    TextSpan(
                      text: puntosAcumulados.toString() + " ",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xff1D2766),
                          fontSize: 20.0,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'puntos',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Color(0xff1D2766),
                                fontSize: 16.0,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w500)),
                        // can add more TextSpans here...
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Te falta ',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Color(0xff1D2766),
                          fontSize: 14.0,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                            text: puntosFaltantes.toString() + ' puntos',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.red,
                                fontSize: 14.0,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w500)),
                        // can add more TextSpans here...
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                      'Por cada 180 puntos acumulados (1 punto = 1 día corrido de tu seguro), recibes una inspección vehicular rápida o un lavado general para tu auto.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff1D2766),
                          fontSize: 12.0,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w300)),
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
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Atras",
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
                                builder: (context) => DatosAutomovil()),
                          );
                        },
                        child: Text(
                          "Más días",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      _launchLandingURL();
                    },
                    child: new Text('Link para mayor información',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff1D2766),
                            decoration: TextDecoration.underline,
                            fontSize: 10.0,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    Future<void> _showMyDialogCompartir() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/img/compartir.png',
                    width: 80,
                    fit: BoxFit.fitWidth,
                  ),
                  Text(
                      'Si compartes y recomiendas el uso de miBigBro, los primeros 5 amigos tuyos que adquieren el seguro (desde planes semestrales) mediante esta App, reciben el descuento y tú recibes el beneficio de una inspección vehicular rápida.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff1D2766),
                          fontSize: 12.0,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w300)),
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
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Atras",
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
                    ],
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      _launchLandingURL();
                    },
                    child: new Text('Link para mayor información',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff1D2766),
                            decoration: TextDecoration.underline,
                            fontSize: 10.0,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      body: Center(
          child: Padding(
              padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Promociones",
                        style: TextStyle(
                            color: Color(0xff1D2766),
                            fontWeight: FontWeight.w600,
                            fontSize: 14)),
                    SizedBox(
                        width: 200,
                        child: TextButton(
                          // color: Color(0xff1D2766),
                          // textColor: Colors.white,
                          // disabledColor: Colors.grey,
                          // disabledTextColor: Colors.black,
                          // padding: EdgeInsets.all(6.0),
                          // splashColor: Colors.blueAccent,
                          onPressed: () {
                            _showMyDialogCompartir();
                          },
                          child: Text(
                            "Recomendar",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        )),
                    SizedBox(
                        width: 200,
                        child: TextButton(
                          // color: Color(0xff1D2766),
                          // textColor: Colors.white,
                          // disabledColor: Colors.grey,
                          // disabledTextColor: Colors.black,
                          // padding: EdgeInsets.all(6.0),
                          // splashColor: Colors.blueAccent,
                          onPressed: () {
                            _showMyDialogAcumular();
                          },
                          child: Text(
                            "Acumular puntos",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    if (puntosAcumulados >= 180)
                      Text("Canjear cupones",
                          style: TextStyle(
                              color: Color(0xff1D2766),
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                    if (puntosAcumulados >= 180)
                      Text("Para canjear tu cupon llama al 800-103090",
                          style: TextStyle(
                              color: Color(0xff1D2766),
                              fontWeight: FontWeight.w300,
                              fontSize: 12)),
                    Divider(
                      color: Color(0xff1D2766),
                      height: 10,
                      thickness: 1,
                      indent: 1,
                      endIndent: 0,
                    ),
                    if (puntosAcumulados >= 180)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.check,
                                size: 20.0,
                                color: Colors.green,
                              )),
                          Expanded(
                              flex: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Cupon: Lavado general",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(0xff1D2766),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14)),
                                  Text("Llamar: 911-12225",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(0xff1D2766),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14)),
                                  Text("Direccion: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(0xff1D2766),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14)),
                                  Text("Código: 9027402398239",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(0xff1D2766),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14)),
                                  Text("Valido hasta: 29/09",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(0xff1D2766),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14))
                                ],
                              )),
                        ],
                      ),
                    if (puntosAcumulados >= 180)
                      Container(
                        width: 250,
                        child: Text("Estado: Disponible",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Color(0xff1D2766),
                                fontWeight: FontWeight.w300,
                                fontSize: 14)),
                      ),
                    if (puntosAcumulados >= 180)
                      Divider(
                        color: Color(0xff1D2766),
                        height: 10,
                        thickness: 1,
                        indent: 1,
                        endIndent: 0,
                      ),
                    /* Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.close,
                              size: 20.0,
                              color: Colors.red,
                            )),
                        Expanded(
                            flex: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Cupon: Lavado general",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(0xff1D2766),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14)),
                                Text("Llamar: 911-12225",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(0xff1D2766),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14)),
                                Text("Direccion: ",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(0xff1D2766),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14)),
                                Text("Código: 9027402398239",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(0xff1D2766),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14)),
                                Text("Valido hasta: 29/09",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(0xff1D2766),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14))
                              ],
                            )),
                      ],
                    ) ,*/
                    if (puntosAcumulados < 180)
                      Container(
                        width: 250,
                        child: Text("No tiene cupones habilitados",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff1D2766),
                                fontWeight: FontWeight.w300,
                                fontSize: 14)),
                      )
                  ]))),
    );
  }

  _launchLandingURL() async {
    const url = 'https://marcesoftware.github.io/mibigboweb/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
