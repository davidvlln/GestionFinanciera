import '../models/ingreso_model.dart';

abstract class IIngresoServ {
  Future<IngresoResponse> getIngresos();
  Future<IngresoResponse> createIngreso(Ingreso ingreso);
  Future<IngresoResponse> updateIngreso(int id, Ingreso ingreso);
  Future<IngresoResponse> deleteIngreso(int id);
}
