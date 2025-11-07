import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/egreso_model.dart';
import '../services/egreso_service.dart';
import '../../Core/errors/error_common.dart';

class EgresoImp implements IEgresoServ {
  final dynamic dataSource;

  EgresoImp({dynamic dataSourceClient})
    : dataSource = dataSourceClient ?? Supabase.instance.client;

  @override
  Future<EgresoResponse> getEgresos() async {
    try {
      final response = await dataSource.from('Egresos').select();
      final lista = (response as List).map((e) => Egreso.fromJson(e)).toList();
      return EgresoResponse(data: lista, message: 'Consulta exitosa');
    } catch (error) {
      return EgresoResponse(
        data: null,
        message: '${ErrorCommon.errorResponse}${error.toString()}',
      );
    }
  }

  @override
  Future<EgresoResponse> createEgreso(Egreso egreso) async {
    try {
      // 1️⃣ Insertar el egreso
      final response = await dataSource
          .from('Egresos')
          .insert(egreso.toJson())
          .select()
          .single();

      final nuevoEgreso = Egreso.fromJson(response);

      // 2️⃣ Obtener saldo actual
      final cuentaData = await dataSource
          .from('Cuenta')
          .select('Saldo')
          .eq('id', egreso.idCuenta)
          .single();

      double saldoActual = (cuentaData['Saldo'] as num?)?.toDouble() ?? 0.0;
      double nuevoSaldo = saldoActual - (egreso.monto ?? 0.0);

      // 3️⃣ Actualizar cuenta
      await dataSource
          .from('Cuenta')
          .update({'Saldo': nuevoSaldo})
          .eq('id', egreso.idCuenta);

      return EgresoResponse(
        data: nuevoEgreso,
        message: 'Egreso creado y saldo actualizado (nuevo saldo: $nuevoSaldo)',
      );
    } catch (error) {
      return EgresoResponse(
        data: null,
        message: 'Error al crear egreso: ${error.toString()}',
      );
    }
  }

  @override
  Future<EgresoResponse> updateEgreso(int id, Egreso egreso) async {
    try {
      // Obtener egreso original
      final egresoOriginal = await dataSource
          .from('Egresos')
          .select()
          .eq('idEgresos', id)
          .single();

      final egresoAntiguo = Egreso.fromJson(egresoOriginal);

      double montoAntiguo = egresoAntiguo.monto ?? 0.0;
      double montoNuevo = egreso.monto ?? 0.0;
      double diferencia = montoNuevo - montoAntiguo;

      // Actualizar egreso
      await dataSource
          .from('Egresos')
          .update(egreso.toJson())
          .eq('idEgresos', id);

      // Actualizar saldo
      final cuentaData = await dataSource
          .from('Cuenta')
          .select('Saldo')
          .eq('id', egreso.idCuenta)
          .single();

      double saldoActual = (cuentaData['Saldo'] as num?)?.toDouble() ?? 0.0;
      double nuevoSaldo = saldoActual - diferencia;

      await dataSource
          .from('Cuenta')
          .update({'Saldo': nuevoSaldo})
          .eq('id', egreso.idCuenta);

      return EgresoResponse(
        message:
            'Egreso actualizado y saldo ajustado correctamente (nuevo saldo: $nuevoSaldo)',
      );
    } catch (error) {
      return EgresoResponse(
        data: null,
        message: 'Error al actualizar egreso: ${error.toString()}',
      );
    }
  }

  @override
  Future<EgresoResponse> deleteEgreso(int id) async {
    try {
      // Obtener datos antes de eliminar
      final egresoData = await dataSource
          .from('Egresos')
          .select()
          .eq('idEgresos', id)
          .single();

      final egreso = Egreso.fromJson(egresoData);

      await dataSource.from('Egresos').delete().eq('idEgresos', id);

      // Revertir saldo
      final cuentaData = await dataSource
          .from('Cuenta')
          .select('Saldo')
          .eq('id', egreso.idCuenta)
          .single();

      double saldoActual = (cuentaData['Saldo'] as num?)?.toDouble() ?? 0.0;
      double nuevoSaldo = saldoActual + (egreso.monto ?? 0.0);

      await dataSource
          .from('Cuenta')
          .update({'Saldo': nuevoSaldo})
          .eq('id', egreso.idCuenta);

      return EgresoResponse(
        message:
            'Egreso eliminado y saldo revertido correctamente (nuevo saldo: $nuevoSaldo)',
      );
    } catch (error) {
      return EgresoResponse(
        data: null,
        message: 'Error al eliminar egreso: ${error.toString()}',
      );
    }
  }
}
