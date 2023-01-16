import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mibigbro/models/motorizadoModel.dart';
import 'package:mibigbro/rest_api/provider/descuento_provider.dart';
import 'package:mibigbro/rest_api/provider/motorizado_provider.dart';
import 'package:mibigbro/rest_api/provider/poliza_provider.dart';
import 'package:mibigbro/screens/cotizacion/calificacion.dart';
import 'package:mibigbro/screens/cotizacion/declaracion.dart';
import 'package:mibigbro/screens/cotizacion/firmar.dart';
import 'package:mibigbro/screens/home/home.dart';
import 'package:mibigbro/screens/poliza/revision.dart';
import 'package:mibigbro/utils/dialog.dart';
import 'package:mibigbro/utils/storage.dart';
import 'package:mibigbro/widgets/custom_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import 'mensajefinal.dart';

class ResumenSeguro extends StatefulWidget {
  final motorizadoModel? datosMotorizado;

  ResumenSeguro({this.datosMotorizado});
  static const TextStyle labelStyle = TextStyle(
      color: Colors.red,
      fontSize: 14.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);
  static const TextStyle infoStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 14.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w300);
  static const TextStyle infoStyleTitle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w600);
  static const TextStyle infoPrecioTachadoStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      height: 1,
      fontFamily: 'Manrope',
      decoration: TextDecoration.lineThrough,
      fontWeight: FontWeight.w700);
  static const TextStyle infoPrecioStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);

  Future verificarPago() async {
    print("Verificando pago");
    return "Dato";
  }

  @override
  _ResumenSeguroState createState() => _ResumenSeguroState();
}

class _ResumenSeguroState extends State<ResumenSeguro> {
  final appTitle = 'Resumen';
  bool verificarPagoEnabled = false;
  bool verPago = true;
  bool verContinuar = false;
  int idUsuario = StorageUtils.getInteger('id_usuario');
  String idTransaccion = "";
  int porcentageDescuento = 0;
  int idDescuento = 0;
  final TextEditingController _codigoDescuento = TextEditingController();

  Future<Map<String, dynamic>> cargarPoliza() async {
    int? idAutomovil = widget.datosMotorizado!.idAutomovil;

    var respuestaPoliza = await MotorizadoProvider.detalle(idAutomovil);
    var datosPoliza = json.decode(respuestaPoliza.body);
    print(datosPoliza);
    //marca['nombre_marca']
    return datosPoliza;
  }

