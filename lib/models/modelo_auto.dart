class ModeloAuto {
  ModeloAuto({
    required this.nombre,
    required this.id,
  });

  final String nombre;
  final int id;

  factory ModeloAuto.fromJson(Map<String, dynamic> json) {
    return ModeloAuto(nombre: json['nombre_modelo'], id: json['id']);
  }
}
