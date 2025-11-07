class Meta {
  final int? idMeta;
  final int? idCuenta;
  final int? idTipoPrioridad;
  final String? desMeta;
  final double? montoObjetivo;
  final DateTime? fechaRegistro;
  final DateTime? fechaInicio;
  final DateTime? fechaLimite;
  final String? estado;

  Meta({
    this.idMeta,
    this.idCuenta,
    this.idTipoPrioridad,
    this.desMeta,
    this.montoObjetivo,
    this.fechaRegistro,
    this.fechaInicio,
    this.fechaLimite,
    this.estado,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    idMeta: json['idMeta'] as int?,
    idCuenta: json['idCuenta'] as int?,
    idTipoPrioridad: json['idTipoPrioridad'] as int?,
    desMeta: json['desMeta'] as String?,
    montoObjetivo: (json['montoObjetivo'] as num?)?.toDouble(),
    fechaRegistro: json['fechaRegistro'] != null
        ? DateTime.parse(json['fechaRegistro'])
        : null,
    fechaInicio: json['fechaInicio'] != null
        ? DateTime.parse(json['fechaInicio'])
        : null,
    fechaLimite: json['fechaLimite'] != null
        ? DateTime.parse(json['fechaLimite'])
        : null,
    estado: json['estado'] as String?,
  );

  Map<String, dynamic> toJson() => {
    if (idMeta != null) 'idMeta': idMeta,
    if (idCuenta != null) 'idCuenta': idCuenta,
    if (idTipoPrioridad != null) 'idTipoPrioridad': idTipoPrioridad,
    if (desMeta != null) 'desMeta': desMeta,
    if (montoObjetivo != null) 'montoObjetivo': montoObjetivo,
    if (fechaRegistro != null)
      'fechaRegistro': fechaRegistro!.toIso8601String(),
    if (fechaInicio != null) 'fechaInicio': fechaInicio!.toIso8601String(),
    if (fechaLimite != null) 'fechaLimite': fechaLimite!.toIso8601String(),
    if (estado != null) 'estado': estado,
  };
}

class MetaResponse {
  final dynamic data;
  final String? message;

  MetaResponse({this.data, this.message});
}
