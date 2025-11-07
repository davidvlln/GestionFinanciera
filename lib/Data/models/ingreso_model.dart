class Ingreso {
  final int? idIngresos;
  final int? idCuenta;
  final int? idTipoIngreso;
  final DateTime? fechaRegistro;
  final double? monto;
  final String? descripcion;

  Ingreso({
    this.idIngresos,
    this.idCuenta,
    this.idTipoIngreso,
    this.fechaRegistro,
    this.monto,
    this.descripcion,
  });

  factory Ingreso.fromJson(Map<String, dynamic> json) => Ingreso(
    idIngresos: json['idIngresos'] as int?,
    idCuenta: json['idCuenta'] as int?,
    idTipoIngreso: json['idTipoIngreso'] as int?,
    fechaRegistro: json['fechaRegistro'] != null
        ? DateTime.parse(json['fechaRegistro'])
        : null,
    monto: (json['monto'] as num?)?.toDouble(),
    descripcion: json['descripcion'] as String?,
  );

  Map<String, dynamic> toJson() => {
    if (idIngresos != null) 'idIngresos': idIngresos,
    if (idCuenta != null) 'idCuenta': idCuenta,
    if (idTipoIngreso != null) 'idTipoIngreso': idTipoIngreso,
    if (fechaRegistro != null)
      'fechaRegistro': fechaRegistro!.toIso8601String(),
    if (monto != null) 'monto': monto,
    if (descripcion != null) 'descripcion': descripcion,
  };
}

class IngresoResponse {
  final dynamic data;
  final String? message;

  IngresoResponse({this.data, this.message});
}
