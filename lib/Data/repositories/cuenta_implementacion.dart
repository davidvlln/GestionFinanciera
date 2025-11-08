import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/cuenta_model.dart';
import '../services/cuenta_service.dart';
import '../../Core/errors/error_common.dart';

class CuentaImp implements ICuentaServ {
  final dynamic dataSource;

  CuentaImp({dynamic dataSourceClient})
    : dataSource = dataSourceClient ?? Supabase.instance.client;

  @override
  Future<CuentaResponse> getCuentas() async {
    try {
      final response = await dataSource.from('Cuenta').select();
      final lista = (response as List).map((e) => Cuenta.fromJson(e)).toList();
      return CuentaResponse(data: lista, message: 'Consulta exitosa');
    } catch (error) {
      return CuentaResponse(
        message: '${ErrorCommon.errorResponse}${error.toString()}',
      );
    }
  }

  @override
  Future<CuentaResponse> getCuentaByUsuario(int? idUsuario) async {
    try {
      final response = await dataSource
          .from('Cuenta')
          .select()
          .eq('id_usuario', idUsuario);

      final lista = (response as List).map((e) => Cuenta.fromJson(e)).toList();
      return CuentaResponse(
        data: lista,
        message: 'Cuentas del usuario obtenidas',
      );
    } catch (error) {
      return CuentaResponse(
        message: 'Error al obtener cuentas: ${error.toString()}',
      );
    }
  }

  @override
  Future<CuentaResponse> createCuenta(Cuenta cuenta) async {
    try {
      final response = await dataSource
          .from('Cuenta')
          .insert(cuenta.toJson())
          .select()
          .single();

      final cuentaCreada = Cuenta.fromJson(response);

      return CuentaResponse(
        data: cuentaCreada,
        message: 'Cuenta creada correctamente',
      );
    } catch (error) {
      return CuentaResponse(
        message: 'Error al crear cuenta: ${error.toString()}',
      );
    }
  }

  @override
  Future<CuentaResponse> updateCuenta(int id, Cuenta cuenta) async {
    try {
      final response = await dataSource
          .from('Cuenta')
          .update(cuenta.toJson())
          .eq('id', id)
          .select()
          .single();

      return CuentaResponse(
        data: Cuenta.fromJson(response),
        message: 'Cuenta actualizada correctamente',
      );
    } catch (error) {
      return CuentaResponse(
        message: 'Error al actualizar cuenta: ${error.toString()}',
      );
    }
  }

  @override
  Future<CuentaResponse> deleteCuenta(int id) async {
    try {
      await dataSource.from('Cuenta').delete().eq('id', id);
      return CuentaResponse(message: 'Cuenta eliminada correctamente');
    } catch (error) {
      return CuentaResponse(
        message: 'Error al eliminar cuenta: ${error.toString()}',
      );
    }
  }

  @override
  Future<CuentaResponse> transferirEntreCuentas({
    required int idCuentaOrigen,
    required int idCuentaDestino,
    required double monto,
  }) async {
    try {
      final origenData = await dataSource
          .from('Cuenta')
          .select()
          .eq('id', idCuentaOrigen)
          .single();

      final destinoData = await dataSource
          .from('Cuenta')
          .select()
          .eq('id', idCuentaDestino)
          .single();

      final cuentaOrigen = Cuenta.fromJson(origenData);
      final cuentaDestino = Cuenta.fromJson(destinoData);

      if (cuentaOrigen.saldo == null || cuentaDestino.saldo == null) {
        return CuentaResponse(message: 'Error: saldos no válidos.');
      }

      if (cuentaOrigen.saldo! < monto) {
        return CuentaResponse(
          message: 'Saldo insuficiente en la cuenta origen.',
        );
      }

      if (idCuentaOrigen == idCuentaDestino) {
        return CuentaResponse(
          message: 'No puedes transferir a la misma cuenta.',
        );
      }

      final nuevoSaldoOrigen = cuentaOrigen.saldo! - monto;
      final nuevoSaldoDestino = cuentaDestino.saldo! + monto;

      await dataSource
          .from('Cuenta')
          .update({'Saldo': nuevoSaldoOrigen})
          .eq('id', idCuentaOrigen);

      await dataSource
          .from('Cuenta')
          .update({'Saldo': nuevoSaldoDestino})
          .eq('id', idCuentaDestino);

      // ✅ Todo correcto
      return CuentaResponse(
        message:
            'Transferencia completada con éxito. Nuevo saldo origen: $nuevoSaldoOrigen, destino: $nuevoSaldoDestino',
      );
    } catch (error) {
      return CuentaResponse(
        message: 'Error al realizar transferencia: ${error.toString()}',
      );
    }
  }
}
