import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class SelectorFoto extends StatelessWidget {
  const SelectorFoto({
    required this.onTapImagen,
    required this.imagen,
    required this.onTapInfo,
    required this.placeHolderAsset,
    required this.description,
    this.reversePlaceholder = false,
  });

  final VoidCallback onTapImagen;
  final File? imagen;
  final VoidCallback onTapInfo;
  final String placeHolderAsset;
  final String description;
  final bool reversePlaceholder;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              onTapImagen();
            },
            child: Stack(
              children: [
                Container(
                  height: 340,
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color(0xffEC1C24),
                    ),
                  ),
                  child: imagen == null
                      ? reversePlaceholder
                          ? Image.asset(placeHolderAsset)
                          : Image.asset(placeHolderAsset)
                      : Image.file(imagen!),
                ),
                Positioned(
                  bottom: 20,
                  right: 16,
                  child: GestureDetector(
                    onTap: () {
                      onTapInfo();
                    },
                    child: Icon(
                      Icons.info_outline,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: ElevatedButton(
                    child: Text('Repetir'),
                    onPressed: () {
                      onTapImagen();
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
