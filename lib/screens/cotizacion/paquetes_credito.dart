import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mibigbro/models/motorizadoModel.dart';
import 'package:mibigbro/rest_api/provider/tarifador_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:mibigbro/screens/cotizacion/aviso.dart';
import 'package:mibigbro/screens/cotizacion/inspeccion/pantalla1.dart';
import 'aseguradoras.dart';
/* import 'package:mibigbro/screens/cotizacion/coberturas.dart';
import 'package:mibigbro/screens/cotizacion/dias_media.dart';
import 'package:mibigbro/screens/cotizacion/precio.dart';
import 'package:mibigbro/screens/perfil/datos_personales.dart'; */

class PaquetesCredito extends StatelessWidget {
  final motorizadoModel? datosMotorizado;

  PaquetesCredito({this.datosMotorizado});

  Future cargarPaquetes() async {
    var respuestaPaquetes = await TarifadorProvider.getPaquetesCredito(
        datosMotorizado!.valor,
        datosMotorizado!.ciudad,
        datosMotorizado!.uso,
        datosMotorizado!.coberturas,
        datosMotorizado!.franquicia,
        datosMotorizado!.periodo);
    var datosPaquete = json.decode(respuestaPaquetes.body);
    print(datosPaquete);
    return datosPaquete;
  }

  final appTitle = 'Plan de pago';

