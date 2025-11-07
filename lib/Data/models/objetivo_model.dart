class Objetivo {
  final int? idObjetivo;
  final int? idMeta;
  final String? desObjetivo;
  final double? montoEsperado;
  final String? estado;
  final DateTime? fechaObjetivo;

  Objetivo({
    this.idObjetivo,
    this.idMeta,
    this.desObjetivo,
    this.montoEsperado,
    this.estado,
    this.fechaObjetivo,
  });

  factory Objetivo.fromJson(Map<String, dynamic> json) => Objetivo(
    idObjetivo: json['idObjetivo'] as int?,
    idMeta: json['idMeta'] as int?,
    desObjetivo: json['desObjetivo'] as String?,
    montoEsperado: (json['montoEsperado'] as num?)?.toDouble(),
    estado: json['estado'] as String?,
    fechaObjetivo: json['fechaObjetivo'] != null
        ? DateTime.parse(json['fechaObjetivo'])
        : null, // ✅ Conversión segura
  );

  Map<String, dynamic> toJson() => {
    if (idObjetivo != null) 'idObjetivo': idObjetivo,
    if (idMeta != null) 'idMeta': idMeta,
    if (desObjetivo != null) 'desObjetivo': desObjetivo,
    if (montoEsperado != null) 'montoEsperado': montoEsperado,
    if (estado != null) 'estado': estado,
    if (fechaObjetivo != null)
      'fechaObjetivo': fechaObjetivo!.toIso8601String(),
  };
}

class ObjetivoResponse {
  final dynamic data;
  final String? message;

  ObjetivoResponse({this.data, this.message});
}
