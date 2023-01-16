import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mibigbro/models/poliza_model.dart';
import 'package:mibigbro/rest_api/provider/poliza_provider.dart';
import 'package:mibigbro/utils/storage.dart';
import 'package:mibigbro/widgets/bigbro_scaffold.dart';

class EstadoSolicitud {
  const EstadoSolicitud({
    required this.estado,
    required this.value,
    required this.color,
  });

  final String estado;
  final String value;
  final Color color;
}

class PolizaConEstado {
  const PolizaConEstado({
    required this.poliza,
    required this.estado,
  });

  final PolizaModel poliza;
  final TipoEstado estado;
}

class Solicitudes extends StatelessWidget {
  Solicitudes({Key? key}) : super(key: key);

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

  final estados = [
    EstadoSolicitud(
      estado: 'Todos',
      value: '0',
      color: Color(0xff9ED1FF),
    ),
    EstadoSolicitud(
      estado: 'En seguimiento',
      value: '1',
      color: Color(0xffF5D509),
    ),
    EstadoSolicitud(
      estado: 'Revisión',
      value: '2',
      color: Color(0xffEC1C24),
    ),
    EstadoSolicitud(
      estado: 'Aprobado',
      value: '3',
      color: Color(0xff1CF509),
    ),
  ];

  ValueNotifier<EstadoSolicitud?> estadoSeleccionadoNotifier =
      ValueNotifier<EstadoSolicitud?>(null);

  List<PolizaConEstado> todasLasPolizas = [];
  List<PolizaConEstado> polizasEnSeguimiento = [];
  List<PolizaConEstado> polizasEnRevision = [];
  List<PolizaConEstado> polizasAprobadas = [];

  ValueNotifier<List<PolizaConEstado>?> polizasAMostrar =
      ValueNotifier<List<PolizaConEstado>?>(null);

  @override
  Widget build(BuildContext context) {
    return BigBroScaffold(
      title: 'Solicitudes',
      subtitle: 'Seguimientos de mis solicitudes',
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 18,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.05),
                    blurRadius: 5,
                    spreadRadius: 3,
                    offset: Offset(3, 3),
                  )
                ],
              ),
              child: ValueListenableBuilder<EstadoSolicitud?>(
                valueListenable: estadoSeleccionadoNotifier,
                builder: (BuildContext context,
                    EstadoSolicitud? estadoSeleccionado, Widget? child) {
                  return DropdownButton<EstadoSolicitud>(
                    borderRadius: BorderRadius.circular(16),
                    isExpanded: true,
                    underline: Container(),
                    icon: Transform.rotate(
                      angle: pi * 1.5,
                      child: Icon(Icons.chevron_left),
                    ),
                    onChanged: (value) {
                      estadoSeleccionadoNotifier.value = value;

                      if (value!.value == '0') {
                        polizasAMostrar.value = todasLasPolizas;
                        return;
                      }

                      if (value.value == '1') {
                        polizasAMostrar.value = polizasEnSeguimiento;
                        return;
                      }

                      if (value.value == '2') {
                        polizasAMostrar.value = polizasEnRevision;
                        return;
                      }

                      if (value.value == '3') {
                        polizasAMostrar.value = polizasAprobadas;
                        return;
                      }
                    },
                    value: estadoSeleccionado ?? estados.first,
                    items:
                        estados.map<DropdownMenuItem<EstadoSolicitud>>((item) {
                      return DropdownMenuItem<EstadoSolicitud>(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: item.color,
                              radius: 8,
                            ),
                            const SizedBox(
                              width: 44,
                            ),
                            Text(
                              item.estado,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                        value: item,
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            FutureBuilder<List<PolizaConEstado>>(
              future: inicializarPolizas(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final polizas = snapshot.data!;

                  return Expanded(
                      child: ValueListenableBuilder<List<PolizaConEstado>?>(
                    valueListenable: polizasAMostrar,
                    builder: (context, value, child) {
                      return ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          final poliza = (value ?? polizas)[index];

                          return _SolicitudCard(
                            tipoEstado: poliza.estado,
                            polizaModel: poliza.poliza,
                            showTopLine: index == 0 ? false : true,
                            showBottomLine:
                                index == polizas.length - 1 ? false : true,
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 115,
                                                    width: 115,
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade200,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          16,
                                                        ),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                            poliza.poliza
                                                                .fotoFrontal,
                                                          ),
                                                          fit: BoxFit.cover,
                                                        )),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Marca:",
                                                            style: labelText,
                                                          ),
                                                          Text(
                                                            poliza.poliza.marca,
                                                            style: infoText,
                                                          ),
                                                          Text(
                                                            "Placa:",
                                                            style: labelText,
                                                          ),
                                                          Text(
                                                            poliza.poliza.placa,
                                                            style: infoText,
                                                          ),
                                                          Text(
                                                            "Circulación:",
                                                            style: labelText,
                                                          ),
                                                          Text(
                                                            poliza
                                                                .poliza.ciudad,
                                                            style: infoText,
                                                          ),
                                                          const SizedBox(
                                                              height: 12),
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
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: labelText,
                                                    ),
                                                  ),
                                                  Spacer(flex: 1),
                                                  Expanded(
                                                    flex: 10,
                                                    child: Text(
                                                      poliza.poliza.aseguradora,
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
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: labelText,
                                                    ),
                                                  ),
                                                  Spacer(flex: 1),
                                                  Expanded(
                                                    flex: 10,
                                                    child: Text(
                                                      poliza.poliza
                                                          .vigenciaInicio,
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
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: labelText,
                                                    ),
                                                  ),
                                                  Spacer(flex: 1),
                                                  Expanded(
                                                    flex: 10,
                                                    child: Text(
                                                      poliza
                                                          .poliza.vigenciaFinal,
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
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: labelText,
                                                    ),
                                                  ),
                                                  Spacer(flex: 1),
                                                  Expanded(
                                                    flex: 10,
                                                    child: Text(
                                                      poliza.poliza.prima
                                                              .toString() +
                                                          " USD",
                                                      style: infoText,
                                                    ),
                                                  )
                                                ],
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
                                    );
                                  });
                            },
                          );
                        },
                        itemCount: (value ?? polizas).length,
                      );
                    },
                  ));
                }

                return CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }

  Future<List<PolizaModel>> traerTodasLasPolizas() async {
    int idUsuario = StorageUtils.getInteger('id_usuario');

    final response = await PolizaProvider.traerTodasLasPolizasPorIdUser(
        idUsuario.toString());

    return polizaModelFromJson(response.body);
  }

  Future<List<PolizaConEstado>> inicializarPolizas() async {
    int idUsuario = StorageUtils.getInteger('id_usuario');

    final responseEnSeguimiento = await PolizaProvider.polizasPorEstado(
        idUsuario.toString(), 'PENDIENTE');
    final responseRevision =
        await PolizaProvider.polizasPorEstado(idUsuario.toString(), 'REVISADO');
    final responseAprobado =
        await PolizaProvider.polizasPorEstado(idUsuario.toString(), 'APROBADO');

    polizasEnSeguimiento = polizaModelFromJson(responseEnSeguimiento.body)
        .map((item) => PolizaConEstado(
              poliza: item,
              estado: TipoEstado.enSeguimiento,
            ))
        .toList();
    polizasEnRevision = polizaModelFromJson(responseRevision.body)
        .map((item) => PolizaConEstado(
              poliza: item,
              estado: TipoEstado.enRevision,
            ))
        .toList();
    polizasAprobadas = polizaModelFromJson(responseAprobado.body)
        .map((item) => PolizaConEstado(
              poliza: item,
              estado: TipoEstado.aprobado,
            ))
        .toList();

    todasLasPolizas.addAll(polizasEnSeguimiento);
    todasLasPolizas.addAll(polizasEnRevision);
    todasLasPolizas.addAll(polizasAprobadas);

    todasLasPolizas.sort(
      (a, b) => DateTime.parse(a.poliza.vigenciaInicio).compareTo(
        DateTime.parse(b.poliza.vigenciaInicio),
      ),
    );

    return todasLasPolizas;
  }
}

