import '../models/tipocuenta_model.dart';

abstract class ITipoCuentaServ {
  Future<TipoCuentaResponse> getTipoCuenta();
  Future<TipoCuentaResponse> createTipoCuenta(TipoCuenta tipoCuenta);
  Future<TipoCuentaResponse> updateTipoCuenta(int id, TipoCuenta tipoCuenta);
  Future<TipoCuentaResponse> deleteTipoCuenta(int id);
}
