import 'package:flutter/material.dart';
import 'package:mibigbro/models/motorizadoModel.dart';
import 'package:mibigbro/screens/cotizacion/paquetes.dart';
import 'package:mibigbro/screens/cotizacion/precio_medida.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mibigbro/screens/home/home.dart';
import 'package:mibigbro/widgets/bigbro_scaffold.dart';
import 'dias_media.dart';

class CotizadorTab extends StatelessWidget {
  final motorizadoModel? datosMotorizado;
  final bool esRenovacion;

  CotizadorTab({
    this.datosMotorizado,
    this.esRenovacion = false,
  });

  @override
  Widget build(BuildContext context) {
    return BigBroScaffold(
      title: 'Personaliza tu seguro',
      centerWidget: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/img/planes_seguro.png'),
            Text(
              'Planes de Seguro',
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: Paquetes(
        datosMotorizado: datosMotorizado,
        esRenovacion: esRenovacion,
      ),
    );
  }
}