class _SolicitudCard extends StatefulWidget {
  _SolicitudCard({
    required this.showTopLine,
    required this.showBottomLine,
    required this.polizaModel,
    required this.tipoEstado,
    required this.onTap,
  }) {
    if (tipoEstado == TipoEstado.aprobado) {
      alturaCard = 210;
    } else if (tipoEstado == TipoEstado.enRevision) {
      alturaCard = 120;
    } else if (tipoEstado == TipoEstado.enSeguimiento) {
      alturaCard = 120;
    }
  }

  final bool showTopLine;
  final bool showBottomLine;
  final PolizaModel polizaModel;
  final TipoEstado tipoEstado;
  final VoidCallback onTap;

  late double alturaCard;

  @override
  State<_SolicitudCard> createState() => _SolicitudCardState();
}

class _SolicitudCardState extends State<_SolicitudCard> {
  final meses = [
    'Ene',
    'Feb',
    'Mar',
    'Abr',
    'May',
    'Jun',
    'Jul',
    'Ago',
    'Sep',
    'Oct',
    'Nov',
    'Dic',
  ];

  late String dia;
  late int mes;

  @override
  void initState() {
    super.initState();
    final fecha = DateTime.parse(widget.polizaModel.vigenciaInicio!);

    dia = fecha.day < 10 ? '0${fecha.day}' : fecha.day.toString();
    mes = fecha.month - 1;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        height: widget.alturaCard,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    width: 1,
                    color: widget.showTopLine
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 13.5,
                    ),
                    child: Column(
                      children: [
                        Text(
                          dia,
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xff464646),
                          ),
                        ),
                        Text(
                          meses[mes],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    )),
                Expanded(
                  child: Container(
                    width: 1,
                    color: widget.showBottomLine
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 28,
            ),
            Expanded(
              child: Container(
                height: widget.alturaCard - 30,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xffF2F2F2),
                    borderRadius: BorderRadius.circular(16)),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Solicitud Realizada',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              widget.tipoEstado == TipoEstado.enSeguimiento
                                  ? Color(0xffF5D509)
                                  : widget.tipoEstado == TipoEstado.enRevision
                                      ? Color(0xffEC1C24)
                                      : Color(0xff1CF509),
                          radius: 8,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.tipoEstado == TipoEstado.aprobado
                                ? Text(
                                    'Tu solicitud ha sido aprobada',
                                  )
                                : const SizedBox(),
                            Text(
                              'Ver Estado',
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum TipoEstado {
  enSeguimiento,
  enRevision,
  aprobado,
}
