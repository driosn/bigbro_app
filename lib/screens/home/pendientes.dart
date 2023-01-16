import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mibigbro/rest_api/provider/poliza_provider.dart';
import 'package:mibigbro/screens/automovil/renovacion_motorizado.dart';
import 'package:mibigbro/screens/home/pagos.dart';
import 'package:mibigbro/screens/poliza/polizacompleta.dart';
import 'package:mibigbro/screens/poliza/renovacion.dart';
import 'package:mibigbro/utils/storage.dart';
import 'package:mibigbro/utils/utils.dart';
import 'package:mibigbro/widgets/bigbro_scaffold.dart';
import 'package:mibigbro/widgets/custom_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

enum EstadosSeguro { Vigentes, Vencidas, Anuladas }

class Pendientes extends StatefulWidget {
  Pendientes({Key? key}) : super(key: key);

  @override
  _PendientesWidgetState createState() => _PendientesWidgetState();
}

class _PendientesWidgetState extends State<Pendientes> {
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'observada';
  String estadoPoliza = "OBSERVADA";

  final _formKey = GlobalKey<FormState>();
  List<Widget>? polizasCargadas = <Widget>[];
  // Group Value for Radio Button.
  int id = 1;
  static const TextStyle labelText = TextStyle(
      color: Colors.red, fontFamily: 'Manrope', fontWeight: FontWeight.w500);
  static const TextStyle infoText = TextStyle(
      color: Color(0xff1D2766),
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w400);
  static const TextStyle infoStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 14.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w300);

  Future<List<Widget>> cargarDatosPolizas(String estadoPolizaDatos) async {
    int idUsuario = StorageUtils.getInteger('id_usuario');
    Utils utils = new Utils();

    var respuestaPoliza = await PolizaProvider.polizasPorEstado(
        idUsuario.toString(), 'PENDIENTESPAGO');
    var datosPolizas = json.decode(respuestaPoliza.body);
    var listaPolizas = <Widget>[];
    if (respuestaPoliza.statusCode == 200) {
      datosPolizas.sort((a, b) => (DateTime.parse(b['vigencia_inicio']))
          .compareTo(DateTime.parse(a['vigencia_inicio'])));

      for (var datoPoliza in datosPolizas) {
        String? placa = "-----";
        if (datoPoliza["placa"] != null) {
          placa = datoPoliza["placa"];
        }
        //print(datoAutomovil["marca"]);

        Widget imagenAuto = Container(
          height: 150.0,
          width: 40.0,
          color: Colors.grey,
        );
        if (datoPoliza["foto_frontal"] != "") {
          imagenAuto = Container(
            height: 150.0,
            width: 40.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(datoPoliza["foto_frontal"]))),
          );
        }
        String? nombreModelo = datoPoliza["modelo"];
        if (nombreModelo == "Otro") {
          nombreModelo = datoPoliza['otro_modelo'];
        }
        listaPolizas.add(
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 24,
                    ),
                    padding: EdgeInsets.all(36),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(3, 3),
                          blurRadius: 2,
                          spreadRadius: 3,
                        )
                      ],
                      border: Border.all(
                        color: Color(0xffEC1C24),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 115,
                              width: 115,
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: imagenAuto,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Marca:",
                                      style: labelText,
                                    ),
                                    Text(
                                      datoPoliza["marca"],
                                      style: infoText,
                                    ),
                                    Text(
                                      "Placa:",
                                      style: labelText,
                                    ),
                                    Text(
                                      datoPoliza["placa"],
                                      style: infoText,
                                    ),
                                    Text(
                                      "Circulación:",
                                      style: labelText,
                                    ),
                                    Text(
                                      datoPoliza["ciudad"],
                                      style: infoText,
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: Color(0xffEC1C24),
                          height: 0.0,
                          thickness: 1.5,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Text(
                                "Asegurador:",
                                textAlign: TextAlign.right,
                                style: labelText,
                              ),
                            ),
                            Spacer(flex: 1),
                            Expanded(
                              flex: 10,
                              child: Text(
                                datoPoliza["aseguradora"],
                                style: infoText,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Text(
                                "Inicio:",
                                textAlign: TextAlign.right,
                                style: labelText,
                              ),
                            ),
                            Spacer(flex: 1),
                            Expanded(
                              flex: 10,
                              child: Text(
                                datoPoliza["vigencia_inicio"],
                                style: infoText,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Text(
                                "Fin:",
                                textAlign: TextAlign.right,
                                style: labelText,
                              ),
                            ),
                            Spacer(flex: 1),
                            Expanded(
                              flex: 10,
                              child: Text(
                                datoPoliza["vigencia_final"],
                                style: infoText,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Text(
                                "Prima:",
                                textAlign: TextAlign.right,
                                style: labelText,
                              ),
                            ),
                            Spacer(flex: 1),
                            Expanded(
                              flex: 10,
                              child: Text(
                                datoPoliza["prima"].toString() + " USD",
                                style: infoText,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _verCoberturasDialog(context);
                          },
                          child: Text('Ver coberturas'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (datoPoliza["estado"] == "ANULADA")
                              SizedBox(
                                width: 70,
                                child: Column(
                                  children: [
                                    RawMaterialButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Pagos()),
                                        );
                                      },
                                      elevation: 2.0,
                                      fillColor: Colors.red,
                                      child: Icon(
                                        Icons.payment,
                                        size: 20.0,
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.all(5.0),
                                      shape: CircleBorder(),
                                    ),
                                    Text("Compartir", style: infoText)
                                  ],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.transparent,
                  )
                ],
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () async {
                      _launchPayURL(datoPoliza['url_pago']);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xffEC1C24),
                          width: 1.0,
                        ),
                      ),
                      child: Container(
                        height: 96,
                        width: 96,
                        decoration: BoxDecoration(
                          color: Color(0xffEC1C24),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.payment,
                                  color: Colors.white, size: 32),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Pagar',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }
      print(datosPolizas);
    }

    return listaPolizas;
  }

  _verCoberturasDialog(BuildContext context) {
    var coberturaWidget = <Widget>[];

    coberturaWidget.add(Text(
      "• Responsabilidad civil",
      style: infoStyle,
      textAlign: TextAlign.left,
    ));

    coberturaWidget.add(Text(
      "• Pérdida total por robo o accidente",
      style: infoStyle,
      textAlign: TextAlign.left,
    ));

    coberturaWidget.add(Text(
      "• Daños propios",
      style: infoStyle,
      textAlign: TextAlign.left,
    ));

    coberturaWidget.add(Text(
      "• Accidentes personales",
      style: infoStyle,
      textAlign: TextAlign.left,
    ));

    CustomDialog(
      context: context,
      iconColor: Theme.of(context).primaryColor,
      icon: Text(
        'i',
        style: TextStyle(
          fontSize: 48,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...coberturaWidget,
          const SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    print(estadoPoliza);
    return FutureBuilder<List<Widget>>(
      future: cargarDatosPolizas(estadoPoliza),
      builder: (context, snapshot) {
        //var datosPaquete = json.decode(respuestaPaquetes.body);
        if (snapshot.hasData) {
          polizasCargadas = snapshot.data;
          return BigBroScaffold(
            removeTrailingIcon: true,
            title: 'Pendientes',
            subtitle: 'Seguros pendientes de pago',
            subtitleStyle: TextStyle(
              color: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[],
                  ),
                  SizedBox(height: 20),
                  Text("Los siguientes seguros fueron verificados",
                      style: TextStyle(
                          color: Color(0xff1D2766),
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                      textAlign: TextAlign.center),
                  Text("puedes proceder con el pago",
                      style: TextStyle(
                          color: Color(0xff1D2766),
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                      textAlign: TextAlign.center),
                  Column(
                    children: [
                      ...polizasCargadas!,
                      const SizedBox(
                        height: 32,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return BigBroScaffold(
            removeTrailingIcon: true,
            title: 'Pendientes',
            subtitle: 'Seguros pendientes de pago',
            subtitleStyle: TextStyle(
              color: Colors.white,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(width: double.infinity),
                CircularProgressIndicator(),
                const SizedBox(
                  height: 12,
                ),
                Text('Cargando...')
              ],
            ),
          );
        }
      },
    );
  }
}

_launchPayURL(urlPago) async {
  if (await canLaunch(urlPago)) {
    await launch(urlPago);
  } else {
    throw 'Could not launch $urlPago';
  }
}
