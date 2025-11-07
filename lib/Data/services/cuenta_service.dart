import '../models/cuenta_model.dart';

abstract class ICuentaServ {
  Future<CuentaResponse> getCuentas();
  Future<CuentaResponse> getCuentaByUsuario(int idUsuario);
  Future<CuentaResponse> createCuenta(Cuenta cuenta);
  Future<CuentaResponse> updateCuenta(int id, Cuenta cuenta);
  Future<CuentaResponse> deleteCuenta(int id);
  Future<CuentaResponse> transferirEntreCuentas({
    required int idCuentaOrigen,
    required int idCuentaDestino,
    required double monto,
  });
}
