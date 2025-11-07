import '../models/tipoingreso_model.dart';

abstract class ITipoIngresoServ {
  Future<TipoIngresoResponse> getTipoIngresos();
  Future<TipoIngresoResponse> createTipoIngreso(TipoIngreso tipoIngreso);
  Future<TipoIngresoResponse> updateTipoIngreso(
    int id,
    TipoIngreso tipoIngreso,
  );
  Future<TipoIngresoResponse> deleteTipoIngreso(int id);
}
