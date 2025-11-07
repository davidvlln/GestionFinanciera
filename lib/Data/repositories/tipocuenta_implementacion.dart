import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tipocuenta_model.dart';
import '../services/tipocuenta_service.dart';
import '../../Core/errors/error_common.dart';

class TipoCuentaImp implements ITipoCuentaServ {
  final dynamic dataSource;

  TipoCuentaImp({dynamic dataSourceClient})
    : dataSource = dataSourceClient ?? Supabase.instance.client;

  @override
  Future<TipoCuentaResponse> getTipoCuenta() async {
    try {
      final response = await dataSource.from('TipoCuenta').select();

      final listTipoCuenta = (response as List)
          .map((item) => TipoCuenta.fromJson(item))
          .toList();

      return TipoCuentaResponse(
        data: listTipoCuenta,
        message: 'Consulta exitosa',
      );
    } catch (error) {
      return TipoCuentaResponse(
        message: '${ErrorCommon.errorResponse}${error.toString()}',
      );
    }
  }

  @override
  Future<TipoCuentaResponse> createTipoCuenta(TipoCuenta tipoCuenta) async {
    try {
      final response = await dataSource
          .from('TipoCuenta')
          .insert(tipoCuenta.toJson())
          .select()
          .single();

      final tipoCuentaCreada = TipoCuenta.fromJson(response);

      return TipoCuentaResponse(
        data: tipoCuentaCreada,
        message: 'Tipo de cuenta creado correctamente',
      );
    } catch (error) {
      return TipoCuentaResponse(
        data: null,
        message: 'Error al crear tipo de cuenta: ${error.toString()}',
      );
    }
  }

  @override
  Future<TipoCuentaResponse> updateTipoCuenta(
    int id,
    TipoCuenta tipoCuenta,
  ) async {
    try {
      await dataSource
          .from('TipoCuenta')
          .update(tipoCuenta.toJson())
          .eq('idTipoCuenta', id);
      return TipoCuentaResponse(message: 'Tipo de cuenta actualizado');
    } catch (error) {
      return TipoCuentaResponse(
        message: 'Error al actualizar: ${error.toString()}',
      );
    }
  }

  @override
  Future<TipoCuentaResponse> deleteTipoCuenta(int id) async {
    try {
      await dataSource.from('TipoCuenta').delete().eq('idTipoCuenta', id);
      return TipoCuentaResponse(message: 'Tipo de cuenta eliminado');
    } catch (error) {
      return TipoCuentaResponse(
        message: 'Error al eliminar: ${error.toString()}',
      );
    }
  }
}
