import 'package:flutter/material.dart';

class Profesion {
  const Profesion({
    required this.id,
    required this.nombreProfesion,
    required this.idAlianza,
    required this.activo,
  });

  final int? id;
  final String? nombreProfesion;
  final int? idAlianza;
  final bool? activo;

  factory Profesion.fromJson(Map<String, dynamic> json) {
    return Profesion(
      id: json['id'],
      nombreProfesion: json['nombre_profesion'],
      idAlianza: json['id_alianza'],
      activo: json['activo'],
    );
  }
}
