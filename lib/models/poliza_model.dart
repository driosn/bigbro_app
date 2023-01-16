// To parse this JSON data, do
//
//     final polizaModel = polizaModelFromJson(jsonString);

import 'dart:convert';

List<PolizaModel> polizaModelFromJson(String str) => List<PolizaModel>.from(
    json.decode(str).map((x) => PolizaModel.fromJson(x)));

class PolizaModel {
  PolizaModel({
    required this.idPoliza,
    required this.nroPoliza,
    required this.estado,
    required this.aseguradora,
    required this.idAutomovil,
    required this.idModelo,
    required this.modelo,
    required this.idMarca,
    required this.marca,
    required this.placa,
    required this.idYear,
    required this.year,
    required this.idUso,
    required this.uso,
    required this.idCiudad,
    required this.ciudad,
    required this.valorAsegurado,
    required this.vigenciaInicio,
    required this.vigenciaFinal,
    required this.prima,
    required this.urlPago,
    required this.urlCertificado,
    required this.coberturas,
    required this.idInspeccion,
    required this.fotoFrontal,
    required this.fotoTrasero,
    required this.fotoLateralIzq,
    required this.fotoLateralDer,
    required this.fotoTablero,
    required this.fotoRuat,
    required this.finVigencia,
    required this.nroRenovacion,
    required this.fechaPago,
  });

  int idPoliza;
  String? nroPoliza;
  String estado;
  String aseguradora;
  int idAutomovil;
  int idModelo;
  String modelo;
  int idMarca;
  String marca;
  String placa;
  int idYear;
  int year;
  int idUso;
  String uso;
  int idCiudad;
  String ciudad;
  double valorAsegurado;
  String vigenciaInicio;
  String vigenciaFinal;
  double prima;
  String? urlPago;
  String? urlCertificado;
  String coberturas;
  int idInspeccion;
  String fotoFrontal;
  String fotoTrasero;
  String fotoLateralIzq;
  String fotoLateralDer;
  String fotoTablero;
  String fotoRuat;
  String finVigencia;
  int nroRenovacion;
  String? fechaPago;

  factory PolizaModel.fromJson(Map<String, dynamic> json) => PolizaModel(
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
        vigenciaInicio: json["vigencia_inicio"],
        vigenciaFinal: json["vigencia_final"],
        prima: json["prima"].toDouble(),
        urlPago: json["url_pago"],
        urlCertificado: json["url_certificado"],
        coberturas: json["coberturas"],
        idInspeccion: json["id_inspeccion"],
        fotoFrontal: json["foto_frontal"],
        fotoTrasero: json["foto_trasero"],
        fotoLateralIzq: json["foto_lateral_izq"],
        fotoLateralDer: json["foto_lateral_der"],
        fotoTablero: json["foto_tablero"],
        fotoRuat: json["foto_ruat"],
        finVigencia: json["fin_vigencia"],
        nroRenovacion: json["nro_renovacion"],
        fechaPago: json["fecha_pago"],
      );
}
