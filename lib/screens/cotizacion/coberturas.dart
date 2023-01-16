import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mibigbro/models/motorizadoModel.dart';
import 'package:mibigbro/screens/cotizacion/aviso.dart';
import 'package:mibigbro/screens/cotizacion/inspeccion/pantalla1.dart';
import 'package:mibigbro/screens/cotizacion/paquetes.dart';
import 'package:mibigbro/screens/cotizacion/paquetes_credito.dart';
import 'package:mibigbro/rest_api/provider/tarifador_provider.dart';
import 'package:mibigbro/screens/home/home.dart';
import 'package:mibigbro/widgets/bigbro_scaffold.dart';
import 'package:mibigbro/widgets/custom_info_dialog.dart';

import 'aseguradoras.dart';

// Create a Form widget.
class Coberturas extends StatefulWidget {
  final motorizadoModel? datosMotorizado;
  final bool esRenovacion;

  Coberturas({this.datosMotorizado, this.esRenovacion = false});

  @override
  CoberturasState createState() {
    return CoberturasState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class CoberturasState extends State<Coberturas> {
  List<int> idCoberturas = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  bool valueAuxilioMecanico = true;
  bool valueRehabilitacionAutomatica = true;
  bool valueAccidentesPersonales = true;
  bool valueDanoPropios = true;
  bool valueRoboParcial = true;
  bool valueDanoMalicioso = true;
  bool valueExtraterriGratuita = true;
  bool valuePerdidaRobo = true;
  bool valuePerdidaAccidente = true;
  bool valueResponsabilidadCivil = true;
  String? valueCotizacion = "0";
  String tituloCotizacion = "Cotizacion";
  String medidaCotizacion = " medida";

  int valueFranquicia = 100;
  int valoracionCoberturas = 100;
  Color colorBarra = Colors.green;
  String textoValorCobertura = "Excelente";

  Future<String> cotizarPrecio(tipoCotizacion, valor, ciudad, uso, coberturas,
      franquicia, dias, monto) async {
    String finalCotizacion = "0";
    if (tipoCotizacion == "PRECIOAMEDIDA") {
      var respuestaPaquetes = await TarifadorProvider.getDiasPorMonto(
          valor, ciudad, uso, coberturas, franquicia, monto);
      var datosPaquete = json.decode(respuestaPaquetes.body);
      print(datosPaquete);
      var diasCotizados = datosPaquete["DIAS"];
      finalCotizacion = diasCotizados.toString();
    } else if (tipoCotizacion == "DIASAMEDIDA") {
      var respuestaMonto = await TarifadorProvider.getMontoPorDias(
          valor, ciudad, uso, coberturas, franquicia, dias);

      var datosMonto = json.decode(respuestaMonto.body);
      var montoCotizado = datosMonto["MONTO"]["BOB"];
      finalCotizacion = montoCotizado.toString();
    } else {
      var respuestaPaquetes = await TarifadorProvider.getPaquetes(
          valor, ciudad, uso, coberturas, franquicia);
      var datosPaquete = json.decode(respuestaPaquetes.body);
      var precioCotizadoPaquete = datosPaquete[widget.datosMotorizado!.periodo];
      finalCotizacion = precioCotizadoPaquete.toString();
    }

    return finalCotizacion;
  }

  _danoPropioChange(bool newValue) async {
    setState(() {
      valueDanoPropios = newValue;

      if (valueDanoPropios) {
        idCoberturas.add(1);
        valoracionCoberturas = valoracionCoberturas + 37;
      } else {
        idCoberturas.remove(1);
        valoracionCoberturas = valoracionCoberturas - 37;
      }
    });
    print(widget.datosMotorizado!.valor);
    print(widget.datosMotorizado!.montoMedida);

    var costoNuevo = await cotizarPrecio(
        widget.datosMotorizado!.tipoCotizacion,
        widget.datosMotorizado!.valor,
        widget.datosMotorizado!.ciudad,
        widget.datosMotorizado!.uso,
        idCoberturas.join(','),
        valueFranquicia.toString(),
        widget.datosMotorizado!.diasMedida,
        widget.datosMotorizado!.montoMedida);

    setState(() {
      valueCotizacion = costoNuevo;

      if (valoracionCoberturas >= 90) {
        colorBarra = Colors.green;
        textoValorCobertura = "Excelente";
      } else if (valoracionCoberturas >= 70) {
        colorBarra = Colors.yellow;
        textoValorCobertura = "Muy Bueno";
      } else {
        colorBarra = Colors.orange;
        textoValorCobertura = "Bueno";
      }
    });
  }

  _roboParcialChange(bool newValue) async {
    setState(() {
      valueRoboParcial = newValue;

      if (valueRoboParcial) {
        idCoberturas.add(5);
        valoracionCoberturas = valoracionCoberturas + 13;
      } else {
        idCoberturas.remove(5);
        valoracionCoberturas = valoracionCoberturas - 13;
      }
    });
    var costoNuevo = await cotizarPrecio(
        widget.datosMotorizado!.tipoCotizacion,
        widget.datosMotorizado!.valor,
        widget.datosMotorizado!.ciudad,
        widget.datosMotorizado!.uso,
        idCoberturas.join(','),
        valueFranquicia.toString(),
        widget.datosMotorizado!.diasMedida,
        widget.datosMotorizado!.montoMedida);

    setState(() {
      valueCotizacion = costoNuevo;

      if (valoracionCoberturas >= 90) {
        colorBarra = Colors.green;
        textoValorCobertura = "Excelente";
      } else if (valoracionCoberturas >= 70) {
        colorBarra = Colors.yellow;
        textoValorCobertura = "Muy Bueno";
      } else {
        colorBarra = Colors.orange;
        textoValorCobertura = "Bueno";
      }
    });
  }

  _danoMaliciosoChange(bool newValue) async {
    setState(() {
      valueDanoMalicioso = newValue;

      if (valueDanoMalicioso) {
        idCoberturas.add(7);
        valoracionCoberturas = valoracionCoberturas + 4;
      } else {
        idCoberturas.remove(7);
        valoracionCoberturas = valoracionCoberturas - 4;
      }
    });
    var costoNuevo = await cotizarPrecio(
        widget.datosMotorizado!.tipoCotizacion,
        widget.datosMotorizado!.valor,
        widget.datosMotorizado!.ciudad,
        widget.datosMotorizado!.uso,
        idCoberturas.join(','),
        valueFranquicia.toString(),
        widget.datosMotorizado!.diasMedida,
        widget.datosMotorizado!.montoMedida);

    setState(() {
      valueCotizacion = costoNuevo;

      if (valoracionCoberturas >= 90) {
        colorBarra = Colors.green;
        textoValorCobertura = "Excelente";
      } else if (valoracionCoberturas >= 70) {
        colorBarra = Colors.yellow;
        textoValorCobertura = "Muy Bueno";
      } else {
        colorBarra = Colors.orange;
        textoValorCobertura = "Bueno";
      }
    });
  }

  _accidentePersonalChange(bool newValue) async {
    setState(() {
      valueAccidentesPersonales = newValue;

      if (valueAccidentesPersonales) {
        idCoberturas.add(8);
        valoracionCoberturas = valoracionCoberturas + 4;
      } else {
        idCoberturas.remove(8);
        valoracionCoberturas = valoracionCoberturas - 4;
      }
      print(idCoberturas);
      print(idCoberturas.join(','));
    });
    var costoNuevo = await cotizarPrecio(
        widget.datosMotorizado!.tipoCotizacion,
        widget.datosMotorizado!.valor,
        widget.datosMotorizado!.ciudad,
        widget.datosMotorizado!.uso,
        idCoberturas.join(','),
        valueFranquicia.toString(),
        widget.datosMotorizado!.diasMedida,
        widget.datosMotorizado!.montoMedida);

    setState(() {
      valueCotizacion = costoNuevo;
      print(valoracionCoberturas);
      if (valoracionCoberturas >= 90) {
        colorBarra = Colors.green;
        textoValorCobertura = "Excelente";
      } else if (valoracionCoberturas >= 70) {
        colorBarra = Colors.yellow;
        textoValorCobertura = "Muy Bueno";
      } else {
        colorBarra = Colors.orange;
        textoValorCobertura = "Bueno";
      }
    });
  }

  _rehabilitacionAutomaticaChange(bool newValue) async {
    setState(() {
      valueRehabilitacionAutomatica = newValue;

      if (valueRehabilitacionAutomatica) {
        idCoberturas.add(6);
        valoracionCoberturas = valoracionCoberturas + 6;
      } else {
        idCoberturas.remove(6);
        valoracionCoberturas = valoracionCoberturas - 6;
      }
      print(idCoberturas);
      print(idCoberturas.join(','));
    });
    var costoNuevo = await cotizarPrecio(
        widget.datosMotorizado!.tipoCotizacion,
        widget.datosMotorizado!.valor,
        widget.datosMotorizado!.ciudad,
        widget.datosMotorizado!.uso,
        idCoberturas.join(','),
        valueFranquicia.toString(),
        widget.datosMotorizado!.diasMedida,
        widget.datosMotorizado!.montoMedida);

    setState(() {
      valueCotizacion = costoNuevo;
      print(valoracionCoberturas);
      if (valoracionCoberturas >= 90) {
        colorBarra = Colors.green;
        textoValorCobertura = "Excelente";
      } else if (valoracionCoberturas >= 70) {
        colorBarra = Colors.yellow;
        textoValorCobertura = "Muy Bueno";
      } else {
        colorBarra = Colors.orange;
        textoValorCobertura = "Bueno";
      }
    });
  }

  _auxilioMecanicoChange(bool newValue) async {
    setState(() {
      valueAuxilioMecanico = newValue;

      if (valueAuxilioMecanico) {
        idCoberturas.add(9);
        valoracionCoberturas = valoracionCoberturas + 6;
      } else {
        idCoberturas.remove(9);
        valoracionCoberturas = valoracionCoberturas - 6;
      }
    });
    var costoNuevo = await cotizarPrecio(
        widget.datosMotorizado!.tipoCotizacion,
        widget.datosMotorizado!.valor,
        widget.datosMotorizado!.ciudad,
        widget.datosMotorizado!.uso,
        idCoberturas.join(','),
        valueFranquicia.toString(),
        widget.datosMotorizado!.diasMedida,
        widget.datosMotorizado!.montoMedida);

    setState(() {
      valueCotizacion = costoNuevo;
      if (valoracionCoberturas >= 90) {
        colorBarra = Colors.green;
        textoValorCobertura = "Excelente";
      } else if (valoracionCoberturas >= 70) {
        colorBarra = Colors.yellow;
        textoValorCobertura = "Muy Bueno";
      } else {
        colorBarra = Colors.orange;
        textoValorCobertura = "Bueno";
      }
    });
  }

  //Cambiar franquicia
  _bajarFranquicia() async {
    setState(() {
      switch (valueFranquicia) {
        case 50:
          valueFranquicia = 500;
          break;
        case 100:
          valueFranquicia = 50;
          break;
        case 200:
          valueFranquicia = 100;
          break;
        case 300:
          valueFranquicia = 200;
          break;
        case 400:
          valueFranquicia = 300;
          break;
        case 500:
          valueFranquicia = 400;
          break;
        default:
          valueFranquicia = 500;
          break;
      }
    });
    var costoNuevo = await cotizarPrecio(
        widget.datosMotorizado!.tipoCotizacion,
        widget.datosMotorizado!.valor,
        widget.datosMotorizado!.ciudad,
        widget.datosMotorizado!.uso,
        idCoberturas.join(','),
        valueFranquicia.toString(),
        widget.datosMotorizado!.diasMedida,
        widget.datosMotorizado!.montoMedida);

    setState(() {
      valueCotizacion = costoNuevo;
      if (valoracionCoberturas >= 90) {
        colorBarra = Colors.green;
      } else if (valoracionCoberturas >= 70) {
        colorBarra = Colors.yellow;
      } else {
        colorBarra = Colors.orange;
      }
    });
  }

  _subirFranquicia() async {
    setState(() {
      switch (valueFranquicia) {
        case 50:
          valueFranquicia = 100;
          break;
        case 100:
          valueFranquicia = 200;
          break;
        case 200:
          valueFranquicia = 300;
          break;
        case 300:
          valueFranquicia = 400;
          break;
        case 400:
          valueFranquicia = 500;
          break;
        case 500:
          valueFranquicia = 50;
          break;
        default:
          valueFranquicia = 50;
          break;
      }
    });
    var costoNuevo = await cotizarPrecio(
        widget.datosMotorizado!.tipoCotizacion,
        widget.datosMotorizado!.valor,
        widget.datosMotorizado!.ciudad,
        widget.datosMotorizado!.uso,
        idCoberturas.join(','),
        valueFranquicia.toString(),
        widget.datosMotorizado!.diasMedida,
        widget.datosMotorizado!.montoMedida);

    setState(() {
      valueCotizacion = costoNuevo;
      print(valoracionCoberturas);
      if (valoracionCoberturas >= 90) {
        colorBarra = Colors.green;
      } else if (valoracionCoberturas >= 70) {
        colorBarra = Colors.yellow;
      } else {
        colorBarra = Colors.orange;
      }
    });
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  Future<void> _showMyDialogFranquisia() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Qué es una franquicia?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Importe fijo que queda a cargo del asegurado en caso de siniestro.'),
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
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.datosMotorizado!.tipoCotizacion == "PRECIOAMEDIDA") {
      valueCotizacion = widget.datosMotorizado!.diasCotizados.toString();
      tituloCotizacion = "Días de seguro";
      medidaCotizacion = " Días";
    } else {
      valueCotizacion = widget.datosMotorizado!.costo;
      tituloCotizacion = "Total cobertura:";
      medidaCotizacion = " Bs";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    String title = 'Coberturas del Seguro';
    return BigBroScaffold(
        title: title,
        centerWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/img/planes_seguro.png'),
            const SizedBox(
              height: 4,
            ),
            Text(
              'Personaliza tu seguro',
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              height: 32,
                              width: 32,
                              child: Image.asset('assets/img/check-square.png'),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Expanded(
                              child: Text(
                                "Responsabilidad civil",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.info_outline),
                              onPressed: () {
                                CustomInfoDialog(
                                  context: context,
                                  iconColor: Theme.of(context).primaryColor,
                                  title: 'Responsabilidad civil',
                                  subtitle:
                                      'Cubre las lesiones corporales, incluyendo muerte de terceros, además de los daños materiales a terceros.',
                                );
                              },
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 32,
                              width: 32,
                              child: Image.asset('assets/img/check-square.png'),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Expanded(
                              child: Text(
                                "Pérdida total por robo o accidente",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.info_outline),
                              onPressed: () {
                                CustomInfoDialog(
                                  context: context,
                                  iconColor: Theme.of(context).primaryColor,
                                  title: 'Pérdida total por robo o accidente',
                                  subtitle:
                                      'Pérdida por Robo: \nCubre en caso de que el vehículo asegurado sea robado en su totalidad, se trata de un robo cuando el hecho es realizado por desconocidos (no cubre pérdida total por robo en el extranjero). \nPérdida por accidente: \nCubre en caso de que exista un accidente y se tenga una pérdida total del automóvil.',
                                );
                              },
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 32,
                              width: 32,
                              child: Image.asset('assets/img/check-square.png'),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Expanded(
                                child: Text(
                              "Daños propios",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            )),
                            IconButton(
                              icon: Icon(Icons.info_outline),
                              onPressed: () {
                                CustomInfoDialog(
                                  context: context,
                                  iconColor: Theme.of(context).primaryColor,
                                  title: 'Daños propios',
                                  subtitle:
                                      'Cubre los daños sufridos en el vehículo tras un accidente ocasionado por colisión, embarrancamiento, vuelco o caída accidental, descuidos y daños a vehículo estacionado, siempre que sean sucesos súbitos e imprevistos, ajenos a la voluntad del Asegurado. La cobertura se extiende fuera del país cuando se tenga la cobertura de extraterritorialidad.',
                                );
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 32,
                              width: 32,
                              child: Image.asset('assets/img/check-square.png'),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Expanded(
                                child: Text(
                              "Accidentes personales",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            )),
                            IconButton(
                              icon: Icon(Icons.info_outline),
                              onPressed: () {
                                CustomInfoDialog(
                                  context: context,
                                  iconColor: Theme.of(context).primaryColor,
                                  title: 'Accidentes personales',
                                  subtitle:
                                      'Cubre las lesiones personales de las personas que se encuentren dentro del vehículo asegurado en caso de accidente, ya sea muerte, invalidez total o parcial y gastos médicos.',
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                flex: 5,
                                child: Text("Tu franquicia en bolivianos es:",
                                    style: TextStyle(
                                        color: Color(0xff1D2766),
                                        fontSize: 14))),
                            IconButton(
                              icon: Icon(
                                Icons.info_outline,
                                color: Theme.of(context).accentColor,
                              ),
                              onPressed: () {
                                CustomInfoDialog(
                                  context: context,
                                  iconColor: Theme.of(context).accentColor,
                                  title: '¿Qué es una franquicia?',
                                  subtitle:
                                      'Importe fijo que queda a cargo del asegurado en caso de siniestro.',
                                );
                              },
                            ),
                          ],
                        ),
                        Container(
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
                                      color: Color(0xffF2F2F2),
                                      width: 2,
                                    ),
                                    color: Color(0xffF2F2F2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AutoSizeText(
                                        'Valor de franquicia',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 12.0,
                                          height: 1.5,
                                          fontFamily: 'Manrope',
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      AutoSizeText(
                                        valueFranquicia.toString(),
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 25.0,
                                          height: 0.5,
                                          fontFamily: 'Manrope',
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                      ),
                                      AutoSizeText(
                                        'Total cobertura',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 12.0,
                                          height: 1.5,
                                          fontFamily: 'Manrope',
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                      ),
                                      AutoSizeText(
                                        valueCotizacion! + medidaCotizacion,
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 25.0,
                                          height: 1.2,
                                          fontFamily: 'Manrope',
                                          fontWeight: FontWeight.w700,
                                        ),
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
                                      "Por ${widget.datosMotorizado!.diasPaquete.toString()} Días",
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
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                //Preguntamos el tipo de cotizacion
                                if (widget.datosMotorizado!.tipoCotizacion ==
                                    "PRECIOAMEDIDA") {
                                  widget.datosMotorizado!.diasCotizados =
                                      int.parse(valueCotizacion!);
                                  DateTime hoy = new DateTime.now();
                                  var fechaInicio = new DateTime(
                                      hoy.year, hoy.month, hoy.day);
                                  var fechaFin = new DateTime(
                                    hoy.year,
                                    hoy.month,
                                    hoy.day + int.parse(valueCotizacion!),
                                  );
                                  widget.datosMotorizado!.inicioVigencia =
                                      fechaInicio.toString().substring(0, 10);
                                  widget.datosMotorizado!.finVigencia =
                                      fechaFin.toString().substring(0, 10);
                                } else {
                                  widget.datosMotorizado!.costo =
                                      valueCotizacion;
                                }
                                widget.datosMotorizado!.franquicia =
                                    valueFranquicia.toString();
                                widget.datosMotorizado!.coberturas =
                                    idCoberturas.join(',');

                                print(widget.datosMotorizado!.periodo);

                                //Si el paquete es mensula o trimestral va a inspeccion
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Aviso(
                                      datosMotorizado: widget.datosMotorizado,
                                      esRenovacion: widget.esRenovacion,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: Text(
                                  "Continuar",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ));
  }

  Future<void> _showMyDialogCobertura(String titulo, String detalle) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(detalle),
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
          ],
        );
      },
    );
  }
}
