import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mibigbro/models/marca_auto.dart';

class SelectorMarca extends StatefulWidget {
  const SelectorMarca({
    required this.marcas,
    required this.onChanged,
    required this.ocupacionInicial,
  });

  final int? ocupacionInicial;
  final List<MarcaAuto>? marcas;
  final Function(MarcaAuto) onChanged;

  @override
  _SelectorMarcaState createState() => _SelectorMarcaState();
}

class _SelectorMarcaState extends State<SelectorMarca> {
  MarcaAuto? marcaSeleccioneda;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ValueNotifier<String> buscadorMarcaNotifier = ValueNotifier('');

        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: TextField(
                      onChanged: (value) {
                        buscadorMarcaNotifier.value = value;
                      },
                      decoration: InputDecoration(labelText: 'Buscar marca'),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                      child: ValueListenableBuilder<String>(
                    valueListenable: buscadorMarcaNotifier,
                    builder: (context, value, child) {
                      return ListView.builder(
                        itemCount: widget.marcas!.length,
                        itemBuilder: (context, index) {
                          final marca = widget.marcas![index];

                          if (!marca.nombreMarca!
                              .toLowerCase()
                              .contains(value.toLowerCase())) {
                            return Container();
                          }

                          return ListTile(
                            title: Text(marca.nombreMarca!),
                            onTap: () {
                              Navigator.pop(context);
                              setState(() {
                                marcaSeleccioneda = marca;
                              });
                              widget.onChanged(marca);
                            },
                          );
                        },
                      );
                    },
                  ))
                ],
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                marcaSeleccioneda != null
                    ? marcaSeleccioneda!.nombreMarca!
                    : 'Seleccione una marca',
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
