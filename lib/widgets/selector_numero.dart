import 'package:flutter/material.dart';

class SelectorNumero extends StatefulWidget {
  const SelectorNumero({
    required this.valorInicial,
    required this.valorMinimo,
    required this.valorMaximo,
    required this.onChanged,
  });

  final int valorInicial;
  final int valorMinimo;
  final int valorMaximo;
  final Function(int?) onChanged;

  @override
  _SelectorNumeroState createState() => _SelectorNumeroState();
}

class _SelectorNumeroState extends State<SelectorNumero> {
  int? valor;

  @override
  void initState() {
    super.initState();

    valor = widget.valorInicial;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (valor! > widget.valorMinimo) {
                  setState(() {
                    valor = (valor ?? 3) - 1;
                  });
                  widget.onChanged(valor);
                }
              },
              child: Container(
                color: Color(0xff1D2766),
                child: Center(
                  child: Icon(Icons.remove, color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            width: width * 0.5,
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  final _numeroAsientosController = TextEditingController();

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: TextField(
                          controller: _numeroAsientosController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Ingrese número asientos',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancelar'),
                          ),
                          TextButton(
                            child: Text('Aceptar'),
                            onPressed: () {
                              final valorNumeroAsientosController =
                                  _numeroAsientosController.text;

                              if (int.tryParse(valorNumeroAsientosController) ==
                                  null) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(
                                            'El número ingresado debe ser un valor numérico'),
                                        actions: [
                                          TextButton(
                                            child: Text('Aceptar'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      );
                                    });
                                return;
                              }

                              if (int.parse(valorNumeroAsientosController) >
                                      30 ||
                                  int.parse(valorNumeroAsientosController) <
                                      2) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(
                                            'El número ingresado debe ser un valor numérico entre 2 y 30'),
                                        actions: [
                                          TextButton(
                                            child: Text('Aceptar'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      );
                                    });
                                return;
                              }

                              setState(
                                () {
                                  valor =
                                      int.parse(valorNumeroAsientosController);
                                },
                              );
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  '$valor',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff1D2766)),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (valor! < widget.valorMaximo) {
                  setState(() {
                    valor = (valor ?? 2) + 1;
                  });
                  widget.onChanged(valor);
                }
              },
              child: Container(
                color: Color(0xff1D2766),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
