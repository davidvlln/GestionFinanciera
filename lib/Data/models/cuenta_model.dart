class Cuenta {
  final int? idCuenta;
  final int? idUsuario;
  final int? idTipoCuenta;
  final String? nombreCuenta;
  final double? saldo;
  final String? estado;
  final String? titulo;

  Cuenta({
    this.idCuenta,
    this.idUsuario,
    this.idTipoCuenta,
    this.nombreCuenta,
    this.saldo,
    this.estado,
    this.titulo
  });

  factory Cuenta.fromJson(Map<String, dynamic> json) => Cuenta(
    idCuenta: json['id'] as int?,
    idUsuario: json['id_usuario'] as int?,
    idTipoCuenta: json['id_TipoCuenta'] as int?,
    nombreCuenta: json['nombreCuenta'] as String?,
    saldo: (json['Saldo'] as num?)?.toDouble(),
    estado: json['estado'] as String?,
    titulo:json['titulo'] as String
  );

  Map<String, dynamic> toJson() => {
    if (idCuenta != null) 'id': idCuenta,
    if (idUsuario != null) 'id_usuario': idUsuario,
    if (idTipoCuenta != null) 'id_TipoCuenta': idTipoCuenta,
    if (nombreCuenta != null) 'nombreCuenta': nombreCuenta,
    if (saldo != null) 'Saldo': saldo,
    if (estado != null) 'estado': estado,
    if (titulo != null) 'titulo': titulo
  };
}

class CuentaResponse {
  final dynamic data;
  final String? message;

  CuentaResponse({this.data, this.message});
}
