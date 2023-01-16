import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mibigbro/utils/storage.dart';
import 'package:mibigbro/widgets/bigbro_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

class Contacto extends StatelessWidget {
  @override
  static const TextStyle texto = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 20.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w600);

  _launchLlamada() async {
    const url = "tel:800103070";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchWhatsapp() async {
    String email = StorageUtils.getString("email");
    String url =
        "https://api.whatsapp.com/send?phone=59176204744&text=Hola%20soy%20miBigbro,%20en%20qu%C3%A9%20te%20puedo%20ayudar?%20%20%20%20%20Hola%20mi%20usuario%20es%20$email.%20Solicito%20ayuda%20con%20la%20aplicaci%C3%B3n%20de%20miBigbro.%20Necesito%20%E2%80%A6..%20%20";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget build(BuildContext context) {
    return BigBroScaffold(
      title: '\nContacto',
      removeTrailingIcon: true,
      subtitle: 'Puedes contactarnos de las siguientes maneras',
      subtitleStyle: TextStyle(
        color: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(50, 0, 50, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _launchLlamada();
                },
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 46,
                          width: double.infinity,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 44, left: 24, right: 24, bottom: 12),
                          decoration: BoxDecoration(
                              color: Color(0xffF4F4F4),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26.withOpacity(0.25),
                                  blurRadius: 3,
                                  spreadRadius: 2,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: Text(
                            'Si necesitas reportar un siniestro puedes comunicarte con miBigbro  a nuestra linea 800 10 30 70',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 88,
                          width: 88,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(3, 3),
                                blurRadius: 3,
                                spreadRadius: 2,
                                color: Colors.black12,
                              )
                            ],
                          ),
                          child: Center(
                            child: SizedBox(
                              height: 46,
                              width: 46,
                              child: Image.asset('assets/img/logo_bigbro.png'),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              GestureDetector(
                onTap: () {
                  _launchWhatsapp();
                },
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 46,
                          width: double.infinity,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 44, left: 24, right: 24, bottom: 12),
                          decoration: BoxDecoration(
                              color: Color(0xffF4F4F4),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26.withOpacity(0.25),
                                  blurRadius: 3,
                                  spreadRadius: 2,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: Text(
                            'Si requieres otro tipo de asistencia puedes comunicarte por mensaje de WhatsApp 69974385',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 88,
                          width: 88,
                          decoration: BoxDecoration(
                            color: Color(0xff4FCE5D),
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(3, 3),
                                blurRadius: 3,
                                spreadRadius: 2,
                                color: Colors.black12,
                              )
                            ],
                          ),
                          child: Center(
                            child: SizedBox(
                                height: 46,
                                width: 46,
                                child: Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.whatsapp,
                                    color: Colors.white,
                                    size: 46,
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
