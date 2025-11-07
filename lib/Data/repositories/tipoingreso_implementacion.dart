import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tipoingreso_model.dart';
import '../services/tipoingreso_service.dart';
import '../../Core/errors/error_common.dart';

class TipoIngresoImp implements ITipoIngresoServ {
  final dynamic dataSource;

  TipoIngresoImp({dynamic dataSourceClient})
    : dataSource = dataSourceClient ?? Supabase.instance.client;

  @override
  Future<TipoIngresoResponse> getTipoIngresos() async {
    try {
      final response = await dataSource.from('TipoIngreso').select();
      final lista = (response as List)
          .map((e) => TipoIngreso.fromJson(e))
          .toList();
      return TipoIngresoResponse(data: lista, message: 'Consulta exitosa');
    } catch (error) {
      return TipoIngresoResponse(
        data: null,
        message: '${ErrorCommon.errorResponse}${error.toString()}',
      );
    }
  }

  @override
  Future<TipoIngresoResponse> createTipoIngreso(TipoIngreso tipoIngreso) async {
    try {
      final response = await dataSource
          .from('TipoIngreso')
          .insert(tipoIngreso.toJson())
          .select()
          .single();

      final nuevo = TipoIngreso.fromJson(response);
      return TipoIngresoResponse(
        data: nuevo,
        message: 'Tipo de ingreso creado correctamente',
      );
    } catch (error) {
      return TipoIngresoResponse(
        data: null,
        message: 'Error al crear tipo de ingreso: ${error.toString()}',
      );
    }
  }

  @override
  Future<TipoIngresoResponse> updateTipoIngreso(
    int id,
    TipoIngreso tipoIngreso,
  ) async {
    try {
      await dataSource
          .from('TipoIngreso')
          .update(tipoIngreso.toJson())
          .eq('idTipoIngreso', id);
      return TipoIngresoResponse(message: 'Tipo de ingreso actualizado');
    } catch (error) {
      return TipoIngresoResponse(
        data: null,
        message: 'Error al actualizar tipo de ingreso: ${error.toString()}',
      );
    }
  }

  @override
  Future<TipoIngresoResponse> deleteTipoIngreso(int id) async {
    try {
      await dataSource.from('TipoIngreso').delete().eq('idTipoIngreso', id);
      return TipoIngresoResponse(message: 'Tipo de ingreso eliminado');
    } catch (error) {
      return TipoIngresoResponse(
        data: null,
        message: 'Error al eliminar tipo de ingreso: ${error.toString()}',
      );
    }
  }
}
