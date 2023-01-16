import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mibigbro/models/marca_auto.dart';
import 'package:mibigbro/models/modelo_auto.dart';
import 'package:mibigbro/models/motorizadoModel.dart';
import 'package:mibigbro/screens/cotizacion/cotizador.dart';
import 'package:mibigbro/screens/cotizacion/paquetes.dart';
import 'package:mibigbro/rest_api/provider/motorizado_provider.dart';
import 'package:mibigbro/utils/storage.dart';
import 'package:mibigbro/widgets/bigbro_scaffold.dart';
import 'package:mibigbro/widgets/custom_info_dialog.dart';
import 'package:mibigbro/widgets/selector_marca.dart';
import 'package:mibigbro/widgets/selector_modelo.dart';

// Create a Form widget.
class DatosAutomovil extends StatefulWidget {
  @override
  DatosAutomovilState createState() {
    return DatosAutomovilState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class DatosAutomovilState extends State<DatosAutomovil> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKeyDatosMotorizado = GlobalKey<FormState>();
  final TextEditingController _valor = TextEditingController();
  int? _selectedMarca = 0;
  ValueNotifier<ModeloAuto?> _selectedModeloNotifier =
      ValueNotifier<ModeloAuto?>(null);
  final TextEditingController _otroModelo = TextEditingController();
  int? _selectedAno = 0;
  int? _selectedPlaza = 0;
  int? _selectedUso = 0;
  bool otroModeloVisible = false;

  Future<List<DropdownMenuItem<int>>> loadMarcasList() async {
    List<DropdownMenuItem<int>> marcaList = [];
    var response = await MotorizadoProvider.getDatos('/api/marca/list/');
    var marcas = json.decode(utf8.decode(response.bodyBytes));
    var marcasObjeto = <MarcaAuto>[];
    for (final marca in marcas) {
      marcasObjeto.add(MarcaAuto.fromJson(marca));
    }

    marcaList.add(new DropdownMenuItem(
      child: new Text('Selecciona una marca'),
      value: 0,
    ));
    for (final marca in marcas) {
      marcaList.add(
        new DropdownMenuItem(
          child: new Text(marca['nombre_marca']),
          value: marca['id'],
        ),
      );
      //print(marca['nombre_marca']);
    }
    //print("Marcas cargadas");
    return marcaList;
  }

  Future<List<MarcaAuto>> cargarMarcas() async {
    var response = await MotorizadoProvider.getDatos('/api/marca/list/');
    var marcas = json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    final marcasObjeto = <MarcaAuto>[];
    for (final marca in marcas) {
      marcasObjeto.add(MarcaAuto.fromJson(marca));
    }
    return marcasObjeto;
  }

  Future<List<Anio>> loadYearList() async {
    List<Anio> yearList = [];
    var response = await MotorizadoProvider.getDatos('/api/year_auto/list/');
    var years = json.decode(response.body);
    yearList.add(
      Anio(anio: 'Selecciona un año', id: 0),
    );
    for (final year in years) {
      //print(marca['id']);
      var numberYear = year['year'];
      yearList.add(Anio(anio: numberYear.toString(), id: year['id']));
      //print(marca['nombre_marca']);
    }
    //print("Marcas cargadas");
    return yearList;
  }

  Future<List<TipoUso>> loadUsoList() async {
    List<TipoUso> usoList = [];
    var response = await MotorizadoProvider.getDatos('/api/uso_auto/list/');
    var usos = json.decode(utf8.decode(response.bodyBytes));
    usoList.add(
      TipoUso(
        nombreUso: 'Selecciona el tipo de uso',
        id: 0,
      ),
    );
    for (final uso in usos) {
      //print(marca['id']);
      usoList.add(TipoUso(nombreUso: uso['nombre_uso'], id: uso['id']));
      //print(marca['nombre_marca']);
    }
    //print("Marcas cargadas");
    return usoList;
  }

  Future<List<Ciudad>> loadPlazaList() async {
    List<Ciudad> plazaList = [];
    var response = await MotorizadoProvider.getDatos('/api/ciudad/list/');
    var ciudades = json.decode(response.body);
    plazaList.add(Ciudad(
      nombreCiudad: 'Selecciona una ciudad',
      id: 0,
    ));
    for (final ciudad in ciudades) {
      //print(marca['id']);
      plazaList.add(Ciudad(
        nombreCiudad: (ciudad['nombre_ciudad']),
        id: ciudad['id'],
      ));
      //print(marca['nombre_marca']);
    }
    //print("Marcas cargadas");
    return plazaList;
  }

  final titleStyle = TextStyle(fontSize: 15, color: Color(0xff1A2461));

  final dropdownItemTextStyle = TextStyle(fontSize: 15, color: Colors.black);

  var modeloList = <ModeloAuto>[];
  /* void loadModelosList() {
    modeloList = [];
    modeloList.add(new DropdownMenuItem(
      child: new Text('Seleccione un modelo'),
      value: 0,
    ));
    modeloList.add(new DropdownMenuItem(
      child: new Text('Swift'),
      value: 1,
    ));
    modeloList.add(new DropdownMenuItem(
      child: new Text('Aerio'),
      value: 2,
    ));
    modeloList.add(new DropdownMenuItem(
      child: new Text('Alto'),
      value: 3,
    ));
  } */

  @override
  void initState() {
    super.initState();
    //await loadMarcasList();
    //print("iniciar nuemo automovil");
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    //loadMarcasList();

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Valor a asegurar'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'El monto por el que se debe asegurar es el valor comercial de mercado, el cual es el valor que tiene el vehículo al momento de contratar el seguro, este valor es el que te indemnizara la compañía de seguros ante una pérdida total por accidente o pérdida total por robo.',
                  ),
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
            ],
          );
        },
      );
    }

    return BigBroScaffold(
      title: 'Datos del Motorizado',
      subtitle: 'Ingrese los datos de tu motorizado',
      body: Form(
        key: _formKeyDatosMotorizado,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
                padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 4),
                    FutureBuilder(
                      future: cargarMarcas(),
                      builder: (context, snapshotMarcas) {
                        if (snapshotMarcas.hasData) {
                          final marcas =
                              snapshotMarcas.data as List<MarcaAuto>?;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Marca',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              SelectorMarca(
                                ocupacionInicial: _selectedMarca,
                                marcas: marcas,
                                onChanged: (marca) async {
                                  modeloList = [];
                                  _selectedMarca = marca.id;

                                  var response =
                                      await MotorizadoProvider.getDatos(
                                          '/api/marks/${marca.id}/models');

                                  setState(() {
                                    modeloList = [];
                                    _selectedMarca = marca.id;
                                    _selectedModeloNotifier.value = (ModeloAuto(
                                        nombre: 'Selecciona un modelo', id: 0));

                                    var modelos = json.decode(
                                        utf8.decode(response.bodyBytes));

                                    /* modeloList.add(new DropdownMenuItem(
                                          child: new Text('Seleccione un modelo'),
                                          value: 0,
                                        )); */

                                    modeloList.add(ModeloAuto(
                                        nombre: 'Selecciona un modelo', id: 0));

                                    for (final modelo in modelos) {
                                      modeloList
                                          .add(ModeloAuto.fromJson(modelo));
                                    }

                                    // _selectedModelo = modeloList.first;
                                    _selectedModeloNotifier.value = ModeloAuto(
                                        nombre: 'Selecciona un modelo', id: 0);
                                  });
                                },
                              ),
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ValueListenableBuilder<ModeloAuto?>(
                      valueListenable: _selectedModeloNotifier,
                      builder: (BuildContext context, ModeloAuto? modeloAuto,
                          Widget? child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Profesión',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            SelectorModelo(
                              modeloSeleccionado: modeloAuto,
                              modelos: modeloList,
                              onChanged: (marca) async {
                                setState(() {
                                  _selectedModeloNotifier.value = marca;
                                  if (marca.nombre == "Otro") {
                                    otroModeloVisible = true;
                                  } else {
                                    otroModeloVisible = false;
                                  }
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    // DropdownButtonFormField(
                    //   hint: new Text('Modelo de automovil'),
                    //   items: modeloList
                    //       .map((modelo) => DropdownMenuItem(
                    //             value: modelo,
                    //             child: Text(modelo["nombre"]),
                    //           ))
                    //       .toList(),
                    //   value: _selectedModelo,
                    //   validator: (dynamic value) =>
                    //       value == 0 ? 'Elija una modelo' : null,
                    //   onChanged: (dynamic value) {
                    //     setState(() {
                    //       _selectedModelo = value;
                    //       if (value["nombre"] == "Otro") {
                    //         otroModeloVisible = true;
                    //       } else {
                    //         otroModeloVisible = false;
                    //       }
                    //     });
                    //   },
                    //   isExpanded: true,
                    // ),
                    Visibility(
                      visible: otroModeloVisible,
                      child: TextFormField(
                          controller: _otroModelo,
                          decoration: const InputDecoration(
                              labelText: 'Otro modelo',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff1D2766),
                                ),
                              )),
                          validator: (String? value) {
                            if (value!.isEmpty & otroModeloVisible) {
                              return 'Ingrese el modelo';
                            }
                            return null;
                          }),
                    ),
                    FutureBuilder<List<Anio>>(
                        future: loadYearList(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return Container();

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Año del automóvil',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              DropdownButtonFormField(
                                hint: new Text('Año del automóvil'),
                                borderRadius: BorderRadius.circular(16),
                                items: snapshot.data!.map((year) {
                                  return DropdownMenuItem(
                                    child: Center(
                                      child: Text(
                                        year.anio,
                                        style: year.id == 0
                                            ? titleStyle
                                            : dropdownItemTextStyle,
                                      ),
                                    ),
                                    value: year.id,
                                  );
                                }).toList(),
                                selectedItemBuilder: (context) {
                                  return snapshot.data!.map((year) {
                                    return DropdownMenuItem(
                                      child: Text(
                                        year.anio,
                                      ),
                                      value: year.id,
                                    );
                                  }).toList();
                                },
                                value: _selectedAno,
                                validator: (dynamic value) =>
                                    value == 0 ? 'Elija un año' : null,
                                onChanged: (dynamic value) {
                                  setState(() {
                                    _selectedAno = value;
                                  });
                                },
                                isExpanded: true,
                              ),
                            ],
                          );
                        }),
                    FutureBuilder<List<TipoUso>>(
                        future: loadUsoList(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return Container();

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Tipo de uso',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              DropdownButtonFormField(
                                borderRadius: BorderRadius.circular(16),
                                hint: new Text('Uso del automovil'),
                                items: snapshot.data!.map((tipoUso) {
                                  return DropdownMenuItem(
                                    child: Center(
                                      child: Text(
                                        tipoUso.nombreUso,
                                        style: tipoUso.id == 0
                                            ? titleStyle
                                            : dropdownItemTextStyle,
                                      ),
                                    ),
                                    value: tipoUso.id,
                                  );
                                }).toList(),
                                selectedItemBuilder: (context) {
                                  return snapshot.data!.map((tipoUso) {
                                    return DropdownMenuItem(
                                      child: Text(
                                        tipoUso.nombreUso,
                                      ),
                                      value: tipoUso.id,
                                    );
                                  }).toList();
                                },
                                value: _selectedUso,
                                validator: (dynamic value) =>
                                    value == 0 ? 'Elija un uso' : null,
                                onChanged: (dynamic value) {
                                  setState(() {
                                    _selectedUso = value;
                                  });
                                },
                                isExpanded: true,
                              ),
                            ],
                          );
                        }),
                    FutureBuilder<List<Ciudad>>(
                        future: loadPlazaList(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return Container();

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Ciudad',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              DropdownButtonFormField(
                                borderRadius: BorderRadius.circular(16),
                                hint: new Text('Plaza de circulación'),
                                items: snapshot.data!.map((ciudad) {
                                  return DropdownMenuItem(
                                    child: Center(
                                      child: Text(
                                        ciudad.nombreCiudad,
                                        style: ciudad.id == 0
                                            ? titleStyle
                                            : dropdownItemTextStyle,
                                      ),
                                    ),
                                    value: ciudad.id,
                                  );
                                }).toList(),
                                selectedItemBuilder: (context) {
                                  return snapshot.data!.map((ciudad) {
                                    return DropdownMenuItem(
                                      child: Text(
                                        ciudad.nombreCiudad,
                                      ),
                                      value: ciudad.id,
                                    );
                                  }).toList();
                                },
                                value: _selectedPlaza,
                                validator: (dynamic value) =>
                                    value == 0 ? 'Elija una ciudad' : null,
                                onChanged: (dynamic value) {
                                  setState(() {
                                    _selectedPlaza = value;
                                  });
                                },
                                isExpanded: true,
                              ),
                            ],
                          );
                        }),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Valor asegurado (Dólares)',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    TextFormField(
                      controller: _valor,
                      maxLength: 9,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                          labelText: 'Valor asegurado (Dólares)',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff1D2766),
                            ),
                          )),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Ingrese el valor asegurado (Dólares)';
                        } else if (double.parse(value) < 5000) {
                          return 'El valor debe ser mayor a 5.000 USD';
                        } else if (double.parse(value) > 30000) {
                          return 'El valor debe ser menor a 30.000 USD';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text(
                                "Incluye el valor por el que asegurarás tu auto, el cual no puede ser menor a 5.000 USD ni mayor a 30.000 USD",
                                style: TextStyle(
                                    color: Color(0xff1D2766), fontSize: 10))),
                        Expanded(
                            flex: 1,
                            child: SizedBox(
                                width: 30,
                                child: RawMaterialButton(
                                  onPressed: () {
                                    CustomInfoDialog(
                                      context: context,
                                      iconColor: Color(0xffEC1C24),
                                      title: 'Valor a asegurar',
                                      subtitle:
                                          'El monto por el que se debe asegurar es el valor comercial de mercado, el cual es el valor que tiene el vehículo al momento de contratar el seguro, este valor es el qe te indemniza la compañia de seguros ante perdida total por accidente o perdida total por robo',
                                    );
                                  },
                                  elevation: 10.0,
                                  fillColor: Colors.red,
                                  child: Icon(
                                    Icons.info_outline,
                                    size: 20.0,
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(2.0),
                                  shape: CircleBorder(),
                                )))
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (_selectedModeloNotifier.value?.id == 0) {
                              Fluttertoast.showToast(
                                msg: "Debe seleccionar modelo de su vehículo",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 7,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 20.0,
                              );
                              return;
                            }

                            if (_formKeyDatosMotorizado.currentState!
                                    .validate() &&
                                _selectedModeloNotifier.value != null &&
                                _selectedModeloNotifier.value?.id != 0) {
                              final datosMotorizado = motorizadoModel(
                                  marca: _selectedMarca,
                                  modelo:
                                      _selectedModeloNotifier.value?.id ?? 0,
                                  ano: _selectedAno,
                                  uso: _selectedUso,
                                  ciudad: _selectedPlaza,
                                  valor: _valor.text,
                                  camino: "nuevo_seguro",
                                  nroRenovacion: 1,
                                  periodo: "");

                              var respuestaAutomovil =
                                  await MotorizadoProvider.createMotorizado(
                                      double.parse(_valor.text),
                                      StorageUtils.getInteger('id_usuario'),
                                      _selectedUso,
                                      _selectedPlaza,
                                      _selectedModeloNotifier.value?.id ?? 0,
                                      _selectedAno,
                                      _otroModelo.text);

                              Map<String, dynamic>? datosRespuestaAutomovil =
                                  json.decode(respuestaAutomovil.body);
                              print(respuestaAutomovil.body);
                              if (respuestaAutomovil.statusCode == 201) {
                                print(datosRespuestaAutomovil!['id']);
                                datosMotorizado.idUser =
                                    StorageUtils.getInteger('id_usuario');
                                datosMotorizado.idAutomovil =
                                    datosRespuestaAutomovil['id'];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CotizadorTab(
                                          datosMotorizado: datosMotorizado)),
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "No se pudo registrar el automovil",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 7,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 20.0,
                                );
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 24,
                            ),
                            child: Text(
                              "Siguiente",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class Anio {
  const Anio({
    required this.anio,
    required this.id,
  });

  final String anio;
  final int id;
}

class TipoUso {
  const TipoUso({
    required this.nombreUso,
    required this.id,
  });

  final String nombreUso;
  final int id;
}

class Ciudad {
  const Ciudad({
    required this.nombreCiudad,
    required this.id,
  });

  final String nombreCiudad;
  final int id;
}
