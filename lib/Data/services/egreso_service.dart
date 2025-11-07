import '../models/egreso_model.dart';

abstract class IEgresoServ {
  Future<EgresoResponse> getEgresos();
  Future<EgresoResponse> createEgreso(Egreso egreso);
  Future<EgresoResponse> updateEgreso(int id, Egreso egreso);
  Future<EgresoResponse> deleteEgreso(int id);
}
