import '../models/tipoegreso_model.dart';

abstract class ITipoEgresoServ {
  Future<TipoEgresoResponse> getTipoEgreso();
  Future<TipoEgresoResponse> createTipoEgreso(TipoEgreso tipoEgreso);
  Future<TipoEgresoResponse> updateTipoEgreso(int id, TipoEgreso tipoEgreso);
  Future<TipoEgresoResponse> deleteTipoEgreso(int id);
  Future<TipoEgresoResponse> getTipoEgresoPorID(int? id); 
}
