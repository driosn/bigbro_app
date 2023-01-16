import 'dart:convert';

import 'package:flutter/material.dart';

class Utils {
  Widget verObservacionesWidget(String observaciones) {
    TextStyle infoStyle = TextStyle(
        color: Color(0xff1D2766),
        fontSize: 14.0,
        height: 1,
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w300);
    var listaObservaciones = observaciones.split('\\r\\n');
    var observacionesWidget = <Widget>[];

    for (String observacion in listaObservaciones) {
      observacionesWidget.add(Text(
        utf8.decode(observacion.runes.toList()),
        style: infoStyle,
        textAlign: TextAlign.left,
      ));
    }
    return Column(children: observacionesWidget);
  }
}
