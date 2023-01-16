import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mibigbro/models/motorizadoModel.dart';
import 'package:mibigbro/rest_api/provider/tarifador_provider.dart';
import 'package:mibigbro/screens/cotizacion/coberturas.dart';
import 'package:mibigbro/screens/cotizacion/paquetes.dart';

class PrecioMedida extends StatefulWidget {
  final motorizadoModel? datosMotorizado;
  PrecioMedida({this.datosMotorizado});
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
      fontWeight: FontWeight.w600);
  static const TextStyle panelStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 20.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);

  @override
  _PrecioMedidaState createState() => _PrecioMedidaState();
}

class _PrecioMedidaState extends State<PrecioMedida> {
  final appTitle = 'Cotizacion por monto';
  final TextEditingController _monto = TextEditingController();
  int? diasSeguro = 0;
  bool verCotizacion = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime hoy = new DateTime.now();
    var fechaInicio = new DateTime(hoy.year, hoy.month, hoy.day);

    widget.datosMotorizado!.tipoCotizacion = "PRECIOAMEDIDA";
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
              padding:
                  EdgeInsets.only(left: 60, right: 60, top: 10, bottom: 10),
              margin: EdgeInsets.only(left: 0, right: 0, top: 24, bottom: 10),
              child: Text(
                "Elige tu seguro de acuerdo al dinero que tengaa disponible, entre Bs 50 y Bs 1.000.",
                style: PrecioMedida.optionStyleTitle,
                textAlign: TextAlign.center,
              )),
          Container(
              margin: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 24),
              child: Text(
                "Precios a medida",
                style: PrecioMedida.panelStyle,
                textAlign: TextAlign.center,
              )),
          Container(
              padding: EdgeInsets.only(left: 60, right: 60, top: 0, bottom: 0),
              margin: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
              child: Text(
                "Ingresa un monto que pueda pagar.",
                style: PrecioMedida.optionStyleTitle,
                textAlign: TextAlign.center,
              )),
          Text(
            "Monto en Bolivianos",
            style: TextStyle(color: Colors.red, fontSize: 20),
            textAlign: TextAlign.left,
          ),
          Container(
            padding: EdgeInsets.only(left: 100, right: 100, top: 0, bottom: 0),
            margin: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
            child: TextField(
              controller: _monto,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
              decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 3.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff1D2766), width: 3.0),
                ),
                hintText: '0 Bs',
              ),
            ),
          ),
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
                onPressed: () async {
                  if (_monto.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "El monto debe estar entre 50 Bs y 1000 Bs",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 7,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 20.0);
                  } else {
                    int montoSus = int.parse(_monto.text);
                    int montoBs = (int.parse(_monto.text) / 6.96).round();
                    if (montoSus >= 50 && montoSus <= 1000) {
                      var respuestaPaquetes =
                          await TarifadorProvider.getDiasPorMonto(
                              widget.datosMotorizado!.valor,
                              widget.datosMotorizado!.ciudad,
                              widget.datosMotorizado!.uso,
                              "1,2,3,4,5,6,7,8,9",
                              "50",
                              montoBs.toString());
                      var datosPaquete = json.decode(respuestaPaquetes.body);

                      setState(() {
                        verCotizacion = true;
                        diasSeguro = datosPaquete["DIAS"];
                      });
                      print(_monto.text);
                    } else {
                      //print("El monto debe estar entre 50 Bs y 1000 Bs");
                      setState(() {
                        verCotizacion = false;
                        diasSeguro = 0;
                      });
                      Fluttertoast.showToast(
                          msg: "El monto debe estar entre 50 Bs y 1000 Bs",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 7,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 20.0);
                    }
                  }
                },
                child: Text(
                  "Cotizar",
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ],
          ),
          Visibility(
              visible: verCotizacion,
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          left: 0, right: 0, top: 30, bottom: 24),
                      child: Text(
                        "Los días asegurables son:",
                        style: PrecioMedida.panelStyle,
                        textAlign: TextAlign.center,
                      )),
                  Container(
                    margin: EdgeInsets.only(
                        left: 24, right: 24, top: 5, bottom: 24),
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      diasSeguro.toString() + " Días",
                      style: PrecioMedida.panelStyle,
                      textAlign: TextAlign.center,
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
                      var fechaFin = new DateTime(
                          hoy.year, hoy.month, hoy.day + diasSeguro!);

                      int montoCobrar = int.parse(_monto.text);
                      widget.datosMotorizado!.tipoCotizacion = "PRECIOAMEDIDA";
                      widget.datosMotorizado!.nroPeriodosCobro = 1;
                      widget.datosMotorizado!.periodo = "UNICO";
                      widget.datosMotorizado!.periodoCobro = "UNICO";

                      int montoBs = (montoCobrar / 6.96).round();
                      widget.datosMotorizado!.costo = montoCobrar.toString();
                      widget.datosMotorizado!.montoMedida = montoBs.toString();
                      widget.datosMotorizado!.inicioVigencia =
                          fechaInicio.toString().substring(0, 10);
                      widget.datosMotorizado!.finVigencia =
                          fechaFin.toString().substring(0, 10);
                      print(widget.datosMotorizado!.inicioVigencia);
                      print(widget.datosMotorizado!.finVigencia);
                      print("Costo precio a medida");
                      print(widget.datosMotorizado!.costo);
                      widget.datosMotorizado!.diasCotizados = diasSeguro;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Coberturas(
                                datosMotorizado: widget.datosMotorizado)),
                      );
                    },
                    child: Text(
                      "Siguiente",
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ],
              ))
        ],
      ),
    ));
  }
}
