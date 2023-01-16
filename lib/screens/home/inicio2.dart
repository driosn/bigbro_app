import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mibigbro/rest_api/provider/home_provider.dart';
import 'package:mibigbro/screens/automovil/datos_motorizado.dart';
import 'package:mibigbro/screens/automovil/renovacion_motorizado.dart';
import 'package:mibigbro/screens/home/pendientes.dart';
import 'package:mibigbro/screens/perfil/datos_personales.dart';
import 'package:mibigbro/utils/storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'home.dart';

class Inicio extends StatelessWidget {
  Inicio(this.irHistorial);
  final Function irHistorial;
  ImageProvider? imagenUsuario;
  static const TextStyle optionStyleTitle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 13.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w600);
  static const TextStyle optionStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 15.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w400);
  static const TextStyle panelTitleStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 22.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);
  static const TextStyle panelTitleAvisoStyle = TextStyle(
      color: Colors.red,
      fontSize: 18.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);
  static const TextStyle panelStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 12.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w400);

  Future<Map<String, dynamic>> cargarDatos() async {
    int idUsuario = StorageUtils.getInteger('id_usuario');
    var respuestaHome =
        await HomeProvider.cargarDatos(idUsuario.toString(), "VIGENTE");
    var datosHome = json.decode(respuestaHome.body);
    print(datosHome["imagen"] == "");
    imagenUsuario = ((datosHome["imagen"] == "")
        ? AssetImage('assets/img/user_icon.png')
        : NetworkImage(datosHome["imagen"])) as ImageProvider<Object>?;

    StorageUtils.setInteger("puntos", datosHome["puntos"] ?? 0);

    StorageUtils.setString("nombre", datosHome["nombre"]);
    StorageUtils.setString("apellido_paterno", datosHome["apellido_paterno"]);
    StorageUtils.setString("apellido_materno", datosHome["apellido_materno"]);
    if (datosHome["profesion"] == "") {
      StorageUtils.setInteger("id_profesion", 0);
    } else {
      StorageUtils.setInteger("id_profesion", datosHome["profesion"]);
    }
    if (datosHome["ciudad"] == "") {
      StorageUtils.setInteger("id_ciudad", 0);
    } else {
      StorageUtils.setInteger("id_ciudad", datosHome["ciudad"]);
    }

    //print(datosHome);
    return datosHome;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: cargarDatos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //print(automovilesVigentes.length);
            print(snapshot.data);
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              border: Border.all(color: Colors.grey, width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: imagenUsuario,
                                radius: 50,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  /* Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Text("Puntos",
                                              style: optionStyleTitle,
                                              textAlign: TextAlign.center),
                                          Text(
                                              snapshot.data["puntos"]
                                                  .toString(),
                                              style: optionStyle,
                                              textAlign: TextAlign.center)
                                        ],
                                      )), */
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Text("Bienvenid@",
                                              style: optionStyleTitle,
                                              textAlign: TextAlign.center),
                                          Text(snapshot.data!["nombre"],
                                              style: optionStyle,
                                              textAlign: TextAlign.center)
                                        ],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Text("Vehículos Asegurados",
                                              style: optionStyleTitle,
                                              textAlign: TextAlign.center),
                                          Text(
                                              snapshot
                                                  .data!["nro_polizas_vigentes"]
                                                  .toString(),
                                              style: optionStyle,
                                              textAlign: TextAlign.center)
                                        ],
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                            top: 10,
                            left: 0,
                            child: RawMaterialButton(
                              onPressed: () {
                                _launchLlamada();
                              },
                              elevation: 10.0,
                              fillColor: Colors.red,
                              child: Icon(
                                Icons.phone,
                                size: 30.0,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(12.0),
                              shape: CircleBorder(),
                            )),
                        Positioned(
                            top: 10,
                            right: 0,
                            child: RawMaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DatosPersonales()),
                                );
                              },
                              elevation: 10.0,
                              fillColor: Colors.red,
                              child: Icon(
                                Icons.edit,
                                size: 30.0,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(12.0),
                              shape: CircleBorder(),
                            ))
                      ],
                    ),
                    /* if (numeroAutos != "0") widgetVehiculosAsegurados,
                    if (numeroAutos == "0") */
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Pendientes()),
                        );
                      },
                      child: Container(
                          width: 350,
                          margin: EdgeInsets.only(
                              left: 24, right: 24, top: 24, bottom: 5),
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
                              if (snapshot
                                      .data!["nro_polizas_pendientes_pago"] ==
                                  0)
                                Text(
                                  "Usted no tiene seguros pendientes de pago ",
                                  style: TextStyle(
                                      color: Color(0xff1D2766),
                                      fontSize: 18.0,
                                      height: 1,
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                )
                              else
                                Text(
                                  'Usted tiene ${snapshot.data!["nro_polizas_pendientes_pago"]} seguro pendiente de pago',
                                  style: panelTitleAvisoStyle,
                                  textAlign: TextAlign.center,
                                )
                            ],
                          )),
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                if (snapshot.data!["datos_personales"] == 1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DatosAutomovil()),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Debe completar tus datos personales",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 7,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 20.0);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DatosPersonales()),
                                  );
                                }
                              },
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: 22, right: 5, top: 10, bottom: 0),
                                  padding: EdgeInsets.fromLTRB(22, 22, 22, 22),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      AutoSizeText(
                                        'Nuevo seguro',
                                        style: panelTitleStyle,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                      ),
                                      Text(
                                        "Autos Nuevos ",
                                        style: panelStyle,
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  )),
                            )),
                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RenovacionMotorizado()),
                                  );
                                },
                                child: Container(
                                    margin: EdgeInsets.only(
                                        left: 5, right: 22, top: 10, bottom: 0),
                                    padding:
                                        EdgeInsets.fromLTRB(22, 22, 22, 22),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      children: [
                                        AutoSizeText(
                                          "Renovar seguro",
                                          style: panelTitleStyle,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                        ),
                                        Text(
                                          "Autos asegurados ",
                                          style: panelStyle,
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ))))
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          _launchLandingURL();
                        },
                        child: Container(
                            width: 350,
                            margin: EdgeInsets.only(
                                left: 24, right: 24, top: 15, bottom: 12),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.red,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Text("Conoce a miBigBro",
                                    style: panelTitleStyle),
                                Text(
                                  "Te explicamos cómo funciona el seguro que ofrecemos",
                                  style: panelStyle,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ))),
                    Container(
                      width: 350,
                      margin: EdgeInsets.only(
                          left: 24, right: 24, top: 0, bottom: 12),
                      child: TextButton(
                        child: new Text(
                          "Salir",
                          style: TextStyle(color: Colors.red),
                        ),
                        // borderSide: BorderSide(color: Colors.red),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, "login", (r) => false);
                        },
                      ),
                      // shape: new RoundedRectangleBorder(
                      // borderRadius: new BorderRadius.circular(10.0))),
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

  _launchLandingURL() async {
    const url = 'http://www.mibigbro.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchLlamada() async {
    const url = "tel:800103070";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
