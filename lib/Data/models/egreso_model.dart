class Egreso {
  final int? idEgresos;
  final int? idCuenta;
  final int? idTipoEgreso;
  final DateTime? fechaRegistro;
  final double? monto;
  final String? descripcion;

  Egreso({
    this.idEgresos,
    this.idCuenta,
    this.idTipoEgreso,
    this.fechaRegistro,
    this.monto,
    this.descripcion,
  });

  factory Egreso.fromJson(Map<String, dynamic> json) => Egreso(
    idEgresos: json['idEgresos'] as int?,
    idCuenta: json['idCuenta'] as int?,
    idTipoEgreso: json['idTipoEgreso'] as int?,
    fechaRegistro: json['fechaRegistro'] != null
        ? DateTime.parse(json['fechaRegistro'])
        : null,
    monto: (json['monto'] as num?)?.toDouble(),
    descripcion: json['descripcion'] as String?,
  );

  Map<String, dynamic> toJson() => {
    if (idEgresos != null) 'idEgresos': idEgresos,
    if (idCuenta != null) 'idCuenta': idCuenta,
    if (idTipoEgreso != null) 'idTipoEgreso': idTipoEgreso,
    if (fechaRegistro != null)
      'fechaRegistro': fechaRegistro!.toIso8601String(),
    if (monto != null) 'monto': monto,
    if (descripcion != null) 'descripcion': descripcion,
  };
}

class EgresoResponse {
  final dynamic data;
  final String? message;

  EgresoResponse({this.data, this.message});
}
