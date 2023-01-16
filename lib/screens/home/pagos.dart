import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mibigbro/rest_api/provider/poliza_provider.dart';
import 'package:mibigbro/utils/dialog.dart';
import 'package:mibigbro/utils/storage.dart';
import 'package:url_launcher/url_launcher.dart';

enum EstadosSeguro { Vigentes, Vencidas, Anuladas }

class Pagos extends StatefulWidget {
  Pagos({Key? key}) : super(key: key);

  @override
  _PagosWidgetState createState() => _PagosWidgetState();
}

class _PagosWidgetState extends State<Pagos> {
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'realizados';
  String estadoDeuda = "PAGADO";
  String marca = "";
  bool checkPago = true;
  bool verBotonPago = true;
  bool verPagados = false;
  bool verPendientes = true;
  List<Widget>? deudasCargadas = <Widget>[];
  var listaIdPagos = [];
  final TextEditingController _marca = TextEditingController();
  // Group Value for Radio Button.
  int id = 1;
  static const TextStyle info = TextStyle(
      color: Color(0xff1D2766),
      fontFamily: 'Manrope',
      fontSize: 14,
      fontWeight: FontWeight.w700);
  static const TextStyle titulo = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 12,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w400);

  static const TextStyle labelText = TextStyle(
      color: Colors.red, fontFamily: 'Manrope', fontWeight: FontWeight.w500);
  static const TextStyle infoText = TextStyle(
      color: Color(0xff1D2766),
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w400);
  static const TextStyle infoStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w300);

  Future<List<Widget>> cargarDatosDeudas(
      String estadoDeudasDatos, String marca) async {
    int idUsuario = StorageUtils.getInteger('id_usuario');

    var respuestaDeuda =
        await PolizaProvider.polizasPorEstado(idUsuario.toString(), 'PAGADO');
    var datosDeudas = json.decode(utf8.decode(respuestaDeuda.bodyBytes));
    var listaDeudas = <Widget>[];
    if (respuestaDeuda.statusCode == 200) {
      for (var datoDeuda in datosDeudas) {
        String nombreModelo = datoDeuda["modelo"];

        listaDeudas.add(
          Container(
              margin: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 12),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff1D2766),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Poliza:  ",
                                          style: labelText,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          datoDeuda["nro_poliza"].toString(),
                                          style: infoText,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Inicio vigencia:  ",
                                          style: labelText,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          datoDeuda["vigencia_inicio"],
                                          style: infoText,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Fin vigencia:  ",
                                          style: labelText,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          datoDeuda["vigencia_final"],
                                          style: infoText,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Marca:",
                                          style: labelText,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          datoDeuda["marca"],
                                          style: infoText,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Modelo:",
                                          style: labelText,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          nombreModelo,
                                          style: infoText,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Placa:",
                                          style: labelText,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          datoDeuda["placa"] == null
                                              ? "-----"
                                              : datoDeuda["placa"],
                                          style: infoText,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Monto:",
                                          style: labelText,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          datoDeuda["prima"].toString() +
                                              " USD",
                                          style: infoText,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Fecha de pago:",
                                          style: labelText,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          datoDeuda["fecha_pago"] == null
                                              ? "-----"
                                              : datoDeuda["fecha_pago"],
                                          style: infoText,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ))),
                    ],
                  ),
                ],
              )),
        );
      }
    }

    return listaDeudas;
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
        future: cargarDatosDeudas(estadoDeuda, marca),
        builder: (context, snapshot) {
          //var datosPaquete = json.decode(respuestaPaquetes.body);
          if (snapshot.hasData) {
            deudasCargadas = snapshot.data;
            return Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(
                    color: Color(0xff1D2766), //change your color here
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  title: Text("Pagos realizados",
                      style: TextStyle(color: Color(0xff1D2766))),
                ),
                body: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(children: deudasCargadas!),
                  ],
                )));
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  _launchPagoURL(url_pago) async {
    var url = url_pago;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
