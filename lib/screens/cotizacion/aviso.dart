import 'package:flutter/material.dart';
import 'package:mibigbro/models/motorizadoModel.dart';
import 'package:mibigbro/screens/cotizacion/firmar.dart';
import 'package:mibigbro/screens/cotizacion/inspeccion/datos_imagen_frontal_trasera.dart';
import 'package:mibigbro/screens/cotizacion/inspeccion/pantalla1.dart';
import 'package:mibigbro/screens/cotizacion/resumen.dart';
import 'package:mibigbro/utils/storage.dart';
import 'package:mibigbro/widgets/bigbro_scaffold.dart';

class Aviso extends StatefulWidget {
  final motorizadoModel? datosMotorizado;
  final bool esRenovacion;
  Aviso({
    this.datosMotorizado,
    this.esRenovacion = false,
  });

  static const TextStyle titleStyle = TextStyle(
    color: Color(0xff1D2766),
    fontSize: 30,
    fontFamily: 'Manrope',
    fontWeight: FontWeight.normal,
  );
  static const TextStyle infoStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w300);
  static const TextStyle infoPrecioStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);

  @override
  _AvisoState createState() => _AvisoState();
}

class _AvisoState extends State<Aviso> {
  final appTitle = 'Aviso';
  int idUsuario = StorageUtils.getInteger('id_usuario');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textoAviso =
        "Para continuar con la adquisición del seguro usted debe realizar la auto inspección del vehículo desde la misma aplicación. Posteriormente realizará el pago digital a través de la misma app";
    if (widget.datosMotorizado!.camino == "vigente_1_dias" ||
        widget.datosMotorizado!.camino == "vencida_30_dias" ||
        widget.datosMotorizado!.camino == "vencida") {
      textoAviso =
          "Si usted esta renovando su póliza pasada las 24 horas de vencimiento debe actualizar las fotos de inspeccion.";
    }
    return BigBroScaffold(
      title: appTitle,
      enableInfoOverlay: true,
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Antes de continuar",
                    style: Aviso.titleStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Toma en cuenta lo siguiente:",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 4,
                          right: 16,
                        ),
                        child: Icon(
                          Icons.circle,
                          size: 6,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Para continuar con la adquisición del seguro usted deberá realizar la auto inspección del vehículo desde la misma aplicación.',
                          style: Aviso.infoStyle,
                          textAlign: TextAlign.justify,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 32),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 4,
                          right: 16,
                        ),
                        child: Icon(
                          Icons.circle,
                          size: 6,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Posteriormente una vez se realice la aprobación de su solicitud deberá realizar el pago digital mediante la misma aplicación.',
                          style: Aviso.infoStyle,
                          textAlign: TextAlign.justify,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 32),
                  if (widget.datosMotorizado!.camino == "nuevo_seguro")
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 4,
                            right: 16,
                          ),
                          child: Icon(
                            Icons.circle,
                            size: 6,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Si es la primera vez que se asegura su vehículo toma en cuenta que debes tener a mano el documento CRPVA (RUAT) del vehículo para la toma de la fotografia por medio de la aplicación.',
                            style: Aviso.infoStyle,
                            textAlign: TextAlign.justify,
                          ),
                        )
                      ],
                    ),
                  SizedBox(height: 32),
                  SizedBox(height: 10),
                  if (StorageUtils.getString('email') != "usertest@email.com")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            print(widget.datosMotorizado!.camino);
                            if (widget.datosMotorizado!.camino ==
                                "nuevo_seguro") {
                              if (widget.esRenovacion) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DatosImagenFrontalTrasera(
                                      datosMotorizado: widget.datosMotorizado!,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InspeccionPantalla1(
                                          datosMotorizado:
                                              widget.datosMotorizado)),
                                );
                                return;
                              }
                            } else if (widget.datosMotorizado!.camino ==
                                "vencida_1_dia") {
                              widget.datosMotorizado!.idCompania = 1;
                              /* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Declaracion(
                                    datosMotorizado: datosMotorizado)),
                          ); */
                              if (widget.datosMotorizado!.camino ==
                                  "nuevo_seguro") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FirmaPoliza(
                                      datosMotorizado: widget.datosMotorizado,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResumenSeguro(
                                      datosMotorizado: widget.datosMotorizado,
                                    ),
                                  ),
                                );
                              }
                              // Navigator.push(
                              // context,
                              // MaterialPageRoute(
                              // builder: (context) => Aseguradoras(
                              // datosMotorizado: widget.datosMotorizado),
                              // ),
                              // );
                            } else if (widget.datosMotorizado!.camino ==
                                "vencida_30_dias") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DatosImagenFrontalTrasera(
                                            datosMotorizado:
                                                widget.datosMotorizado!)),
                              );
                            } else {
                              if (widget.esRenovacion) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DatosImagenFrontalTrasera(
                                      datosMotorizado: widget.datosMotorizado!,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InspeccionPantalla1(
                                          datosMotorizado:
                                              widget.datosMotorizado)),
                                );
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            child: Text(
                              "Continuar",
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                ],
              ))),
    );
  }
}
