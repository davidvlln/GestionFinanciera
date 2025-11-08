import 'package:Caney/Data/models/cuenta_model.dart';
import 'package:Caney/Data/models/usuario_model.dart';

import '../models/egreso_model.dart';

abstract class IEgresoServ {
  Future<EgresoResponse> getEgresos();
  Future<EgresoResponse> createEgreso(Egreso egreso);
  Future<EgresoResponse> updateEgreso(int id, Egreso egreso);
  Future<EgresoResponse> deleteEgreso(int id);
  Future<EgresoResponse> getEgresosPorUsuarioCuenta(Cuenta cuentaUser);
}