  coberturaTexto() {
    var coberturaWidget = <Widget>[];

    coberturaWidget.add(Text(
      "Responsabilidad civil",
      style: ResumenSeguro.infoStyle,
      textAlign: TextAlign.left,
    ));
    coberturaWidget.add(SizedBox(
      height: 5,
    ));
    coberturaWidget.add(Text(
      "Pérdida total por robo o accidente",
      style: ResumenSeguro.infoStyle,
      textAlign: TextAlign.left,
    ));
    coberturaWidget.add(SizedBox(
      height: 5,
    ));
    coberturaWidget.add(Text(
      "Daños propios",
      style: ResumenSeguro.infoStyle,
      textAlign: TextAlign.left,
    ));
    coberturaWidget.add(SizedBox(
      height: 5,
    ));
    coberturaWidget.add(Text(
      "Accidentes personales",
      style: ResumenSeguro.infoStyle,
      textAlign: TextAlign.left,
    ));
    coberturaWidget.add(SizedBox(
      height: 5,
    ));
    return coberturaWidget;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: cargarPoliza(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data!['periodo_costo']);

            double costoTotalSeguro =
                double.parse(widget.datosMotorizado!.costo!);
            print(costoTotalSeguro);
            String? nombreModelo = snapshot.data!['modelo']['nombre_modelo'];

            /*  print(snapshot.data['automovil']['modelo']['nombre_modelo']);
            print(snapshot.data['automovil']['modelo']['nombre_marca']);
            print(snapshot.data['compania']['nombre_compania']);
            print(snapshot.data['coberturas']);
            print(snapshot.data['producto']);
            print(snapshot.data['periodo_total']);
            print(snapshot.data['vigencia_inicio']);
            print(snapshot.data['vigencia_final']);
            print(snapshot.data['periodo_costo']); 
            print(snapshot.data['coberturas']);*/

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
              body: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text("Resumen del seguro",
                              style: ResumenSeguro.infoStyleTitle,
                              textAlign: TextAlign.center),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        "Modelo de automotor:",
                                        style: ResumenSeguro.labelStyle,
                                        textAlign: TextAlign.right,
                                      ))),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    snapshot.data!['modelo']['nombre_marca'] +
                                        " " +
                                        nombreModelo,
                                    style: ResumenSeguro.infoStyle,
                                    textAlign: TextAlign.left,
                                  ))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Text(
                                        "Coberturas:",
                                        style: ResumenSeguro.labelStyle,
                                        textAlign: TextAlign.right,
                                      ))),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: coberturaTexto(),
                                  ))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: Text(
                                        "Tipo de uso:",
                                        style: ResumenSeguro.labelStyle,
                                        textAlign: TextAlign.right,
                                      ))),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    snapshot.data!['uso']['nombre_uso'],
                                    style: ResumenSeguro.infoStyle,
                                    textAlign: TextAlign.left,
                                  ))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: Text(
                                        "Departamento:",
                                        style: ResumenSeguro.labelStyle,
                                        textAlign: TextAlign.right,
                                      ))),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    snapshot.data!['ciudad']['nombre_ciudad'],
                                    style: ResumenSeguro.infoStyle,
                                    textAlign: TextAlign.left,
                                  ))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: Text(
                                        "Valor asegurado:",
                                        style: ResumenSeguro.labelStyle,
                                        textAlign: TextAlign.right,
                                      ))),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    snapshot.data!['valor_asegurado'] + ' USD',
                                    style: ResumenSeguro.infoStyle,
                                    textAlign: TextAlign.left,
                                  ))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: Text(
                                        "Aseguradora:",
                                        style: ResumenSeguro.labelStyle,
                                        textAlign: TextAlign.right,
                                      ))),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Alianza seguros",
                                    style: ResumenSeguro.infoStyle,
                                    textAlign: TextAlign.left,
                                  ))
                            ],
                          ),
                          SizedBox(height: 10),
                          /* Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: Text(
                                        "Producto:",
                                        style: ResumenSeguro.labelStyle,
                                        textAlign: TextAlign.right,
                                      ))),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    snapshot.data['producto'] +
                                        " " +
                                        snapshot.data['periodo_total'],
                                    style: ResumenSeguro.infoStyle,
                                    textAlign: TextAlign.left,
                                  ))
                            ],
                          ),
                          SizedBox(height: 10), */
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: Text(
                                        "Inicio de cobertura:",
                                        style: ResumenSeguro.labelStyle,
                                        textAlign: TextAlign.right,
                                      ))),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    widget.datosMotorizado!.inicioVigencia!,
                                    style: ResumenSeguro.infoStyle,
                                    textAlign: TextAlign.left,
                                  ))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: Text(
                                        "Fin de cobertura:",
                                        style: ResumenSeguro.labelStyle,
                                        textAlign: TextAlign.right,
                                      ))),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    widget.datosMotorizado!.finVigencia!,
                                    style: ResumenSeguro.infoStyle,
                                    textAlign: TextAlign.left,
                                  ))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: Text(
                                        "Costo total de la póliza:",
                                        style: ResumenSeguro.labelStyle,
                                        textAlign: TextAlign.right,
                                      ))),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    costoTotalSeguro.toString() + " Bs",
                                    style: ResumenSeguro.infoStyle,
                                    textAlign: TextAlign.left,
                                  ))
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                // minWidth: 20,
                                // color: Colors.red,
                                // textColor: Colors.white,
                                // disabledColor: Colors.grey,
                                // disabledTextColor: Colors.black,
                                // padding: EdgeInsets.all(8.0),
                                // splashColor: Colors.blueAccent,
                                onPressed: () async {
                                  var dialogDocument = DialogDocument();
                                  if (widget.datosMotorizado!.urlSlip == null) {
                                    DialogoProgreso dialog = DialogoProgreso(
                                        context, "Procesando..");
                                    dialog.mostrarDialogo();
                                    var slipGenerado =
                                        await PolizaProvider.generarSlip(
                                            widget.datosMotorizado!);
                                    Timer(Duration(seconds: 1), () async {
                                      dialog.ocultarDialogo();
                                      print(slipGenerado.body);

                                      Map<String, dynamic>? datosSlip =
                                          json.decode(slipGenerado.body);
                                      if (slipGenerado.statusCode == 200) {
                                        widget.datosMotorizado!.urlSlip =
                                            datosSlip!['name_file_slip'];
                                        String urlDoc = dialogDocument.launch(
                                            widget.datosMotorizado!.urlSlip!);
                                        _launchNav(urlDoc);
                                      }
                                    });
                                  } else {
                                    String urlDoc = dialogDocument.launch(
                                        widget.datosMotorizado!.urlSlip!);
                                    _launchNav(urlDoc);
                                  }
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.file_download,
                                      size: 20.0,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 190,
                                      child: Text(
                                        "Descargar slip de cotización",
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            // color: Color(0xff1D2766),
                            // textColor: Colors.white,
                            // disabledColor: Colors.grey,
                            // disabledTextColor: Colors.black,
                            // padding: EdgeInsets.all(8.0),
                            // splashColor: Colors.blueAccent,
                            onPressed: () async {
                              if (widget.datosMotorizado!.urlSlip == null) {
                                _showMyDialogNoSlip();
                              } else {
                                // _showMyDialogPago();
                                CustomDialog(
                                  context: context,
                                  iconColor: Theme.of(context).primaryColor,
                                  icon: Container(
                                    height: 42,
                                    width: 42,
                                    child: Image.asset(
                                        'assets/img/logo_bigbro.png'),
                                  ),
                                  extraActions: [
                                    GestureDetector(
                                      onTap: () {
                                        _guardar();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Aceptar',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                  content: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'miBigBro',
                                        style: TextStyle(
                                          color: Color(0xff1A2461),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Estas de acuerdo con los datos de tu seguro?',
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        'En caso de contar con un error de información en los datos declarados tu póliza será anulada',
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      )
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Text(
                              "Confirmar los datos",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ))),
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

  Future<void> _showMyDialogPago() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('miBigBro',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff1D2766),
                  fontSize: 20.0,
                  height: 1,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w700)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Está usted de acuerdo con los datos de tu seguro?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff1D2766),
                        fontSize: 14.0,
                        height: 1,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w300)),
                SizedBox(height: 15),
                Text(
                    'En caso de contar con un error de información en tus declarados tu póliza será anulada',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff1D2766),
                        fontSize: 14.0,
                        height: 1,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w300)),
                SizedBox(height: 5),
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
            TextButton(
              onPressed: () {
                _guardar();
              },
              child: Text(
                "Aceptar",
              ),
            )
          ],
        );
      },
    );
  }

  _guardar() async {
    var polizaCreada = await PolizaProvider.create(widget.datosMotorizado!);

    Map<String, dynamic>? datosRespuestaPoliza = json.decode(polizaCreada.body);
    print(polizaCreada.body);
    if (polizaCreada.statusCode == 201) {
      print(datosRespuestaPoliza!['id']);
      widget.datosMotorizado!.idPoliza = datosRespuestaPoliza['id'];

      CustomDialog(
        context: context,
        iconColor: Theme.of(context).accentColor,
        hideActions: true,
        barrierDismissible: false,
        icon: Icon(
          Icons.check,
          color: Colors.white,
          size: 50,
        ),
        content: Column(
          children: [
            Text(
              'Tu seguro ha sido preaprobado',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Antes de continuar con el pago tus datos seran verificados.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              '¡Gracias por elegir miBigbro!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              child: Text('Finalizar'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Calificacion(datosMotorizado: widget.datosMotorizado),
                  ),
                );
              },
            )
          ],
        ),
      );

      // Navigator.push(
      // context,
      // MaterialPageRoute(
      // builder: (context) => Mensajefinal(
      // datosMotorizado: widget.datosMotorizado)),
      // );
    }
  }

  Future<void> _showMyDialogNoSlip() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Aviso',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff1D2766),
                  fontSize: 20.0,
                  height: 1,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w700)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Usted debe descargar y leer el slip de cotización antes de poder continuar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff1D2766),
                        fontSize: 14.0,
                        height: 1,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w300)),
                SizedBox(height: 5),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Volver'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  _launchNav(String urlDocument) async {
    print(urlDocument);
    if (await canLaunch(urlDocument)) {
      await launch(urlDocument);
    } else {
      throw 'Could not launch $urlDocument';
    }
  }
}
