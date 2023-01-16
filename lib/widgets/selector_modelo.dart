import 'package:flutter/material.dart';
import 'package:mibigbro/models/modelo_auto.dart';

class SelectorModelo extends StatefulWidget {
  const SelectorModelo({
    required this.modelos,
    required this.onChanged,
    required this.modeloSeleccionado,
  });

  final ModeloAuto? modeloSeleccionado;
  final List<ModeloAuto>? modelos;
  final Function(ModeloAuto) onChanged;

  @override
  _SelectorModeloState createState() => _SelectorModeloState();
}

class _SelectorModeloState extends State<SelectorModelo> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ValueNotifier<String> buscadorModeloNotifier = ValueNotifier('');

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
                        buscadorModeloNotifier.value = value;
                      },
                      decoration: InputDecoration(labelText: 'Buscar marca'),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                      child: ValueListenableBuilder<String>(
                    valueListenable: buscadorModeloNotifier,
                    builder: (context, value, child) {
                      return ListView.builder(
                        itemCount: widget.modelos!.length,
                        itemBuilder: (context, index) {
                          final modelo = widget.modelos![index];

                          if (!modelo.nombre
                              .toLowerCase()
                              .contains(value.toLowerCase())) {
                            return Container();
                          }

                          return ListTile(
                            title: Text(modelo.nombre),
                            onTap: () {
                              Navigator.pop(context);
                              widget.onChanged(modelo);
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
                widget.modeloSeleccionado != null
                    ? widget.modeloSeleccionado!.nombre
                    : 'Selecciona un modelo',
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
