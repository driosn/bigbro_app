import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mibigbro/models/profesion.dart';
import 'package:mibigbro/utils/dialog.dart';
import 'package:mibigbro/utils/key.dart' as llavero;
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:mibigbro/models/datosPersonalesModel.dart';
import 'package:mibigbro/rest_api/provider/datos_personales_provider.dart';
import 'package:mibigbro/rest_api/provider/motorizado_provider.dart';
import 'package:mibigbro/screens/perfil/datos_personales2.dart';
import 'package:mibigbro/utils/storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:convert' show utf8;

import 'package:mibigbro/widgets/selector_profesion.dart';

// Create a Form widget.
class DatosPersonales extends StatefulWidget {
  DatosPersonales({
    this.mostrarRegistroExitoso = false,
  });

  final bool mostrarRegistroExitoso;

  @override
  DatosPersonalesState createState() {
    return DatosPersonalesState();
  }
}

class _RegistroExitosoBottomSheet extends StatelessWidget {
  const _RegistroExitosoBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 24,
            ),
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).accentColor,
                  size: 30,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 46,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    height: 120,
                    width: 120,
                    child: Image.asset('assets/img/circlecheck.png'),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Text(
                    '¡Registro Exitoso!',
                    style: TextStyle(
                      color: Color(0xff1D2766),
                      fontSize: 34,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Ahora completa tus datos personales para empezar a utilizar la aplicación',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff1D2766),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Create a corresponding State class. This class holds data related to the form.
class DatosPersonalesState extends State<DatosPersonales> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      initializeDateFormatting();
      if (widget.mostrarRegistroExitoso) {
        _scaffoldKey.currentState?.showBottomSheet(
          (context) => _RegistroExitosoBottomSheet(),
        );
      }
    });
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  DateFormat? dateFormat;
  String _BASEURL = llavero.Key.BASEURL;
  final _formKey = GlobalKey<FormState>();
  File? _imageUser;
  final picker = ImagePicker();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _apellidoPaterno = TextEditingController();
  final TextEditingController _apellidoMaterno = TextEditingController();
  final TextEditingController _nacionalidad = TextEditingController();
  DateTime? _fechaNacimiento;
  final TextEditingController _celular = TextEditingController();
  final TextEditingController _actividad = TextEditingController();

  String? _tipoDocumento = "CI";
  int? _ciudad = 0;
  int? _pais = 0;
  String? _genero = "NN";
  String? _estadoCivil = "NN";
  String? fotoUsuario;
  String? _extDocumento = "NN";
  int? _ocupacion = 0;

  final TextEditingController _nroDocumento = TextEditingController();
  //final TextEditingController _extDocumento = TextEditingController();
  final TextEditingController _email = TextEditingController();

  final TextEditingController _direccion = TextEditingController();
  //Id para actualizar datos personales
  int? idDatosPersonales = 0;
  //
  bool nuevoDatosPersonales = true;
  Future cargarDatosPersonales() async {
    int idUsuario = StorageUtils.getInteger('id_usuario');
    _email.text = StorageUtils.getString('email');
    var respuestaDatosPersonales =
        await DatosPersonalesProvider.buscar(idUsuario.toString());
    if (respuestaDatosPersonales.statusCode == 200) {
      nuevoDatosPersonales = false;
      var datosPersonalesGuardados =
          json.decode(utf8.decode(respuestaDatosPersonales.bodyBytes));
      print(datosPersonalesGuardados);
      idDatosPersonales = datosPersonalesGuardados["id"];
      print(datosPersonalesGuardados["nombre"]);
      _nombre.text = datosPersonalesGuardados["nombre"];
      _apellidoPaterno.text = datosPersonalesGuardados["apellido_paterno"];

      _apellidoMaterno.text = datosPersonalesGuardados["apellido_materno"];
      _tipoDocumento = datosPersonalesGuardados["tipo_documento"];
      _nroDocumento.text = datosPersonalesGuardados["numero_documento"];
      _extDocumento = datosPersonalesGuardados["extension"];
      _actividad.text = datosPersonalesGuardados["actividad"];
      _ocupacion = datosPersonalesGuardados["profesion"];

      fotoUsuario = (datosPersonalesGuardados["imagen"] != null)
          ? _BASEURL + datosPersonalesGuardados["imagen"]
          : null;

      print("foto usuario url");
      print(fotoUsuario);
      //fechaNacimientoDato
      String textoFN = datosPersonalesGuardados["fecha_nacimiento"];

      var listaFN = textoFN.split("-");
      _fechaNacimiento = DateTime(
          int.parse(listaFN[0]), int.parse(listaFN[1]), int.parse(listaFN[2]));

      _genero = datosPersonalesGuardados["genero"];
      _estadoCivil = datosPersonalesGuardados["estado_civil"];
      _celular.text = datosPersonalesGuardados["nro_celular"];
      _direccion.text = datosPersonalesGuardados["direccion_domicilio"];
      _pais = datosPersonalesGuardados["pais_residencia"];
      _nacionalidad.text = datosPersonalesGuardados["nacionalidad"];
      _ciudad = datosPersonalesGuardados["ciudad"];
    }

    return respuestaDatosPersonales;
  }

  Future<List<DropdownMenuItem<int>>> loadCiudadList() async {
    List<DropdownMenuItem<int>> plazaList = [];
    var response = await MotorizadoProvider.getDatos('/api/ciudad/list/');
    var ciudades = json.decode(utf8.decode(response.bodyBytes));

    plazaList.add(new DropdownMenuItem(
      child: new Text('Selecciona una ciudad'),
      value: 0,
    ));
    for (final ciudad in ciudades) {
      //print(marca['id']);
      plazaList.add(new DropdownMenuItem(
        child: new Text(ciudad['nombre_ciudad']),
        value: ciudad['id'],
      ));
      //print(marca['nombre_marca']);
    }
    //print("Marcas cargadas");
    return plazaList;
  }

  Future<List<DropdownMenuItem<int>>> loadOcupacionList() async {
    List<DropdownMenuItem<int>> plazaList = [];
    var response = await MotorizadoProvider.getDatos('/api/profesion/list/');
    var profesiones = json.decode(utf8.decode(response.bodyBytes));

    plazaList.add(new DropdownMenuItem(
      child: new Text('Selecciona una ocupación'),
      value: 0,
    ));
    for (final profesion in profesiones) {
      //print(marca['id']);
      plazaList.add(new DropdownMenuItem(
        child: new Text(profesion['nombre_profesion']),
        value: profesion['id_alianza'],
      ));
      //print(marca['nombre_marca']);
    }
    //print("Marcas cargadas");
    return plazaList;
  }

  Future<List<Profesion>> cargarOcupaciones() async {
    var response = await MotorizadoProvider.getDatos('/api/profesion/list/');
    var profesiones =
        json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    return List.from(profesiones
        .map((profesionJson) => Profesion.fromJson(profesionJson))
        .toList());
  }

  Future<List<DropdownMenuItem<int>>> loadPaisList() async {
    List<DropdownMenuItem<int>> paisList = [];
    var response = await MotorizadoProvider.getDatos('/api/pais/list/');
    var paises = json.decode(utf8.decode(response.bodyBytes));

    paisList.add(new DropdownMenuItem(
      child: new Text('Selecciona un país'),
      value: 0,
    ));
    for (final pais in paises) {
      //print(marca['id']);

      paisList.add(new DropdownMenuItem(
        child: new Text(pais['nombre_pais']),
        value: pais['id'],
      ));
      //print(marca['nombre_marca']);
    }
    //print("Marcas cargadas");
    return paisList;
  }

  Future getImageUser() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 20,
        preferredCameraDevice: CameraDevice.front);

    setState(() {
      if (pickedFile != null) {
        _imageUser = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  List<DropdownMenuItem<String>> get generoItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Género"), value: "NN"),
      DropdownMenuItem(child: Text("MASCULINO"), value: "M"),
      DropdownMenuItem(child: Text("FEMENINO"), value: "F")
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get extItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Elija una extensión"), value: "NN"),
      DropdownMenuItem(child: Text("La Paz"), value: "LP"),
      DropdownMenuItem(child: Text("Chuquisaca"), value: "CH"),
      DropdownMenuItem(child: Text("Cochabamba"), value: "CB"),
      DropdownMenuItem(child: Text("Oruro"), value: "OR"),
      DropdownMenuItem(child: Text("Potosí"), value: "PO"),
      DropdownMenuItem(child: Text("Tarija"), value: "TJ"),
      DropdownMenuItem(child: Text("Santa Cruz"), value: "SC"),
      DropdownMenuItem(child: Text("Beni"), value: "BE"),
      DropdownMenuItem(child: Text("Pando"), value: "PA"),
      DropdownMenuItem(child: Text("Extranjeros con C.I."), value: "EX"),
      DropdownMenuItem(child: Text("Extranjeros con Pasaporte"), value: "PS")
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get estadocivilItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Estado civil"), value: "NN"),
      DropdownMenuItem(child: Text("SOLTERO"), value: "1"),
      DropdownMenuItem(child: Text("CASADO"), value: "2"),
      DropdownMenuItem(child: Text("VIUDO"), value: "3"),
      DropdownMenuItem(child: Text("DIVORCIADO"), value: "4")
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return Scaffold(
      key: _scaffoldKey,
      body: FutureBuilder(
          future: cargarDatosPersonales(),
          builder: (context, snapshot) {
            //var datosPaquete = json.decode(respuestaPaquetes.body);
            String languageCode = Localizations.localeOf(context).languageCode;
            print("lenguje");
            print(languageCode);
            dateFormat = DateFormat.yMd('es');
            if (snapshot.hasData) {
              return Scaffold(
                  // appBar: AppBar(
                  //   iconTheme: IconThemeData(
                  //     color: Color(0xff1D2766), //change your color here
                  //   ),
                  //   centerTitle: true,
                  //   backgroundColor: Colors.white,
                  //   title: Text(
                  //     "Datos personales",
                  //     style: TextStyle(
                  //       color: Color(0xff1D2766),
                  //     ),
                  //   ),
                  // ),
                  body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Actualizar mi perfil",
                                style: TextStyle(color: Color(0xff1D2766))),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  getImageUser();
                                },
                                child: CircleAvatar(
                                  backgroundImage: _imageUser == null
                                      ? (fotoUsuario == null
                                              ? AssetImage(
                                                  'assets/img/user_icon.png')
                                              : NetworkImage(fotoUsuario!))
                                          as ImageProvider<Object>?
                                      : FileImage(_imageUser!),
                                  radius: 50,
                                ),
                              ),
                            ),
                            TextFormField(
                                controller: _nombre,
                                decoration: const InputDecoration(
                                    labelText: 'Nombre',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff1D2766),
                                      ),
                                    )),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Ingrese sus nombres';
                                  }
                                  return null;
                                }),
                            TextFormField(
                                controller: _apellidoPaterno,
                                decoration: const InputDecoration(
                                    labelText: 'Apellido paterno',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff1D2766),
                                      ),
                                    )),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Ingrese su apellido paterno';
                                  }
                                  return null;
                                }),
                            TextFormField(
                                controller: _apellidoMaterno,
                                decoration: const InputDecoration(
                                    labelText: 'Apellido materno',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff1D2766),
                                      ),
                                    )),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Ingrese su apellido materno';
                                  }
                                  return null;
                                }),
                            TextFormField(
                                controller: _celular,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: const InputDecoration(
                                    labelText: 'Número de celular',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff1D2766),
                                      ),
                                    )),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Ingrese número de celular';
                                  }
                                  return null;
                                }),
                            DateTimeFormField(
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.black45),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                suffixIcon: Icon(Icons.event_note),
                                labelText: 'Fecha de nacimiento',
                              ),
                              mode: DateTimeFieldPickerMode.date,
                              initialValue: _fechaNacimiento,
                              validator: ((DateTime? date) {
                                int yearDiff = 0;
                                if (date != null) {
                                  DateTime today = DateTime.now();
                                  yearDiff = today.year - date.year;
                                }

                                if (yearDiff < 18) {
                                  return 'Debe tener más de 18 años';
                                } else if (yearDiff > 75) {
                                  return 'Debe tener un maximo de 75 años';
                                } else if (date == null) {
                                  return 'Ingrese la fecha de nacimiento';
                                }
                                return null;
                              }),
                              onDateSelected: (DateTime date) {
                                //setState(() {
                                print(date);
                                _fechaNacimiento = date;
                                //});
                              },
                              dateFormat: dateFormat,
                              //lastDate: DateTime(2002),
                            ),
                            DropdownButtonFormField(
                              hint: new Text('Género'),
                              items: generoItems,
                              value: _genero,
                              validator: (dynamic value) =>
                                  value == "NN" ? "NN" : null,
                              onChanged: (dynamic value) {
                                _genero = value;
                              },
                              isExpanded: true,
                            ),
                            DropdownButtonFormField(
                              hint: new Text('Estado civil'),
                              items: estadocivilItems,
                              value: _estadoCivil,
                              validator: (dynamic value) =>
                                  value == "NN" ? 'NN' : null,
                              onChanged: (dynamic value) {
                                _estadoCivil = value;
                              },
                              isExpanded: true,
                            ),
                            DropdownButtonFormField(
                              hint: new Text('Tipo de documento'),
                              items: ["CI", "PASAPORTE", "LICENCIA", "OTRO"]
                                  .map((label) => DropdownMenuItem(
                                        child: Text(label == 'CI'
                                            ? 'Cédula de Identidad'
                                            : label.toString()),
                                        value: label,
                                      ))
                                  .toList(),
                              value: _tipoDocumento,
                              validator: (dynamic value) =>
                                  value == null ? 'CI' : null,
                              onChanged: (dynamic value) {
                                _tipoDocumento = value;
                              },
                              isExpanded: true,
                            ),
                            TextFormField(
                                controller: _nroDocumento,
                                decoration: const InputDecoration(
                                    labelText: 'Número de documento:',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff1D2766),
                                      ),
                                    )),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Ingrese el número de documento';
                                  }
                                  return null;
                                }),
                            //extItems
                            DropdownButtonFormField(
                              hint: new Text('Extensión'),
                              items: extItems,
                              value: _extDocumento,
                              validator: (dynamic value) =>
                                  value == null ? 'NN' : null,
                              onChanged: (dynamic value) {
                                _extDocumento = value;
                              },
                              isExpanded: true,
                            ),
                            TextFormField(
                                controller: _email,
                                decoration: const InputDecoration(
                                    labelText: 'Correo electrónico',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff1D2766),
                                      ),
                                    )),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Ingrese su correo';
                                  }
                                  return null;
                                }),
                            FutureBuilder<List<DropdownMenuItem<int>>>(
                                future: loadPaisList(),
                                builder: (context, snapshotPais) {
                                  return DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                      hintStyle:
                                          TextStyle(color: Colors.black45),
                                      errorStyle:
                                          TextStyle(color: Colors.redAccent),
                                      labelText: 'Pais de residencia',
                                    ),
                                    hint: new Text('Pais de residencia'),
                                    items: snapshotPais.data,
                                    value: _pais,
                                    validator: (dynamic value) =>
                                        value == 0 ? 'Elija un país' : null,
                                    onChanged: (dynamic value) {
                                      _pais = value;
                                    },
                                    isExpanded: true,
                                  );
                                }),
                            TextFormField(
                                controller: _nacionalidad,
                                decoration: const InputDecoration(
                                    labelText: 'Nacionalidad',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff1D2766),
                                      ),
                                    )),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Ingrese su nacionalidad';
                                  }
                                  return null;
                                }),
                            FutureBuilder<List<DropdownMenuItem<int>>>(
                                future: loadCiudadList(),
                                builder: (context, snapshotCiudad) {
                                  return DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                      hintStyle:
                                          TextStyle(color: Colors.black45),
                                      errorStyle:
                                          TextStyle(color: Colors.redAccent),
                                      labelText: 'Ciudad de residencia',
                                    ),
                                    hint: new Text('Ciudad de residencia'),
                                    items: snapshotCiudad.data,
                                    value: _ciudad,
                                    validator: (dynamic value) =>
                                        value == 0 ? 'Elija una ciudad' : null,
                                    onChanged: (dynamic value) {
                                      _ciudad = value;
                                    },
                                    isExpanded: true,
                                  );
                                }),
                            TextFormField(
                                controller: _direccion,
                                decoration: const InputDecoration(
                                  labelText: 'Dirección',
                                ),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Ingrese su dirección';
                                  }
                                  return null;
                                }),
                            const SizedBox(
                              height: 4,
                            ),
                            Align(
                              child: Text('Profesión'),
                              alignment: Alignment.centerLeft,
                            ),
                            FutureBuilder(
                              future: cargarOcupaciones(),
                              builder: (context, snapshotProfesiones) {
                                if (snapshot.hasData) {
                                  final profesiones = snapshotProfesiones.data
                                      as List<Profesion>?;

                                  return SelectorProfesion(
                                    ocupacionInicial: _ocupacion,
                                    profesiones: profesiones,
                                    onChanged: (profesion) {
                                      _ocupacion = profesion.idAlianza;
                                    },
                                  );
                                }
                                return Container();
                              },
                            ),
                            TextFormField(
                                controller: _actividad,
                                decoration: const InputDecoration(
                                    labelText: 'Actividad comercial:',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff1D2766),
                                      ),
                                    )),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Ingrese su actividad';
                                  }
                                  return null;
                                }),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  // color: Color(0xff1D2766),
                                  // textColor: Colors.white,
                                  // disabledColor: Colors.grey,
                                  // disabledTextColor: Colors.black,
                                  // padding: EdgeInsets.all(8.0),
                                  // splashColor: Colors.blueAccent,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      DialogoProgreso dialog =
                                          DialogoProgreso(context, "Guardando");
                                      dialog.mostrarDialogo();
                                      String fechaNacimientoDato =
                                          _fechaNacimiento
                                              .toString()
                                              .substring(0, 10);

                                      if (_ocupacion == 0) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Text(
                                                  'Es necesario que elija una ocupación'),
                                              actions: [
                                                TextButton(
                                                  child: Text('Aceptar'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                )
                                              ],
                                            );
                                          },
                                        );
                                        return;
                                      }

                                      if (nuevoDatosPersonales) {
                                        var respuestaDatosPersonalesCreate =
                                            await DatosPersonalesProvider
                                                .create(
                                                    _nombre.text,
                                                    _apellidoPaterno.text,
                                                    _apellidoMaterno.text,
                                                    _tipoDocumento,
                                                    _nroDocumento.text,
                                                    _extDocumento,
                                                    fechaNacimientoDato,
                                                    _genero,
                                                    _estadoCivil,
                                                    _celular.text,
                                                    _direccion.text,
                                                    _ocupacion,
                                                    _actividad.text,
                                                    StorageUtils.getInteger(
                                                        'id_usuario'),
                                                    _pais,
                                                    _ciudad,
                                                    _nacionalidad.text);
                                        var datosPersonalesCreated =
                                            json.decode(
                                                respuestaDatosPersonalesCreate
                                                    .body);

                                        idDatosPersonales =
                                            StorageUtils.getInteger(
                                                'id_usuario');

                                        print(datosPersonalesCreated);
                                        print("nuevo");
                                      } else {
                                        var respuestaDatosPersonalesUpdate =
                                            await DatosPersonalesProvider
                                                .update(
                                                    _nombre.text,
                                                    _apellidoPaterno.text,
                                                    _apellidoMaterno.text,
                                                    _tipoDocumento,
                                                    _nroDocumento.text,
                                                    _extDocumento,
                                                    fechaNacimientoDato,
                                                    _genero,
                                                    _estadoCivil,
                                                    _celular.text,
                                                    _direccion.text,
                                                    _ocupacion,
                                                    _actividad.text,
                                                    StorageUtils.getInteger(
                                                        'id_usuario'),
                                                    _pais,
                                                    _ciudad,
                                                    _nacionalidad.text);
                                        print(respuestaDatosPersonalesUpdate
                                            .body);
                                        print("Actualizar");
                                      }
                                      if (_imageUser != null) {
                                        print(idDatosPersonales);
                                        print("subir foto");
                                        var respuestaDatosPersonales =
                                            await DatosPersonalesProvider
                                                .updateFotoUser(
                                          _imageUser!,
                                          _nombre.text,
                                          _apellidoPaterno.text,
                                          _apellidoMaterno.text,
                                          StorageUtils.getInteger('id_usuario'),
                                          _ocupacion,
                                          _ciudad,
                                        );
                                        print(respuestaDatosPersonales);
                                      }

                                      final datosPersonalesData =
                                          datosPersonalesModel(
                                              idUser: StorageUtils.getInteger(
                                                  'id_usuario'),
                                              idDatosPersonales:
                                                  StorageUtils.getInteger(
                                                      'id_usuario'),
                                              nombre: _nombre.text,
                                              apellidoPaterno:
                                                  _apellidoPaterno.text,
                                              apellidoMaterno:
                                                  _apellidoMaterno.text,
                                              ciudad: _ciudad,
                                              ocupacion: _ocupacion);
                                      dialog.ocultarDialogo();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DatosPersonales2(
                                                    datosPersonalesData:
                                                        datosPersonalesData)),
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Siguiente",
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
              ));
            } else {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}
