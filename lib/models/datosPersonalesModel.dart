class datosPersonalesModel {
  int? idUser = 0;
  int? idDatosPersonales = 0;
  String? nombre = "";
  String? apellidoPaterno = "";
  String? apellidoMaterno = "";
  int? ciudad;
  int? nacionalidad;
  String? observacion = "";
  int? ocupacion = 0;
  datosPersonalesModel(
      {this.idUser,
      this.idDatosPersonales,
      this.nombre,
      this.apellidoPaterno,
      this.apellidoMaterno,
      this.ciudad,
      this.nacionalidad,
      this.ocupacion,
      this.observacion});
}
