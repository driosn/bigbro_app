import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mibigbro/models/motorizadoModel.dart';
import 'package:mibigbro/rest_api/provider/motorizado_provider.dart';
import 'package:mibigbro/rest_api/provider/poliza_provider.dart';
import 'package:mibigbro/screens/cotizacion/cotizador.dart';
import 'package:mibigbro/utils/storage.dart';
import 'package:mibigbro/widgets/bigbro_scaffold.dart';
import 'package:mibigbro/widgets/custom_dialog.dart';

class RenovacionMotorizado extends StatefulWidget {
  RenovacionMotorizado({Key? key}) : super(key: key);

  @override
  _DetalleMotorizadoState createState() => _DetalleMotorizadoState();
}

class _DetalleMotorizadoState extends State<RenovacionMotorizado> {
  // Default Radio Button Selected Item When App Starts.
  String? estadoPoliza = "vencida";

  _actualizarValor(
    int? idAuto,
    int idUser,
    valorAsegurado,
    marcaAuto,
    modeloAuto,
    anoAuto,
    usoAuto,
    ciudadAuto,
    idInspeccion,
    int? nroRenovacion,
    tipo,
    vigenciaFinal,
  ) async {
    TextEditingController _valorAsegurado = new TextEditingController();
    var valorAseguradoString = valorAsegurado.toString().split('.');
    _valorAsegurado.text = valorAseguradoString[0];

    String titulo = "";

    if (tipo == "vencida_1_dia") {
      titulo =
          "La última póliza que adquiriste para este auto venció y esta  dentro las 24 horas, así que te ahorras varios pasos y obtendras un descuento";
    } else if (tipo == "vencida_30_dias") {
      titulo =
          "La última póliza que adquiriste venció hace menos de 30 días. Pero puedes renovarla y obtener un descuento.";
    } else {
      titulo =
          "La última póliza que adquiriste para este auto venció hace mas de 30 días. ";
    }

    CustomDialog(
      context: context,
      iconColor: Theme.of(context).primaryColor,
      icon: Text(
        'i',
        style: TextStyle(color: Colors.white, fontSize: 50),
      ),
      content: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Text(
            'Valor a asegurar',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            titulo,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: _valorAsegurado,
            textAlign: TextAlign.center,
            readOnly:
                DateTime.parse(vigenciaFinal).year - DateTime.now().year < 1,
            style: TextStyle(fontSize: 16),
            decoration: new InputDecoration(
              suffix: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                            'Solamente es posible modificar el valor asegurado, si ya pasó un año de la fecha de fin de vigencia'),
                      );
                    },
                  );
                },
                child: Icon(Icons.info, color: Color(0xff1D2766)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff1D2766), width: 3.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 3.0),
              ),
              hintText: '0 USD',
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'Debe actualizar el valor del vehículo en USD',
            style: TextStyle(
              color: Color(0xff1D2766),
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      extraActions: [
        const Spacer(),
        GestureDetector(
          onTap: () async {
            //Navigator.of(context).pop();
            print(estadoPoliza);
            var respuestaAutomovilesActualizado =
                await MotorizadoProvider.actualizarValor(
                    _valorAsegurado.text, idAuto);
            var datoAutomovil =
                json.decode(respuestaAutomovilesActualizado.body);
            final datosMotorizado = motorizadoModel(
                marca: marcaAuto,
                modelo: modeloAuto,
                ano: anoAuto,
                uso: usoAuto,
                ciudad: ciudadAuto,
                valor: _valorAsegurado.text,
                idUser: idUser,
                idAutomovil: idAuto,
                idInspeccion: idInspeccion,
                camino: estadoPoliza,
                nroRenovacion: nroRenovacion! + 1,
                periodo: "");

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CotizadorTab(
                  datosMotorizado: datosMotorizado,
                  esRenovacion: true,
                ),
              ),
            );
          },
          child: Text(
            'Actualizar\nvalor asegurado',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        )
      ],
    );

    // return showDialog<void>(
    //   context: context,
    //   barrierDismissible: false, // user must tap button!
    //   builder: (BuildContext context) {
    //     print(tipo);

    //     return AlertDialog(
    //       // title:
    //       content: SingleChildScrollView(
    //         child: ListBody(
    //           children: <Widget>[
    //             Text(titulo,
    //                 style: TextStyle(fontSize: 14, color: Color(0xff1D2766))),
    //             SizedBox(
    //               height: 5,
    //             ),
    //             SizedBox(
    //               height: 5,
    //             ),
    //             TextField(
    //               controller: _valorAsegurado,
    //               textAlign: TextAlign.center,
    //               readOnly:
    //                   DateTime.parse(vigenciaFinal).year - DateTime.now().year <
    //                       1,
    //               style: TextStyle(fontSize: 16),
    //               decoration: new InputDecoration(
    //                 suffix: GestureDetector(
    //                   onTap: () {
    //                     showDialog(
    //                       context: context,
    //                       builder: (context) {
    //                         return AlertDialog(
    //                           content: Text(
    //                               'Sólamente es posible modificar el valor asegurado si ya pasó un año a la fecha fin de vigencia'),
    //                         );
    //                       },
    //                     );
    //                   },
    //                   child: Icon(Icons.info, color: Color(0xff1D2766)),
    //                 ),
    //                 focusedBorder: OutlineInputBorder(
    //                   borderSide:
    //                       BorderSide(color: Color(0xff1D2766), width: 3.0),
    //                 ),
    //                 enabledBorder: OutlineInputBorder(
    //                   borderSide: BorderSide(color: Colors.black, width: 3.0),
    //                 ),
    //                 hintText: '0 USD',
    //               ),
    //             ),
    //             Text(
    //               'Debe actualizar el valor del vehículo en USD',
    //               style: TextStyle(color: Color(0xff1D2766), fontSize: 14),
    //             )
    //           ],
    //         ),
    //       ),
    //       actions: <Widget>[
    //         TextButton(
    //           child: Text('Cancelar'),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //         TextButton(
    //           child: Text('Actualizar valor asegurado'),
    //           onPressed: () async {
    //             //Navigator.of(context).pop();
    //             print(estadoPoliza);
    //             var respuestaAutomovilesActualizado =
    //                 await MotorizadoProvider.actualizarValor(
    //                     _valorAsegurado.text, idAuto);
    //             var datoAutomovil =
    //                 json.decode(respuestaAutomovilesActualizado.body);
    //             final datosMotorizado = motorizadoModel(
    //                 marca: marcaAuto,
    //                 modelo: modeloAuto,
    //                 ano: anoAuto,
    //                 uso: usoAuto,
    //                 ciudad: ciudadAuto,
    //                 valor: _valorAsegurado.text,
    //                 idUser: idUser,
    //                 idAutomovil: idAuto,
    //                 idInspeccion: idInspeccion,
    //                 camino: estadoPoliza,
    //                 nroRenovacion: nroRenovacion! + 1,
    //                 periodo: "");

    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => CotizadorTab(
    //                   datosMotorizado: datosMotorizado,
    //                   esRenovacion: true,
    //                 ),
    //               ),
    //             );
    //           },
    //         )
    //       ],
    //     );
    //   },
    // );
  }

  Future<List<Widget>> cargarDatosAutomoviles() async {
    int idUsuario = StorageUtils.getInteger('id_usuario');
    var respuestaAutomoviles =
        await PolizaProvider.polizasPorEstado(idUsuario.toString(), 'VENCIDAS');
    var datosAutomoviles = json.decode(respuestaAutomoviles.body);
    var listAutos = <Widget>[];
    if (respuestaAutomoviles.statusCode == 200) {
      for (var datoAutomovil in datosAutomoviles) {
        //print(datoAutomovil["marca"]);
        String? placa = "";
        if (datoAutomovil["placa"] != null) {
          placa = datoAutomovil["placa"];
        }
        Widget imagenAuto = Container(
          height: 150.0,
          width: 40.0,
          color: Colors.grey,
        );
        if (datoAutomovil["foto_frontal"] != "") {
          imagenAuto = Container(
            height: 150.0,
            width: 40.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(datoAutomovil["foto_frontal"]))),
          );
        }
        listAutos.add(
          new GestureDetector(
            onTap: () {
              setState(() {
                estadoPoliza = datoAutomovil["estado"];
              });
              _actualizarValor(
                datoAutomovil["id_automovil"],
                idUsuario,
                datoAutomovil["valor_asegurado"],
                datoAutomovil["id_marca"],
                datoAutomovil["id_modelo"],
                datoAutomovil["id_year"],
                datoAutomovil["id_uso"],
                datoAutomovil["id_ciudad"],
                datoAutomovil["id_inspeccion"],
                datoAutomovil["nro_renovacion"],
                datoAutomovil["estado"],
                datoAutomovil["vigencia_final"],
              );
            },
            child: Container(
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
                            borderRadius: BorderRadius.circular(16)),
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
                                datoAutomovil["marca"],
                                style: infoText,
                              ),
                              Text(
                                "Placa:",
                                style: labelText,
                              ),
                              Text(
                                datoAutomovil["placa"],
                                style: infoText,
                              ),
                              Text(
                                "Circulación:",
                                style: labelText,
                              ),
                              Text(
                                datoAutomovil["ciudad"],
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
                          datoAutomovil["aseguradora"],
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
                          datoAutomovil["vigencia_inicio"],
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
                          datoAutomovil["vigencia_final"],
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
                          datoAutomovil["prima"].toString() + " USD",
                          style: infoText,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

    return listAutos;
  }

  String radioButtonItem = 'vigentes';

  // Group Value for Radio Button.
  int id = 1;
  static const TextStyle labelText = TextStyle(
      color: Colors.red, fontFamily: 'Manrope', fontWeight: FontWeight.w500);
  static const TextStyle infoText = TextStyle(
      color: Color(0xff1D2766),
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w400);
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
      future: cargarDatosAutomoviles(),
      builder: (context, snapshot) {
        //var datosPaquete = json.decode(respuestaPaquetes.body);
        if (snapshot.hasData) {
          return BigBroScaffold(
            title: 'Datos del motorizado',
            subtitle: 'Renovar seguro',
            body: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                    child: Text(
                      "Elija el vehículo a renovar, si renuevas tu seguro antes de las 24 horas del vencimiento de tu póliza, no necesitas realizar las fotos de inspección y obtendrás un descuento.",
                      style: TextStyle(
                          color: Color(0xff1D2766),
                          fontWeight: FontWeight.w300,
                          fontSize: 12),
                      textAlign: TextAlign.center,
                    )),
                Column(
                  children: [
                    ...snapshot.data!,
                    const SizedBox(
                      height: 32,
                    )
                  ],
                )
              ],
            )),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
