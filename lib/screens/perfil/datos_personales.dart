import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
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
                    '??Registro Exitoso!',
                    style: TextStyle(
                      color: Color(0xff1D2766),
                      fontSize: 34,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Ahora completa tus datos personales para empezar a utilizar la aplicaci??n',
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
  final ScrollController _scrollController = ScrollController();

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

  Future<List<Ciudad>> loadCiudadList() async {
    List<DropdownMenuItem<int>> plazaList = [];
    var response = await MotorizadoProvider.getDatos('/api/ciudad/list/');
    List<Ciudad> ciudades = [
      Ciudad(nombreCiudad: 'Selecciona una ciudad', id: 0),
    ];
    final respCiudades = json.decode(utf8.decode(response.bodyBytes));

    for (final ciudad in respCiudades) {
      ciudades
          .add(Ciudad(nombreCiudad: ciudad['nombre_ciudad'], id: ciudad['id']));
    }

    // plazaList.add(
    //   DropdownMenuItem(
    //     child: Text('Seleccione una ciudad'),
    //     value: 0,
    //   ),
    // );

    return ciudades;
  }

  Future<List<DropdownMenuItem<int>>> loadOcupacionList() async {
    List<DropdownMenuItem<int>> plazaList = [];
    var response = await MotorizadoProvider.getDatos('/api/profesion/list/');
    var profesiones = json.decode(utf8.decode(response.bodyBytes));

    plazaList.add(new DropdownMenuItem(
      child: new Text('Selecciona una ocupaci??n'),
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
      child: new Text('Selecciona un pa??s'),
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

  final titleStyle = TextStyle(fontSize: 15, color: Color(0xff1A2461));

  final dropdownItemTextStyle = TextStyle(fontSize: 15, color: Colors.black);

  List<DropdownMenuItem<String>> get generoItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
        child: Center(
          child: Text(
            "G??nero",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 15,
            ),
          ),
        ),
        value: "NN",
      ),
      DropdownMenuItem(
        child: Center(
            child: Text(
          "Masculino",
          style: dropdownItemTextStyle,
        )),
        value: "M",
      ),
      DropdownMenuItem(
        child: Center(
            child: Text(
          "Femenino",
          style: dropdownItemTextStyle,
        )),
        value: "F",
      )
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get generoItems2 {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
        child: Text(
          "G??nero",
        ),
        value: "NN",
      ),
      DropdownMenuItem(
        child: Text(
          "Masculino",
        ),
        value: "M",
      ),
      DropdownMenuItem(
        child: Text(
          "Femenino",
        ),
        value: "F",
      )
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get extItems2 {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text(
            "Elija una extensi??n",
          ),
          value: "NN"),
      DropdownMenuItem(
          child: Text(
            "La Paz",
          ),
          value: "LP"),
      DropdownMenuItem(
          child: Text(
            "Chuquisaca",
          ),
          value: "CH"),
      DropdownMenuItem(
          child: Text(
            "Cochabamba",
          ),
          value: "CB"),
      DropdownMenuItem(
          child: Text(
            "Oruro",
          ),
          value: "OR"),
      DropdownMenuItem(
          child: Text(
            "Potos??",
          ),
          value: "PO"),
      DropdownMenuItem(
          child: Text(
            "Tarija",
          ),
          value: "TJ"),
      DropdownMenuItem(
          child: Text(
            "Santa Cruz",
          ),
          value: "SC"),
      DropdownMenuItem(
          child: Text(
            "Beni",
          ),
          value: "BE"),
      DropdownMenuItem(
          child: Text(
            "Pando",
          ),
          value: "PA"),
      DropdownMenuItem(
          child: Text(
            "Extranjeros con C.I.",
          ),
          value: "EX"),
      DropdownMenuItem(
          child: Text(
            "Extranjeros con Pasaporte",
          ),
          value: "PS"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get extItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Center(
              child: Text(
            "Elija una extensi??n",
            style: titleStyle,
          )),
          value: "NN"),
      DropdownMenuItem(
          child: Center(
              child: Text(
            "La Paz",
            style: dropdownItemTextStyle,
          )),
          value: "LP"),
      DropdownMenuItem(
          child: Center(
              child: Text(
            "Chuquisaca",
            style: dropdownItemTextStyle,
          )),
          value: "CH"),
      DropdownMenuItem(
          child: Center(
              child: Text(
            "Cochabamba",
            style: dropdownItemTextStyle,
          )),
          value: "CB"),
      DropdownMenuItem(
          child: Center(
              child: Text(
            "Oruro",
            style: dropdownItemTextStyle,
          )),
          value: "OR"),
      DropdownMenuItem(
          child: Center(
              child: Text(
            "Potos??",
            style: dropdownItemTextStyle,
          )),
          value: "PO"),
      DropdownMenuItem(
          child: Center(
              child: Text(
            "Tarija",
            style: dropdownItemTextStyle,
          )),
          value: "TJ"),
      DropdownMenuItem(
          child: Center(
              child: Text(
            "Santa Cruz",
            style: dropdownItemTextStyle,
          )),
          value: "SC"),
      DropdownMenuItem(
          child: Center(
              child: Text(
            "Beni",
            style: dropdownItemTextStyle,
          )),
          value: "BE"),
      DropdownMenuItem(
          child: Center(
              child: Text(
            "Pando",
            style: dropdownItemTextStyle,
          )),
          value: "PA"),
      DropdownMenuItem(
          child: Center(
              child: Text(
            "Extranjeros con C.I.",
            style: dropdownItemTextStyle,
          )),
          value: "EX"),
      DropdownMenuItem(
          child: Center(
              child: Text(
            "Extranjeros con Pasaporte",
            style: dropdownItemTextStyle,
          )),
          value: "PS"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get estadocivilItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Center(
              child: Text(
            "Elija un estado civil",
            style: titleStyle,
          )),
          value: "NN"),
      DropdownMenuItem(
          child: Center(
              child: Text(
            "Soltero",
            style: dropdownItemTextStyle,
          )),
          value: "1"),
      DropdownMenuItem(
          child: Center(
              child: Text(
            "Casado",
            style: dropdownItemTextStyle,
          )),
          value: "2"),
      DropdownMenuItem(
          child: Center(
              child: Text(
            "Viudo",
            style: dropdownItemTextStyle,
          )),
          value: "3"),
      DropdownMenuItem(
          child: Center(
              child: Text(
            "Divorciado",
            style: dropdownItemTextStyle,
          )),
          value: "4"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get estadocivilItems2 {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Estado civil"), value: "NN"),
      DropdownMenuItem(child: Text("Soltero"), value: "1"),
      DropdownMenuItem(child: Text("Casado"), value: "2"),
      DropdownMenuItem(child: Text("Viudo"), value: "3"),
      DropdownMenuItem(child: Text("Divorciado"), value: "4"),
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
                  controller: _scrollController,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 190,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  padding: const EdgeInsets.only(
                                    top: kToolbarHeight,
                                    left: 16,
                                  ),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.arrow_back_ios),
                                          color: Theme.of(context).accentColor,
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        Text(
                                          'Datos Personales',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: GestureDetector(
                                  onTap: () {
                                    getImageUser();
                                  },
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: _imageUser == null
                                            ? (fotoUsuario == null
                                                    ? AssetImage(
                                                        'assets/img/user_profile.png')
                                                    : NetworkImage(
                                                        fotoUsuario!))
                                                as ImageProvider<Object>?
                                            : FileImage(_imageUser!),
                                        radius: 60,
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).accentColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 34,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                      _scrollController.animateTo(0.0,
                                          duration:
                                              const Duration(milliseconds: 600),
                                          curve: Curves.linear);
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
                                      _scrollController.animateTo(0.0,
                                          duration:
                                              const Duration(milliseconds: 600),
                                          curve: Curves.linear);
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
                                      _scrollController.animateTo(0.0,
                                          duration:
                                              const Duration(milliseconds: 600),
                                          curve: Curves.linear);
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
                                      labelText: 'N??mero de celular',
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xff1D2766),
                                        ),
                                      )),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      _scrollController.animateTo(0.0,
                                          duration:
                                              const Duration(milliseconds: 600),
                                          curve: Curves.linear);
                                      return 'Ingrese n??mero de celular';
                                    }
                                    return null;
                                  }),
                              DateTimeFormField(
                                decoration: const InputDecoration(
                                  hintStyle: TextStyle(color: Colors.black45),
                                  errorStyle:
                                      TextStyle(color: Colors.redAccent),
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
                                    return 'Debe tener m??s de 18 a??os';
                                  } else if (yearDiff > 75) {
                                    return 'Debe tener un maximo de 75 a??os';
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
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'G??nero',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              DropdownButtonFormField(
                                hint: new Text('G??nero'),
                                items: generoItems,
                                value: _genero,
                                borderRadius: BorderRadius.circular(16),
                                icon: Transform.rotate(
                                  angle: pi * 1.5,
                                  child: Icon(Icons.chevron_left),
                                ),
                                validator: (dynamic value) =>
                                    value == "NN" ? "NN" : null,
                                onChanged: (dynamic value) {
                                  _genero = value;
                                },
                                selectedItemBuilder: (BuildContext context) {
                                  return generoItems2;
                                },
                                isExpanded: true,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Estado civil',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              DropdownButtonFormField(
                                hint: new Text('Estado civil'),
                                items: estadocivilItems,
                                value: _estadoCivil,
                                borderRadius: BorderRadius.circular(16),
                                validator: (dynamic value) =>
                                    value == "NN" ? 'NN' : null,
                                onChanged: (dynamic value) {
                                  _estadoCivil = value;
                                },
                                selectedItemBuilder: (context) =>
                                    estadocivilItems2,
                                isExpanded: true,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Tipo de documento',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              DropdownButtonFormField(
                                hint: new Text('Tipo de documento'),
                                items: ["CI", "PASAPORTE", "LICENCIA", "OTRO"]
                                    .map((label) => DropdownMenuItem(
                                          child: Center(
                                            child: Text(
                                              label == 'CI'
                                                  ? 'C??dula de Identidad'
                                                  : label.toString(),
                                              style: dropdownItemTextStyle,
                                            ),
                                          ),
                                          value: label,
                                        ))
                                    .toList(),
                                value: _tipoDocumento,
                                validator: (dynamic value) =>
                                    value == null ? 'CI' : null,
                                onChanged: (dynamic value) {
                                  _tipoDocumento = value;
                                },
                                selectedItemBuilder: (context) =>
                                    ["CI", "PASAPORTE", "LICENCIA", "OTRO"]
                                        .map((label) => DropdownMenuItem(
                                              child: Text(
                                                label == 'CI'
                                                    ? 'C??dula de Identidad'
                                                    : label.toString(),
                                              ),
                                              value: label,
                                            ))
                                        .toList(),
                                isExpanded: true,
                              ),
                              TextFormField(
                                controller: _nroDocumento,
                                decoration: const InputDecoration(
                                    labelText: 'N??mero de documento:',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff1D2766),
                                      ),
                                    )),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Ingrese el n??mero de documento';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Extensi??n',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              DropdownButtonFormField(
                                hint: new Text('Extensi??n'),
                                items: extItems,
                                value: _extDocumento,
                                validator: (dynamic value) =>
                                    value == null ? 'NN' : null,
                                onChanged: (dynamic value) {
                                  _extDocumento = value;
                                },
                                selectedItemBuilder: (context) {
                                  return extItems2;
                                },
                                isExpanded: true,
                              ),
                              TextFormField(
                                  controller: _email,
                                  decoration: const InputDecoration(
                                      labelText: 'Correo electr??nico',
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
                                          value == 0 ? 'Elija un pa??s' : null,
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
                              FutureBuilder<List<Ciudad>>(
                                  future: loadCiudadList(),
                                  builder: (context, snapshotCiudad) {
                                    if (snapshotCiudad.hasData == false) {
                                      return Container();
                                    }

                                    return DropdownButtonFormField(
                                      decoration: const InputDecoration(
                                        hintStyle:
                                            TextStyle(color: Colors.black45),
                                        errorStyle:
                                            TextStyle(color: Colors.redAccent),
                                        labelText: 'Ciudad de residencia',
                                      ),
                                      hint: new Text('Ciudad de residencia'),
                                      items: snapshotCiudad.data!.map((ciudad) {
                                        return DropdownMenuItem(
                                          child: Text(
                                            ciudad.nombreCiudad,
                                            style: ciudad.id == 0
                                                ? titleStyle
                                                : dropdownItemTextStyle,
                                          ),
                                          value: ciudad.id,
                                        );
                                      }).toList(),
                                      borderRadius: BorderRadius.circular(16),
                                      selectedItemBuilder: (context) =>
                                          snapshotCiudad.data!.map((ciudad) {
                                        return DropdownMenuItem(
                                          child: Text(
                                            ciudad.nombreCiudad,
                                          ),
                                          value: ciudad.id,
                                        );
                                      }).toList(),
                                      value: _ciudad,
                                      validator: (dynamic value) => value == 0
                                          ? 'Elija una ciudad'
                                          : null,
                                      onChanged: (dynamic value) {
                                        _ciudad = value;
                                      },
                                      isExpanded: true,
                                    );
                                  }),
                              TextFormField(
                                  controller: _direccion,
                                  decoration: const InputDecoration(
                                    labelText: 'Direcci??n',
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Ingrese su direcci??n';
                                    }
                                    return null;
                                  }),
                              const SizedBox(
                                height: 4,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Profesi??n',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
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
                              SizedBox(
                                height: 24,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Row(
                                                  children: [
                                                    CircularProgressIndicator(),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    Text(
                                                      'Guardando',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              );
                                            });

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
                                                    'Es necesario que elija una ocupaci??n'),
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
                                            StorageUtils.getInteger(
                                                'id_usuario'),
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
                                        Navigator.pop(context);
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
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),
                                      child: Text(
                                        "Siguiente",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
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

class Ciudad {
  const Ciudad({
    required this.nombreCiudad,
    required this.id,
  });

  final String nombreCiudad;
  final int id;
}
