import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mibigbro/rest_api/provider/poliza_provider.dart';
import 'package:mibigbro/screens/automovil/renovacion_motorizado.dart';
import 'package:mibigbro/screens/home/pagos.dart';
import 'package:mibigbro/screens/poliza/polizacompleta.dart';
import 'package:mibigbro/screens/poliza/renovacion.dart';
import 'package:mibigbro/utils/dialog.dart';
import 'package:mibigbro/utils/storage.dart';
import 'package:mibigbro/utils/utils.dart';
import 'package:mibigbro/widgets/bigbro_scaffold.dart';
import 'package:mibigbro/widgets/custom_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

enum EstadosSeguro { Vigentes, Vencidas, Anuladas }

class Historial extends StatefulWidget {
  Historial({Key? key}) : super(key: key);

  @override
  _HistorialWidgetState createState() => _HistorialWidgetState();
}

class _HistorialWidgetState extends State<Historial> {
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'vigentes';
  String estadoPoliza = "VIGENTES";

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
        idUsuario.toString(), estadoPolizaDatos);
    var datosPolizas = json.decode(respuestaPoliza.body);
    var listaPolizas = <Widget>[];
    if (respuestaPoliza.statusCode == 200) {
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
                borderRadius: BorderRadius.circular(16),
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
                                color: Colors.grey.shade200,
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
                  ),
                ],
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () async {
                      DialogoProgreso dialog =
                          DialogoProgreso(context, "Procesando..");
                      dialog.mostrarDialogo();
                      var respuestaPoliza =
                          await PolizaProvider.descargarCertificado(
                              datoPoliza["id_poliza"]);

                      var datosCertificado = json.decode(respuestaPoliza.body);
                      Timer(Duration(seconds: 1), () {
                        dialog.ocultarDialogo();
                        var urlCertificado =
                            datosCertificado["url_certificado"];
                        _launchCertURL(urlCertificado);
                      });
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
                          )),
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
                              Image.asset('assets/img/ver_certificado.png'),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Ver certificado',
                                style: TextStyle(
                                  fontSize: 10,
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

  Future<void> _anularPolizaDialog(String idPoliza) async {
    TextEditingController _motivoAnulacion = new TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Está seguro de anular la poliza?',
              style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Manrope',
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _motivoAnulacion,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Ingrese el motivo de anulacion';
                        }
                        return null;
                      },
                      decoration: new InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff1D2766), width: 3.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 3.0),
                        ),
                        hintText: '',
                      ),
                    )),
                Text("Si anula la póliza no podra revertirlo despues",
                    style: TextStyle(
                        color: Color(0xff1D2766),
                        fontFamily: 'Manrope',
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Anular'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var respuestaAnularPoliza = await PolizaProvider.anularPoliza(
                      idPoliza, _motivoAnulacion.text);
                  var datosPolizasAnulada =
                      json.decode(respuestaAnularPoliza.body);
                  print(datosPolizasAnulada);
                  Navigator.of(context).pop();
                  setState(() {
                    radioButtonItem = 'anuladas';
                    id = 3;
                    estadoPoliza = "ANULADO";
                  });
                }
              },
            ),
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
              title: '\nHistorial',
              subtitle: '',
              subtitleStyle: TextStyle(
                color: Colors.white,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Vigentes',
                          style: new TextStyle(fontSize: 14.0),
                        ),
                        Radio(
                          value: 1,
                          groupValue: id,
                          activeColor: Color(0xff1D2766),
                          onChanged: (dynamic val) {
                            setState(() {
                              radioButtonItem = 'vigentes';
                              id = 1;
                              estadoPoliza = "VIGENTES";
                            });
                          },
                        ),
                        Text(
                          'Vencidos',
                          style: new TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Radio(
                          value: 2,
                          groupValue: id,
                          activeColor: Color(0xff1D2766),
                          onChanged: (dynamic val) {
                            setState(() {
                              radioButtonItem = 'vencidas';
                              id = 2;
                              estadoPoliza = "VENCIDAS";
                            });
                          },
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        DialogoProgreso dialog =
                            DialogoProgreso(context, "Procesando..");
                        dialog.mostrarDialogo();
                        var respuestaPoliza =
                            await PolizaProvider.descargarCertificado(23);

                        var datosCertificado =
                            json.decode(respuestaPoliza.body);
                        Timer(Duration(seconds: 1), () {
                          dialog.ocultarDialogo();
                          var urlCertificado =
                              datosCertificado["url_certificado"];
                          _launchCertURL(urlCertificado);
                        });
                      },
                      child: Text(
                        "Mis seguros " + '$radioButtonItem',
                        style: TextStyle(
                          color: Color(0xff1D2766),
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        ...polizasCargadas!,
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        //headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchCertURL(String urlCertificado) async {
    if (await canLaunch(urlCertificado)) {
      await _launchInBrowser(urlCertificado);
    } else {
      throw 'Could not launch $urlCertificado';
    }
  }
}
