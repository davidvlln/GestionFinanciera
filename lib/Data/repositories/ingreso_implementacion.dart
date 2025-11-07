import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/ingreso_model.dart';
import '../services/ingreso_service.dart';
import '../../Core/errors/error_common.dart';

class IngresoImp implements IIngresoServ {
  final dynamic dataSource;

  IngresoImp({dynamic dataSourceClient})
    : dataSource = dataSourceClient ?? Supabase.instance.client;

  @override
  Future<IngresoResponse> getIngresos() async {
    try {
      final response = await dataSource.from('Ingresos').select();
      final lista = (response as List).map((e) => Ingreso.fromJson(e)).toList();
      return IngresoResponse(data: lista, message: 'Consulta exitosa');
    } catch (error) {
      return IngresoResponse(
        data: null,
        message: '${ErrorCommon.errorResponse}${error.toString()}',
      );
    }
  }

  @override
  Future<IngresoResponse> createIngreso(Ingreso ingreso) async {
    try {
      final response = await dataSource
          .from('Ingresos')
          .insert(ingreso.toJson())
          .select()
          .single();

      final nuevoIngreso = Ingreso.fromJson(response);

      final cuentaData = await dataSource
          .from('Cuenta')
          .select('Saldo')
          .eq('id', ingreso.idCuenta)
          .single();

      double saldoActual = (cuentaData['Saldo'] as num?)?.toDouble() ?? 0.0;
      double nuevoSaldo = saldoActual + (ingreso.monto ?? 0.0);

      await dataSource
          .from('Cuenta')
          .update({'Saldo': nuevoSaldo})
          .eq('id', ingreso.idCuenta);

      return IngresoResponse(
        data: nuevoIngreso,
        message:
            'Ingreso creado y saldo actualizado correctamente (nuevo saldo: $nuevoSaldo)',
      );
    } catch (error) {
      return IngresoResponse(
        data: null,
        message: 'Error al crear ingreso: ${error.toString()}',
      );
    }
  }

  @override
  Future<IngresoResponse> updateIngreso(int id, Ingreso ingreso) async {
    try {
      final oldData = await dataSource
          .from('Ingresos')
          .select()
          .eq('idIngresos', id)
          .single();

      final oldIngreso = Ingreso.fromJson(oldData);

      final double oldMonto = oldIngreso.monto ?? 0.0;
      final double newMonto = ingreso.monto ?? 0.0;
      final double diferencia = newMonto - oldMonto;

      await dataSource
          .from('Ingresos')
          .update(ingreso.toJson())
          .eq('idIngresos', id);

      final cuentaData = await dataSource
          .from('Cuenta')
          .select('Saldo')
          .eq('id', ingreso.idCuenta)
          .single();

      double saldoActual = (cuentaData['Saldo'] as num?)?.toDouble() ?? 0.0;
      double nuevoSaldo = saldoActual + diferencia;

      await dataSource
          .from('Cuenta')
          .update({'Saldo': nuevoSaldo})
          .eq('id', ingreso.idCuenta);

      return IngresoResponse(
        message:
            'Ingreso actualizado correctamente (diferencia aplicada: $diferencia, nuevo saldo: $nuevoSaldo)',
      );
    } catch (error) {
      return IngresoResponse(
        data: null,
        message: 'Error al actualizar ingreso: ${error.toString()}',
      );
    }
  }

  @override
  Future<IngresoResponse> deleteIngreso(int id) async {
    try {
      final ingresoData = await dataSource
          .from('Ingresos')
          .select()
          .eq('idIngresos', id)
          .single();

      final ingreso = Ingreso.fromJson(ingresoData);

      await dataSource.from('Ingresos').delete().eq('idIngresos', id);

      final cuentaData = await dataSource
          .from('Cuenta')
          .select('Saldo')
          .eq('id', ingreso.idCuenta)
          .single();

      double saldoActual = (cuentaData['Saldo'] as num?)?.toDouble() ?? 0.0;
      double nuevoSaldo = saldoActual - (ingreso.monto ?? 0.0);

      await dataSource
          .from('Cuenta')
          .update({'Saldo': nuevoSaldo})
          .eq('id', ingreso.idCuenta);

      return IngresoResponse(
        message:
            'Ingreso eliminado y saldo actualizado correctamente (nuevo saldo: $nuevoSaldo)',
      );
    } catch (error) {
      return IngresoResponse(
        data: null,
        message: 'Error al eliminar ingreso: ${error.toString()}',
      );
    }
  }
}
