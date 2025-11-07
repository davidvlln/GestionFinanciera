class TipoCuenta {
  final int? idTipoCuenta;
  final String? desTipoCuenta;
  final String? estado;

  TipoCuenta({this.idTipoCuenta, this.desTipoCuenta, this.estado});

  factory TipoCuenta.fromJson(Map<String, dynamic> json) => TipoCuenta(
    idTipoCuenta: json['idTipoCuenta'] as int?,
    desTipoCuenta: json['desTipoCuenta'] as String?,
    estado: json['estado'] as String?,
  );

  Map<String, dynamic> toJson() => {
    if (idTipoCuenta != null) 'idTipoCuenta': idTipoCuenta,
    if (desTipoCuenta != null) 'desTipoCuenta': desTipoCuenta,
    if (estado != null) 'estado': estado,
  };
}

class TipoCuentaResponse {
  final dynamic data;
  final String? message;

  TipoCuentaResponse({this.data, this.message});
}
