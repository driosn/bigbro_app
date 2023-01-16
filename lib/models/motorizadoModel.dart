class motorizadoModel {
  int? idUser = 0;
  int? idAutomovil = 0;
  int? idCompania = 0;
  int? idPoliza = 0;
  int? idStock = 0;
  int? marca;
  int? modelo;
  int? ano;
  int? uso;
  int? ciudad;
  int? nroPeriodosCobro = 1;
  int? diasCotizados = 0;
  int? nroDias = 0;
  String? tipoCotizacion = "PAQUETE";
  String? montoMedida = "0";
  String? diasMedida = "0";
  String? valor = "0";
  String? periodo = "ANUAL";
  String? periodoCobro = "ANUAL";
  String? franquicia = "50";
  String? costo = "0";
  String? coberturas = "4,2,1,8";
  String? inicioVigencia = "";
  String? finVigencia = "";
  String? camino = "nuevo_seguro";
  String? urlSlip = "";
  int? diasPaquete = 0;
  int? idInspeccion = 0;
  int? nroRenovacion = 1;
  motorizadoModel(
      {this.idUser,
      this.camino,
      this.idAutomovil,
      this.idCompania,
      this.idPoliza,
      this.idStock,
      this.marca,
      this.modelo,
      this.ano,
      this.uso,
      this.ciudad,
      this.valor,
      this.periodo,
      this.franquicia,
      this.coberturas,
      this.periodoCobro,
      this.nroPeriodosCobro,
      this.costo,
      this.inicioVigencia,
      this.finVigencia,
      this.tipoCotizacion,
      this.montoMedida,
      this.diasMedida,
      this.diasCotizados,
      this.nroDias,
      this.idInspeccion,
      this.nroRenovacion,
      this.diasPaquete,
      this.urlSlip});
}
