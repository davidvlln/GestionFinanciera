class TipoEgreso {
  final int? idTipoEgreso;
  final String? desTipoEgreso;

  TipoEgreso({this.idTipoEgreso, this.desTipoEgreso});

  factory TipoEgreso.fromJson(Map<String, dynamic> json) => TipoEgreso(
    idTipoEgreso: json['id'] as int?,
    desTipoEgreso: json['desTipoEgreso'] as String?,
  );

  Map<String, dynamic> toJson() => {
    if (idTipoEgreso != null) 'id': idTipoEgreso,
    if (desTipoEgreso != null) 'desTipoEgreso': desTipoEgreso,
  };
}

class TipoEgresoResponse {
  final dynamic data;
  final String? message;

  TipoEgresoResponse({this.data, this.message});
}
