class TipoIngreso {
  final int? idTipoIngreso;
  final String? desTipoIngreso;

  TipoIngreso({this.idTipoIngreso, this.desTipoIngreso});

  factory TipoIngreso.fromJson(Map<String, dynamic> json) => TipoIngreso(
    idTipoIngreso: json['idTipoIngreso'] as int?,
    desTipoIngreso: json['desTipoIngreso'] as String?,
  );

  Map<String, dynamic> toJson() => {
    if (idTipoIngreso != null) 'idTipoIngreso': idTipoIngreso,
    if (desTipoIngreso != null) 'desTipoIngreso': desTipoIngreso,
  };
}

class TipoIngresoResponse {
  final dynamic data;
  final String? message;

  TipoIngresoResponse({this.data, this.message});
}