  static const TextStyle optionStyleTitle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
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
      fontWeight: FontWeight.w600);
  static const TextStyle panelStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 20.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    print(datosMotorizado!.franquicia);
    print(datosMotorizado!.coberturas);
    String? periodo = datosMotorizado!.periodo;

    cargarPaqueteWidget(snapshot) {
      final paqutesAnual = Column(
        children: [
          Container(
              padding: EdgeInsets.only(left: 60, right: 60, top: 10, bottom: 0),
              margin: EdgeInsets.only(left: 0, right: 0, top: 24, bottom: 0),
              child: Text(
                "Tienes las siguientes opciones para pagar tu póliza " +
                    periodo!.toLowerCase(),
                style: optionStyleTitle,
                textAlign: TextAlign.center,
              )),
          Container(
              padding: EdgeInsets.only(left: 60, right: 60, top: 0, bottom: 10),
              margin: EdgeInsets.only(left: 0, right: 0, top: 24, bottom: 10),
              child: Text(
                "*Pagando tu seguro al contado la prima es mas economica",
                style: panelTitleStyle,
                textAlign: TextAlign.center,
              )),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      datosMotorizado!.nroPeriodosCobro = 1;
                      datosMotorizado!.periodoCobro = "ANUAL";
                      datosMotorizado!.costo = snapshot.data["ANUAL"].toString();
                      //Dependiendo si es seguro nuevo o reaseguro va a la parte de inspeccion o aseguradoras
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Aviso(datosMotorizado: datosMotorizado)),
                      );
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            left: 24, right: 10, top: 10, bottom: 0),
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text("Al contando anual",
                                style: panelTitleStyle,
                                textAlign: TextAlign.center),
                            SizedBox(
                              height: 5,
                            ),
                            AutoSizeText(
                              snapshot.data["ANUAL"].toString() + " Bs",
                              style: panelStyle,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            ),
                          ],
                        )),
                  )),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                      onTap: () {
                        datosMotorizado!.nroPeriodosCobro = 2;
                        datosMotorizado!.periodoCobro = "SEMESTRAL";
                        datosMotorizado!.costo =
                            snapshot.data["SEMESTRAL"].toString();
                        //Dependiendo si es seguro nuevo o reaseguro va a la parte de inspeccion o aseguradoras
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Aviso(datosMotorizado: datosMotorizado)),
                        );
                      },
                      child: Container(
                          margin: EdgeInsets.only(
                              left: 10, right: 24, top: 10, bottom: 0),
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Text("2 Cuotas semestrales",
                                  style: panelTitleStyle,
                                  textAlign: TextAlign.center),
                              SizedBox(
                                height: 5,
                              ),
                              AutoSizeText(
                                snapshot.data["SEMESTRAL"].toString() + " Bs",
                                style: panelStyle,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              )
                            ],
                          ))))
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      datosMotorizado!.nroPeriodosCobro = 4;
                      datosMotorizado!.periodoCobro = "TRIMESTRAL";
                      datosMotorizado!.costo =
                          snapshot.data["TRIMESTRAL"].toString();
                      //Dependiendo si es seguro nuevo o reaseguro va a la parte de inspeccion o aseguradoras
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Aviso(datosMotorizado: datosMotorizado)),
                      );
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            left: 24, right: 10, top: 10, bottom: 0),
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text("4 cuotas trimestrales",
                                style: panelTitleStyle,
                                textAlign: TextAlign.center),
                            SizedBox(
                              height: 5,
                            ),
                            AutoSizeText(
                              snapshot.data["TRIMESTRAL"].toString() + " Bs",
                              style: panelStyle,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            )
                          ],
                        )),
                  )),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      datosMotorizado!.nroPeriodosCobro = 12;
                      datosMotorizado!.periodoCobro = "MENSUAL";
                      datosMotorizado!.costo =
                          snapshot.data["MENSUAL"].toString();
                      //Dependiendo si es seguro nuevo o reaseguro va a la parte de inspeccion o aseguradoras
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Aviso(datosMotorizado: datosMotorizado)),
                      );
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            left: 10, right: 24, top: 10, bottom: 0),
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text("12 cuotas mensuales",
                                style: panelTitleStyle,
                                textAlign: TextAlign.center),
                            SizedBox(
                              height: 5,
                            ),
                            AutoSizeText(
                              snapshot.data["MENSUAL"].toString() + " Bs",
                              style: panelStyle,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            )
                          ],
                        )),
                  ))
            ],
          ),
        ],
      );

      final paquetesSemestral = Column(
        children: [
          Container(
              padding: EdgeInsets.only(left: 60, right: 60, top: 10, bottom: 0),
              margin: EdgeInsets.only(left: 0, right: 0, top: 24, bottom: 0),
              child: Text(
                "Tienes las siguientes opciones para pagar tu póliza " +
                    periodo.toLowerCase(),
                style: optionStyleTitle,
                textAlign: TextAlign.center,
              )),
          Container(
              padding: EdgeInsets.only(left: 60, right: 60, top: 0, bottom: 10),
              margin: EdgeInsets.only(left: 0, right: 0, top: 24, bottom: 10),
              child: Text(
                "*Pagando tu seguro al contado la prima es mas economica",
                style: panelTitleStyle,
                textAlign: TextAlign.center,
              )),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      datosMotorizado!.nroPeriodosCobro = 1;
                      datosMotorizado!.periodoCobro = "SEMESTRAL";
                      datosMotorizado!.costo =
                          snapshot.data["SEMESTRAL"].toString();
                      //Dependiendo si es seguro nuevo o reaseguro va a la parte de inspeccion o aseguradoras
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Aviso(datosMotorizado: datosMotorizado)),
                      );
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            left: 24, right: 10, top: 10, bottom: 0),
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text("Al contando semestral",
                                style: panelTitleStyle,
                                textAlign: TextAlign.center),
                            SizedBox(
                              height: 5,
                            ),
                            AutoSizeText(
                              snapshot.data["SEMESTRAL"].toString() + " Bs",
                              style: panelStyle,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            )
                          ],
                        )),
                  )),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                      onTap: () {
                        datosMotorizado!.nroPeriodosCobro = 2;
                        datosMotorizado!.periodoCobro = "TRIMESTRAL";
                        datosMotorizado!.costo =
                            snapshot.data["TRIMESTRAL"].toString();
                        //Dependiendo si es seguro nuevo o reaseguro va a la parte de inspeccion o aseguradoras
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Aviso(datosMotorizado: datosMotorizado)),
                        );
                      },
                      child: Container(
                          margin: EdgeInsets.only(
                              left: 10, right: 24, top: 10, bottom: 0),
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Text("2 Cuotas trimestrales",
                                  style: panelTitleStyle,
                                  textAlign: TextAlign.center),
                              SizedBox(
                                height: 5,
                              ),
                              AutoSizeText(
                                snapshot.data["TRIMESTRAL"].toString() + " Bs",
                                style: panelStyle,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              )
                            ],
                          ))))
            ],
          ),
        ],
      );

      if (periodo == "SEMESTRAL") {
        return paquetesSemestral;
      } else {
        return paqutesAnual;
      }
    }

    return FutureBuilder(
        future: cargarPaquetes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                title:
                    Text(appTitle, style: TextStyle(color: Color(0xff1D2766))),
              ),
              body: cargarPaqueteWidget(snapshot),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

/*
 GestureDetector(
-                              onTap: () {
                                var fechaFin = new DateTime(
-                                    hoy.year, hoy.month + 1, hoy.day);
-                                datosMotorizado.tipoCotizacion = "PAQUETE";
-                                datosMotorizado.inicioVigencia =
-                                    fechaInicio.toString().substring(0, 10);
-                                datosMotorizado.finVigencia =
-                                    fechaFin.toString().substring(0, 10);
-                                datosMotorizado.periodo = "MENSUAL";
-                                datosMotorizado.costo =
-                                    snapshot.data["MENSUAL"].toString();
-                                datosMotorizado.nroPeriodosCobro = 1;
-                                datosMotorizado.periodoCobro = "MENSUAL";
-                                Navigator.push(
-                                  context,
-                                  MaterialPageRoute(
-                                      builder: (context) => Coberturas(
-                                          datosMotorizado: datosMotorizado)),
-                                );
-                              },
-                              child:

*/
