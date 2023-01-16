import 'dart:convert';

List<PolizaPendientePago> polizaPendientePagoFromJson(String str) =>
    List<PolizaPendientePago>.from(
        json.decode(str).map((x) => PolizaPendientePago.fromJson(x)));

String polizaPendientePagoToJson(List<PolizaPendientePago> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PolizaPendientePago {
  PolizaPendientePago({
    this.idPoliza,
    this.nroPoliza,
    this.estado,
    this.aseguradora,
    this.idAutomovil,
    this.idModelo,
    this.modelo,
    this.idMarca,
    this.marca,
    this.placa,
    this.idYear,
    this.year,
    this.idUso,
    this.uso,
    this.idCiudad,
    this.ciudad,
    this.valorAsegurado,
    this.vigenciaInicio,
    this.vigenciaFinal,
    this.prima,
    this.urlPago,
    this.urlCertificado,
    this.coberturas,
    this.idInspeccion,
    this.fotoFrontal,
    this.fotoTrasero,
    this.fotoLateralIzq,
    this.fotoLateralDer,
    this.fotoTablero,
    this.fotoRuat,
    this.finVigencia,
    this.nroRenovacion,
    this.fechaPago,
  });

  int? idPoliza;
  String? nroPoliza;
  String? estado;
  String? aseguradora;
  int? idAutomovil;
  int? idModelo;
  String? modelo;
  int? idMarca;
  String? marca;
  String? placa;
  int? idYear;
  int? year;
  int? idUso;
  String? uso;
  int? idCiudad;
  String? ciudad;
  int? valorAsegurado;
  DateTime? vigenciaInicio;
  DateTime? vigenciaFinal;
  double? prima;
  String? urlPago;
  String? urlCertificado;
  String? coberturas;
  int? idInspeccion;
  String? fotoFrontal;
  String? fotoTrasero;
  String? fotoLateralIzq;
  String? fotoLateralDer;
  String? fotoTablero;
  String? fotoRuat;
  DateTime? finVigencia;
  int? nroRenovacion;
  dynamic fechaPago;

  factory PolizaPendientePago.fromJson(Map<String, dynamic> json) =>
      PolizaPendientePago(
        idPoliza: json["id_poliza"],
        nroPoliza: json["nro_poliza"],
        estado: json["estado"],
        aseguradora: json["aseguradora"],
        idAutomovil: json["id_automovil"],
        idModelo: json["id_modelo"],
        modelo: json["modelo"],
        idMarca: json["id_marca"],
        marca: json["marca"],
        placa: json["placa"],
        idYear: json["id_year"],
        year: json["year"],
        idUso: json["id_uso"],
        uso: json["uso"],
        idCiudad: json["id_ciudad"],
        ciudad: json["ciudad"],
        valorAsegurado: json["valor_asegurado"],
        vigenciaInicio: DateTime.parse(json["vigencia_inicio"]),
        vigenciaFinal: DateTime.parse(json["vigencia_final"]),
        prima: json["prima"].toDouble(),
        urlPago: json["url_pago"],
        urlCertificado:
            json["url_certificado"] == null ? null : json["url_certificado"],
        coberturas: json["coberturas"],
        idInspeccion: json["id_inspeccion"],
        fotoFrontal: json["foto_frontal"],
        fotoTrasero: json["foto_trasero"],
        fotoLateralIzq: json["foto_lateral_izq"],
        fotoLateralDer: json["foto_lateral_der"],
        fotoTablero: json["foto_tablero"],
        fotoRuat: json["foto_ruat"],
        finVigencia: DateTime.parse(json["fin_vigencia"]),
        nroRenovacion: json["nro_renovacion"],
        fechaPago: json["fecha_pago"],
      );

  Map<String, dynamic> toJson() => {
        "id_poliza": idPoliza,
        "nro_poliza": nroPoliza,
        "estado": estado,
        "aseguradora": aseguradora,
        "id_automovil": idAutomovil,
        "id_modelo": idModelo,
        "modelo": modelo,
        "id_marca": idMarca,
        "marca": marca,
        "placa": placa,
        "id_year": idYear,
        "year": year,
        "id_uso": idUso,
        "uso": uso,
        "id_ciudad": idCiudad,
        "ciudad": ciudad,
        "valor_asegurado": valorAsegurado,
        "vigencia_inicio":
            "${vigenciaInicio!.year.toString().padLeft(4, '0')}-${vigenciaInicio!.month.toString().padLeft(2, '0')}-${vigenciaInicio!.day.toString().padLeft(2, '0')}",
        "vigencia_final":
            "${vigenciaFinal!.year.toString().padLeft(4, '0')}-${vigenciaFinal!.month.toString().padLeft(2, '0')}-${vigenciaFinal!.day.toString().padLeft(2, '0')}",
        "prima": prima,
        "url_pago": urlPago,
        "url_certificado": urlCertificado == null ? null : urlCertificado,
        "coberturas": coberturas,
        "id_inspeccion": idInspeccion,
        "foto_frontal": fotoFrontal,
        "foto_trasero": fotoTrasero,
        "foto_lateral_izq": fotoLateralIzq,
        "foto_lateral_der": fotoLateralDer,
        "foto_tablero": fotoTablero,
        "foto_ruat": fotoRuat,
        "fin_vigencia":
            "${finVigencia!.year.toString().padLeft(4, '0')}-${finVigencia!.month.toString().padLeft(2, '0')}-${finVigencia!.day.toString().padLeft(2, '0')}",
        "nro_renovacion": nroRenovacion,
        "fecha_pago": fechaPago,
      };
}
