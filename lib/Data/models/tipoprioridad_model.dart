class TipoPrioridad {
  final int? idTipoPrioridad;
  final String? desTipoPrioridad;
  final double? factorPrioridad;

  TipoPrioridad({
    this.idTipoPrioridad,
    this.desTipoPrioridad,
    this.factorPrioridad,
  });

  factory TipoPrioridad.fromJson(Map<String, dynamic> json) => TipoPrioridad(
    idTipoPrioridad: json['idTipoPrioridad'] as int?,
    desTipoPrioridad: json['desTipoPrioridad'] as String?,
    factorPrioridad: (json['factorPrioridad'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    if (idTipoPrioridad != null) 'idTipoPrioridad': idTipoPrioridad,
    if (desTipoPrioridad != null) 'desTipoPrioridad': desTipoPrioridad,
    if (factorPrioridad != null) 'factorPrioridad': factorPrioridad,
  };
}

class TipoPrioridadResponse {
  final dynamic data;
  final String? message;

  TipoPrioridadResponse({this.data, this.message});
}
