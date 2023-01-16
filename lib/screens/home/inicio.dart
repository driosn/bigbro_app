import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mibigbro/rest_api/provider/home_provider.dart';
import 'package:mibigbro/screens/automovil/datos_motorizado.dart';
import 'package:mibigbro/screens/automovil/renovacion_motorizado.dart';
import 'package:mibigbro/screens/home/contacto.dart';
import 'package:mibigbro/screens/home/pendientes.dart';
import 'package:mibigbro/screens/login/login.dart';
import 'package:mibigbro/screens/perfil/datos_personales.dart';
import 'package:mibigbro/screens/solicitudes/solicitudes.dart';
import 'package:mibigbro/utils/spacing.dart';
import 'package:mibigbro/utils/storage.dart';
import 'package:url_launcher/url_launcher.dart';

class Inicio extends StatelessWidget {
  Inicio(
    this.irHistorial, {
    required this.onTapIndex,
  });
  final Function irHistorial;
  final Function(int) onTapIndex;
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

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: cargarDatos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //print(automovilesVigentes.length);
            print(snapshot.data);
            return Scaffold(
              key: scaffoldKey,
              drawer: Drawer(
                child: Container(
                  height: double.infinity,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.close,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DatosPersonales()));
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.person_rounded,
                                      color: Colors.white),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Perfil',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: () {
                                onTapIndex(3);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.lock_clock, color: Colors.white),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Pendientes',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: () {
                                onTapIndex(4);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.chat, color: Colors.white),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Contacto',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: () {
                                StorageUtils.setInteger("id_usuario", 0);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                    (route) => false);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.exit_to_app, color: Colors.white),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Cerrar Sesión',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              body: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: SpacingValues.l,
                      horizontal: SpacingValues.m * 2,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(SpacingValues.xl),
                        bottomRight: Radius.circular(SpacingValues.xl),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: SpacingValues.xl,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                scaffoldKey.currentState!.openDrawer();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 9,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    SpacingValues.m,
                                  ),
                                ),
                                child: Icon(
                                  Icons.menu,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DatosPersonales(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 38,
                                        width: 38,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: imagenUsuario ??
                                                AssetImage(
                                                  'assets/img/user_icon.png',
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        VerticalSpacing.m,
                        Text(
                          'Bienvenid@, ${snapshot.data!["nombre"]}',
                          style: TextStyle(
                            color: Colors.grey.shade300,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: _inicioBody(context, data: snapshot.data!),
                    ),
                  )
                  // Stack(
                  //   children: [
                  //     Container(
                  //       padding: EdgeInsets.all(10),
                  //       decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.only(
                  //               bottomLeft: Radius.circular(20),
                  //               bottomRight: Radius.circular(20)),
                  //           border: Border.all(color: Colors.grey, width: 1),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey.withOpacity(0.5),
                  //               spreadRadius: 2,
                  //               blurRadius: 5,
                  //               offset: Offset(
                  //                   0, 3), // changes position of shadow
                  //             ),
                  //           ]),
                  //       child: Column(
                  //         children: [
                  //           CircleAvatar(
                  //             backgroundImage: imagenUsuario,
                  //             radius: 50,
                  //           ),
                  //           Row(
                  //             mainAxisAlignment:
                  //                 MainAxisAlignment.spaceAround,
                  //             children: <Widget>[
                  //               /* Expanded(
                  //                   flex: 1,
                  //                   child: Column(
                  //                     children: [
                  //                       Text("Puntos",
                  //                           style: optionStyleTitle,
                  //                           textAlign: TextAlign.center),
                  //                       Text(
                  //                           snapshot.data["puntos"]
                  //                               .toString(),
                  //                           style: optionStyle,
                  //                           textAlign: TextAlign.center)
                  //                     ],
                  //                   )), */
                  //               Expanded(
                  //                   flex: 1,
                  //                   child: Column(
                  //                     children: [
                  //                       Text("Bienvenid@",
                  //                           style: optionStyleTitle,
                  //                           textAlign: TextAlign.center),
                  //                       Text(snapshot.data!["nombre"],
                  //                           style: optionStyle,
                  //                           textAlign: TextAlign.center)
                  //                     ],
                  //                   )),
                  //               Expanded(
                  //                   flex: 1,
                  //                   child: Column(
                  //                     children: [
                  //                       Text("Vehículos Asegurados",
                  //                           style: optionStyleTitle,
                  //                           textAlign: TextAlign.center),
                  //                       Text(
                  //                           snapshot
                  //                               .data!["nro_polizas_vigentes"]
                  //                               .toString(),
                  //                           style: optionStyle,
                  //                           textAlign: TextAlign.center)
                  //                     ],
                  //                   )),
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //     Positioned(
                  //         top: 10,
                  //         left: 0,
                  //         child: RawMaterialButton(
                  //           onPressed: () {
                  //             _launchLlamada();
                  //           },
                  //           elevation: 10.0,
                  //           fillColor: Colors.red,
                  //           child: Icon(
                  //             Icons.phone,
                  //             size: 30.0,
                  //             color: Colors.white,
                  //           ),
                  //           padding: EdgeInsets.all(12.0),
                  //           shape: CircleBorder(),
                  //         )),
                  //     Positioned(
                  //         top: 10,
                  //         right: 0,
                  //         child: RawMaterialButton(
                  //           onPressed: () {
                  //             Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => DatosPersonales()),
                  //             );
                  //           },
                  //           elevation: 10.0,
                  //           fillColor: Colors.red,
                  //           child: Icon(
                  //             Icons.edit,
                  //             size: 30.0,
                  //             color: Colors.white,
                  //           ),
                  //           padding: EdgeInsets.all(12.0),
                  //           shape: CircleBorder(),
                  //         ))
                  //   ],
                  // ),
                  // /* if (numeroAutos != "0") widgetVehiculosAsegurados,
                  // if (numeroAutos == "0") */
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => Pendientes()),
                  //     );
                  //   },
                  //   child: Container(
                  //       width: 350,
                  //       margin: EdgeInsets.only(
                  //           left: 24, right: 24, top: 24, bottom: 5),
                  //       padding: EdgeInsets.all(24),
                  //       decoration: BoxDecoration(
                  //         border: Border.all(
                  //           color: Colors.red,
                  //           width: 2,
                  //         ),
                  //         borderRadius: BorderRadius.circular(12),
                  //       ),
                  //       child: Column(
                  //         children: [
                  //           if (snapshot
                  //                   .data!["nro_polizas_pendientes_pago"] ==
                  //               0)
                  //             Text(
                  //               "Usted no tiene seguros pendientes de pago ",
                  //               style: TextStyle(
                  //                   color: Color(0xff1D2766),
                  //                   fontSize: 18.0,
                  //                   height: 1,
                  //                   fontFamily: 'Manrope',
                  //                   fontWeight: FontWeight.w700),
                  //               textAlign: TextAlign.center,
                  //             )
                  //           else
                  //             Text(
                  //               'Usted tiene ${snapshot.data!["nro_polizas_pendientes_pago"]} seguro pendiente de pago',
                  //               style: panelTitleAvisoStyle,
                  //               textAlign: TextAlign.center,
                  //             )
                  //         ],
                  //       )),
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //         flex: 1,
                  //         child: GestureDetector(
                  //           onTap: () {
                  //             if (snapshot.data!["datos_personales"] == 1) {
                  //               Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                     builder: (context) => DatosAutomovil()),
                  //               );
                  //             } else {
                  //               Fluttertoast.showToast(
                  //                   msg:
                  //                       "Debe completar sus datos personales",
                  //                   toastLength: Toast.LENGTH_LONG,
                  //                   gravity: ToastGravity.BOTTOM,
                  //                   timeInSecForIosWeb: 7,
                  //                   backgroundColor: Colors.black,
                  //                   textColor: Colors.white,
                  //                   fontSize: 20.0);
                  //               Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                     builder: (context) =>
                  //                         DatosPersonales()),
                  //               );
                  //             }
                  //           },
                  //           child: Container(
                  //               margin: EdgeInsets.only(
                  //                   left: 22, right: 5, top: 10, bottom: 0),
                  //               padding: EdgeInsets.fromLTRB(22, 22, 22, 22),
                  //               decoration: BoxDecoration(
                  //                 border: Border.all(
                  //                   color: Colors.red,
                  //                   width: 2,
                  //                 ),
                  //                 borderRadius: BorderRadius.circular(12),
                  //               ),
                  //               child: Column(
                  //                 children: [
                  //                   AutoSizeText(
                  //                     'Nuevo seguro',
                  //                     style: panelTitleStyle,
                  //                     textAlign: TextAlign.center,
                  //                     maxLines: 2,
                  //                   ),
                  //                   Text(
                  //                     "Autos Nuevos ",
                  //                     style: panelStyle,
                  //                     textAlign: TextAlign.center,
                  //                   )
                  //                 ],
                  //               )),
                  //         )),
                  //     Expanded(
                  //         flex: 1,
                  //         child: GestureDetector(
                  //             onTap: () {
                  //               Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                     builder: (context) =>
                  //                         RenovacionMotorizado()),
                  //               );
                  //             },
                  //             child: Container(
                  //                 margin: EdgeInsets.only(
                  //                     left: 5, right: 22, top: 10, bottom: 0),
                  //                 padding:
                  //                     EdgeInsets.fromLTRB(22, 22, 22, 22),
                  //                 decoration: BoxDecoration(
                  //                   border: Border.all(
                  //                     color: Colors.red,
                  //                     width: 2,
                  //                   ),
                  //                   borderRadius: BorderRadius.circular(12),
                  //                 ),
                  //                 child: Column(
                  //                   children: [
                  //                     AutoSizeText(
                  //                       "Renovar seguro",
                  //                       style: panelTitleStyle,
                  //                       textAlign: TextAlign.center,
                  //                       maxLines: 2,
                  //                     ),
                  //                     Text(
                  //                       "Autos asegurados ",
                  //                       style: panelStyle,
                  //                       textAlign: TextAlign.center,
                  //                     )
                  //                   ],
                  //                 ))))
                  //   ],
                  // ),
                  // GestureDetector(
                  //     onTap: () {
                  //       _launchLandingURL();
                  //     },
                  //     child: Container(
                  //         width: 350,
                  //         margin: EdgeInsets.only(
                  //             left: 24, right: 24, top: 15, bottom: 12),
                  //         padding: EdgeInsets.all(10),
                  //         decoration: BoxDecoration(
                  //           border: Border.all(
                  //             color: Colors.red,
                  //             width: 2,
                  //           ),
                  //           borderRadius: BorderRadius.circular(12),
                  //         ),
                  //         child: Column(
                  //           children: [
                  //             Text("Conoce a miBigBro",
                  //                 style: panelTitleStyle),
                  //             Text(
                  //               "Te explicamos cómo funciona el seguro que ofrecemos",
                  //               style: panelStyle,
                  //               textAlign: TextAlign.center,
                  //             )
                  //           ],
                  //         ))),
                  // Container(
                  //   width: 350,
                  //   margin: EdgeInsets.only(
                  //       left: 24, right: 24, top: 0, bottom: 12),
                  //   child: OutlineButton(
                  //       child: new Text(
                  //         "Salir",
                  //         style: TextStyle(color: Colors.red),
                  //       ),
                  //       borderSide: BorderSide(color: Colors.red),
                  //       onPressed: () {
                  //         Navigator.pushNamedAndRemoveUntil(
                  //             context, "login", (r) => false);
                  //       },
                  //       shape: new RoundedRectangleBorder(
                  //           borderRadius: new BorderRadius.circular(10.0))),
                  // )
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget _inicioBody(
    BuildContext context, {
    required Map<String, dynamic> data,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: SpacingValues.m,
        horizontal: SpacingValues.m * 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '¿Qué deseas hacer?',
            style: TextStyle(
              color: Color(0xff464646),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          VerticalSpacing.l,
          Row(
            children: [
              Expanded(
                child: _optionButton(
                  carImagePath: 'assets/img/car1.png',
                  text: 'Solicitar\nSeguro',
                  gradientColors: [
                    Color(0xffE82220),
                    Color(0xffE11C24),
                  ],
                  onTapped: () {
                    if (data["datos_personales"] == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DatosAutomovil()),
                      );
                    } else {
                      Fluttertoast.showToast(
                          msg: "Debe completar tus datos personales",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 7,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 20.0);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DatosPersonales()),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                width: SpacingValues.l,
              ),
              Expanded(
                child: _optionButton(
                  carImagePath: 'assets/img/car2.png',
                  text: 'Renovar Seguro',
                  gradientColors: [
                    Color(0xff1D2766).withOpacity(0.86),
                    Color(0xff1A2461),
                  ],
                  onTapped: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RenovacionMotorizado()),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 28,
          ),
          _extraOptionButton(
            context,
            title: 'Solicitudes',
            subtitle: 'Visualiza tu listado de solicitudes y seguros activos',
            iconData: Icons.flash_on,
            onTapped: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Scaffold(
                          body: Solicitudes(),
                        )),
              );
            },
          ),
          const SizedBox(
            height: 28,
          ),
          _extraOptionButton(
            context,
            title: 'Conoce a miBigbro',
            subtitle: 'Te explicamos como funciona el seguro que ofrecemos',
            iconData: Icons.send,
            onTapped: () {
              _launchLandingURL();
            },
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  Widget _optionButton({
    required String text,
    required VoidCallback onTapped,
    required List<Color> gradientColors,
    required String carImagePath,
  }) {
    return GestureDetector(
      onTap: onTapped,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 28,
              right: 52,
              top: SpacingValues.m * 2,
              bottom: SpacingValues.l * 6,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
              ),
              borderRadius: BorderRadius.circular(SpacingValues.l * 3),
            ),
            child: AutoSizeText(
              text,
              style: TextStyle(
                color: Colors.transparent,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            right: 0.0,
            child: Stack(
              children: [
                Container(
                  height: 100,
                  width: 100,
                ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      child: Image.asset('assets/img/elipse1.png'),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Image.asset('assets/img/elipse2.png'),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 26.0,
            left: 26.0,
            child: Image.asset(carImagePath),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 28,
              right: 52,
              top: SpacingValues.m * 2,
              bottom: SpacingValues.l * 6,
            ),
            child: AutoSizeText(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _extraOptionButton(
    BuildContext context, {
    required VoidCallback onTapped,
    required IconData iconData,
    required String title,
    required String subtitle,
  }) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Color(0xff5C5C5C).withOpacity(0.16),
              offset: Offset(0, 3),
              blurRadius: 15,
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                color: Color(0xffF4F4F4),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Center(
                child: Icon(
                  iconData,
                  size: 32,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            HorizontalSpacing.l,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontWeight: FontWeight.w300, height: 1),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
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
