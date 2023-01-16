import 'dart:convert';

List<MarcaAuto> listMarcaAutoDesdeListJson(List<dynamic> json) {
  return List<MarcaAuto>.from(json.map((x) => MarcaAuto.fromJson(x)));
}

List<MarcaAuto> marcaAutoFromJson(String str) =>
    List<MarcaAuto>.from(json.decode(str).map((x) => MarcaAuto.fromJson(x)));

String marcaAutoToJson(List<MarcaAuto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MarcaAuto {
  MarcaAuto({
    this.id,
    this.nombreMarca,
    this.idAlianzaMarca,
    this.activo,
  });

  int? id;
  String? nombreMarca;
  int? idAlianzaMarca;
  bool? activo;

  factory MarcaAuto.fromJson(Map<String, dynamic> json) => MarcaAuto(
        id: json["id"],
        nombreMarca: json["nombre_marca"],
        idAlianzaMarca: json["id_alianza_marca"],
        activo: json["activo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_marca": nombreMarca,
        "id_alianza_marca": idAlianzaMarca,
        "activo": activo,
      };
}
