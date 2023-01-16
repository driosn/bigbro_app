import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mibigbro/models/motorizadoModel.dart';
import 'package:mibigbro/rest_api/provider/tarifador_provider.dart';
import 'package:mibigbro/screens/cotizacion/coberturas.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DiasMedida extends StatefulWidget {
  final motorizadoModel? datosMotorizado;
  DiasMedida({this.datosMotorizado});
  @override
  _DiasMedidaState createState() => new _DiasMedidaState();
}

class _DiasMedidaState extends State<DiasMedida> {
  DateTime ahora = new DateTime.now();

  DateTime selectedDateDesde = new DateTime.now();
  DateTime selectedDateHasta = new DateTime.now();

  DateFormat dateFormat = DateFormat.yMd('es');
  bool verCotizacion = false;
  double? montoCotizado = 0;
  int diasCotizado = 0;

  static const TextStyle optionStyleTitle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 14.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);

  static const TextStyle panelStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 20.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList

    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    widget.datosMotorizado!.tipoCotizacion = "DIASAMEDIDA";
    DateTime minimoFecha = ahora.add(const Duration(days: 7));
    return new Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 0, right: 0, top: 24, bottom: 10),
              padding:
                  EdgeInsets.only(left: 60, right: 60, top: 10, bottom: 10),
              child: Text(
                "Elige tu seguro por los días que necesites, entre 7 y 90 días.",
                style: optionStyleTitle,
                textAlign: TextAlign.center,
              )),
          Container(
              width: 500,
              padding:
                  EdgeInsets.only(left: 60, right: 60, top: 10, bottom: 10),
              child: Text(
                "Días a tu medida",
                style: panelStyle,
                textAlign: TextAlign.center,
              )),
          Container(
            width: 500,
            padding: EdgeInsets.only(left: 60, right: 60, top: 10, bottom: 0),
            child: Text(
              "Asegurar desde:",
              style: TextStyle(color: Colors.red, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 310,
            padding: EdgeInsets.only(left: 70, right: 70, top: 0, bottom: 0),
            margin: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
            child: DateTimeField(
              mode: DateTimeFieldPickerMode.date,
              selectedDate: selectedDateDesde,
              firstDate: DateTime(ahora.year, ahora.month, ahora.day),
              onDateSelected: (DateTime date) {
                setState(() {
                  selectedDateDesde = date;
                });
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
              lastDate: DateTime(2030),
              dateFormat: dateFormat,
            ),
          ),
          Container(
            width: 500,
            padding: EdgeInsets.only(left: 60, right: 60, top: 0, bottom: 0),
            child: Text(
              "hasta:",
              style: TextStyle(color: Colors.red, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 310,
            padding: EdgeInsets.only(left: 70, right: 70, top: 0, bottom: 0),
            margin: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
            child: DateTimeField(
              mode: DateTimeFieldPickerMode.date,
              selectedDate: selectedDateHasta,
              firstDate: DateTime(ahora.year, ahora.month, ahora.day),
              onDateSelected: (DateTime date) {
                setState(() {
                  selectedDateHasta = date;
                });
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
              lastDate: DateTime(2030),
              dateFormat: dateFormat,
            ),
          ),
          TextButton(
            onPressed: () async {
              int diasDiferencia =
                  selectedDateHasta.difference(selectedDateDesde).inDays + 1;
              print(diasDiferencia);
              if (diasDiferencia >= 7 && diasDiferencia <= 90) {
                var respuestaMonto = await TarifadorProvider.getMontoPorDias(
                    widget.datosMotorizado!.valor,
                    widget.datosMotorizado!.ciudad,
                    widget.datosMotorizado!.uso,
                    "1,2,3,4,5,6,7,8,9",
                    "50",
                    diasDiferencia.toString());

                var datosMonto = json.decode(respuestaMonto.body);
                print(datosMonto["MONTO"]["BOB"]);

                setState(() {
                  verCotizacion = true;
                  diasCotizado = diasDiferencia;
                  montoCotizado = datosMonto["MONTO"]["BOB"];
                  /* print(selectedDateDesde);
                  print(selectedDateHasta);
                  print(selectedDateHasta.difference(selectedDateDesde).inDays); */
                });
              } else {
                setState(() {
                  verCotizacion = false;

                  montoCotizado = 0;
                });
                Fluttertoast.showToast(
                    msg: "El rango de fecha debe estar entre 7 a 90 días",
                    webPosition: "center",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 7,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 20.0);
              }

              /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CotizarPrecio()),
                  ); */
            },
            child: Text(
              "Calcular monto",
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          Visibility(
              visible: verCotizacion,
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          left: 0, right: 0, top: 30, bottom: 24),
                      child: Text(
                        "El monto para " +
                            diasCotizado.toString() +
                            " días es de:",
                        style: panelStyle,
                        textAlign: TextAlign.center,
                      )),
                  Container(
                      width: 200,
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
                      child: Column(
                        children: [
                          Text(
                            montoCotizado.toString() + " Bs",
                            style: panelStyle,
                            textAlign: TextAlign.center,
                          )
                        ],
                      )),
                  TextButton(
                    // color: Color(0xff1D2766),
                    // textColor: Colors.white,
                    // disabledColor: Colors.grey,
                    // disabledTextColor: Colors.black,
                    // padding: EdgeInsets.all(8.0),
                    // splashColor: Colors.blueAccent,
                    onPressed: () {
                      DateTime hoy = new DateTime.now();
                      var fechaInicio =
                          new DateTime(hoy.year, hoy.month, hoy.day);
                      var fechaFin = new DateTime(
                          hoy.year, hoy.month, hoy.day + diasCotizado);

                      //int montoCobrar = (int.parse(_monto.text) / 6.96).round();
                      widget.datosMotorizado!.tipoCotizacion = "DIASAMEDIDA";
                      widget.datosMotorizado!.nroPeriodosCobro = 1;
                      widget.datosMotorizado!.periodo = "UNICO";
                      widget.datosMotorizado!.periodoCobro = "UNICO";
                      widget.datosMotorizado!.costo = montoCotizado.toString();
                      widget.datosMotorizado!.diasCotizados = diasCotizado;
                      widget.datosMotorizado!.diasMedida =
                          diasCotizado.toString();
                      widget.datosMotorizado!.inicioVigencia =
                          fechaInicio.toString().substring(0, 10);
                      widget.datosMotorizado!.finVigencia =
                          fechaFin.toString().substring(0, 10);

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
