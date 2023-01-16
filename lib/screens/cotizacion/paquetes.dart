import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mibigbro/models/cotizacion_model.dart';
import 'package:mibigbro/models/motorizadoModel.dart';
import 'package:mibigbro/rest_api/provider/tarifador_provider.dart';
import 'package:mibigbro/screens/cotizacion/coberturas.dart';

class Paquetes extends StatefulWidget {
  final motorizadoModel? datosMotorizado;
  final bool esRenovacion;

  Paquetes({
    this.datosMotorizado,
    this.esRenovacion = false,
  });

  static const TextStyle optionStyleTitle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 12.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);

  static const TextStyle optionStyleTitle2 = TextStyle(
    color: Colors.red,
    fontSize: 10.0,
    height: 1,
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w400,
  );

  static const TextStyle optionStyleTitleSelect = TextStyle(
      color: Colors.white,
      fontSize: 12.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);

  static const TextStyle panelTitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w500,
  );
  static const TextStyle panelStyle = TextStyle(
    color: Colors.white,
    fontSize: 25.0,
    height: 0.5,
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w700,
  );

  @override
  _PaquetesState createState() => _PaquetesState();
}

class _PaquetesState extends State<Paquetes> {
  Future<List<dynamic>> cargarPaquetes() async {
    print("tarifador cargar paquetes");
    print(widget.datosMotorizado!.valor);
    print(widget.datosMotorizado!.nroRenovacion);
    var respuestaPaquetes = await TarifadorProvider.getPaquetesStocksQuotes(
        widget.datosMotorizado!);
    // int.parse(datosMotorizado!.valor!), datosMotorizado!.nroRenovacion);
    print("renovacion");
    print(widget.datosMotorizado!.nroRenovacion);
    print(widget.datosMotorizado!.valor);
    print(respuestaPaquetes.body);
    var datosPaquete = json.decode(respuestaPaquetes.body);

    return datosPaquete;
  }

  final appTitle = 'Personaliza tu seguro';

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    widget.datosMotorizado!.tipoCotizacion = "PAQUETE";
    DateTime hoy = new DateTime.now();
    var fechaInicio = new DateTime(hoy.year, hoy.month, hoy.day);
    return FutureBuilder<List<dynamic>>(
        future: cargarPaquetes(),
        builder: (context, snapshot) {
          //print(snapshot.data[0]['primebs']);
          if (snapshot.hasData) {
            widget.datosMotorizado!.tipoCotizacion = "PAQUETE";
            widget.datosMotorizado!.inicioVigencia =
                fechaInicio.toString().substring(0, 10);
            widget.datosMotorizado!.periodo = "DIARIO";
            widget.datosMotorizado!.nroPeriodosCobro = 1;
            widget.datosMotorizado!.periodoCobro = "DIARIO";
            return Scaffold(
              // floatingActionButton: FloatingActionButton(
              // onPressed: () async {
              // final datos = await cargarPaquetesNuevo();
              // List<CotizacionModel> cotizaciones = datos
              // .map((dato) => CotizacionModel.fromJson(
              // dato as Map<String, dynamic>))
              // .toList();
//
              // print(cotizaciones);
              // },
              // ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                            left: 56, right: 56, top: 18, bottom: 8),
                        child: Text(
                          "Elige el plan diario que necesites.",
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        )),
                    Container(
                        padding: EdgeInsets.only(
                            left: 56, right: 56, top: 0, bottom: 10),
                        child: Text(
                          "A mayor tiempo de cobertura, será menor el monto de su prima.",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    GestureDetector(
                      onTap: () {
                        var fechaFin = new DateTime(hoy.year, hoy.month,
                            hoy.day + snapshot.data![0]['duration'] as int);
                        print(fechaInicio);
                        print(fechaFin);
                        widget.datosMotorizado!.finVigencia =
                            fechaFin.toString().substring(0, 10);
                        widget.datosMotorizado!.nroDias =
                            snapshot.data![0]['duration'];
                        widget.datosMotorizado!.costo = double.parse(
                                snapshot.data![0]['primebs'].toString())
                            .toStringAsFixed(2);
                        widget.datosMotorizado!.diasPaquete =
                            snapshot.data![0]['duration'];
                        widget.datosMotorizado!.idStock =
                            snapshot.data![0]['idstock'];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Coberturas(
                              datosMotorizado: widget.datosMotorizado,
                              esRenovacion: widget.esRenovacion,
                            ),
                          ),
                        );

                        // var fechaFin = new DateTime(hoy.year, hoy.month,
                        //     hoy.day + snapshot.data![0]['duration'] as int);
                        // print(fechaInicio);
                        // print(fechaFin);
                        // datosMotorizado!.finVigencia =
                        //     fechaFin.toString().substring(0, 10);
                        // datosMotorizado!.nroDias = snapshot.data![0]['duration'];
                        // datosMotorizado!.costo =
                        //     snapshot.data![0]['primebs'].toString();
                        // datosMotorizado!.diasPaquete =
                        //     snapshot.data![0]['duration'];
                        // datosMotorizado!.idStock = snapshot.data![0]['idstock'];
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => Coberturas(
                        //             datosMotorizado: datosMotorizado,
                        //             esRenovacion: esRenovacion,
                        //           )),
                        // );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 14),
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                // width: 200,
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 0),
                                padding: EdgeInsets.only(
                                    left: 28, right: 28, top: 28, bottom: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffEC1C24),
                                    width: 2,
                                  ),
                                  color: Color(0xffEC1C24),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 10),
                                    AutoSizeText(
                                      double.parse(snapshot.data![0]['primebs']
                                                  .toString())
                                              .toStringAsFixed(2) +
                                          " Bs",
                                      style: Paquetes.panelStyle,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                    AutoSizeText(
                                      snapshot.data![0]['prime'].toString() +
                                          " USD",
                                      style: Paquetes.panelTitleStyle,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 28,
                                width: 85,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    snapshot.data![0]['duration'].toString() +
                                        " Días",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        var fechaFin = new DateTime(hoy.year, hoy.month,
                            hoy.day + snapshot.data![1]['duration'] as int);
                        widget.datosMotorizado!.finVigencia =
                            fechaFin.toString().substring(0, 10);
                        print(fechaInicio);
                        print(fechaFin);
                        widget.datosMotorizado!.nroDias =
                            snapshot.data![1]['duration'];
                        widget.datosMotorizado!.costo = double.parse(
                                snapshot.data![1]['primebs'].toString())
                            .toStringAsFixed(2);
                        widget.datosMotorizado!.diasPaquete =
                            snapshot.data![1]['duration'];
                        widget.datosMotorizado!.idStock =
                            snapshot.data![1]['idstock'];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Coberturas(
                                  datosMotorizado: widget.datosMotorizado)),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 14),
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                // width: 200,
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 0),
                                padding: EdgeInsets.only(
                                    left: 28, right: 28, top: 28, bottom: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffEC1C24),
                                    width: 2,
                                  ),
                                  color: Color(0xffEC1C24),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 10),
                                    AutoSizeText(
                                      double.parse(snapshot.data![1]['primebs']
                                                  .toString())
                                              .toStringAsFixed(2) +
                                          " Bs",
                                      style: Paquetes.panelStyle,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                    AutoSizeText(
                                      snapshot.data![1]['prime'].toString() +
                                          " USD",
                                      style: Paquetes.panelTitleStyle,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 28,
                                width: 85,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    snapshot.data![1]['duration'].toString() +
                                        " Días",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        var fechaFin = new DateTime(hoy.year, hoy.month,
                            hoy.day + snapshot.data![2]['duration'] as int);
                        //datosMotorizado.inicioVigencia =
                        widget.datosMotorizado!.finVigencia =
                            fechaFin.toString().substring(0, 10);
                        widget.datosMotorizado!.nroDias =
                            snapshot.data![2]['duration'];
                        widget.datosMotorizado!.costo = double.parse(
                                snapshot.data![2]['primebs'].toString())
                            .toStringAsFixed(2);
                        widget.datosMotorizado!.diasPaquete =
                            snapshot.data![2]['duration'];
                        widget.datosMotorizado!.idStock =
                            snapshot.data![2]['idstock'];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Coberturas(
                                  datosMotorizado: widget.datosMotorizado)),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 14),
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                // width: 200,
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 0),
                                padding: EdgeInsets.only(
                                    left: 28, right: 28, top: 28, bottom: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffEC1C24),
                                    width: 2,
                                  ),
                                  color: Color(0xffEC1C24),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 10),
                                    AutoSizeText(
                                      double.parse(snapshot.data![2]['primebs']
                                                  .toString())
                                              .toStringAsFixed(2) +
                                          " Bs",
                                      style: Paquetes.panelStyle,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                    AutoSizeText(
                                      snapshot.data![2]['prime'].toString() +
                                          " USD",
                                      style: Paquetes.panelTitleStyle,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 28,
                                width: 85,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    snapshot.data![2]['duration'].toString() +
                                        " Días",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    Container(
                        padding: EdgeInsets.only(
                            left: 60, right: 60, top: 0, bottom: 10),
                        child: Text(
                          "El seguro se activa desde las 00:00 horas del día siguiente que tomes tu seguro, hasta las 00:00 del último día de vigencia.",
                          style: Paquetes.optionStyleTitle2,
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              ),
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
