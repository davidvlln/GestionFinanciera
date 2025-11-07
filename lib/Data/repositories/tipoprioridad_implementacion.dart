import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tipoprioridad_model.dart';
import '../services/tipoprioridad_service.dart';
import '../../Core/errors/error_common.dart';

class TipoPrioridadImp implements ITipoPrioridadServ {
  final dynamic dataSource;

  TipoPrioridadImp({dynamic dataSourceClient})
    : dataSource = dataSourceClient ?? Supabase.instance.client;

  @override
  Future<TipoPrioridadResponse> getTipoPrioridades() async {
    try {
      final response = await dataSource.from('TipoPrioridad').select();
      final lista = (response as List)
          .map((e) => TipoPrioridad.fromJson(e))
          .toList();
      return TipoPrioridadResponse(data: lista, message: 'Consulta exitosa');
    } catch (error) {
      return TipoPrioridadResponse(
        data: null,
        message: '${ErrorCommon.errorResponse}${error.toString()}',
      );
    }
  }

  @override
  Future<TipoPrioridadResponse> createTipoPrioridad(
    TipoPrioridad tipoPrioridad,
  ) async {
    try {
      final response = await dataSource
          .from('TipoPrioridad')
          .insert(tipoPrioridad.toJson())
          .select()
          .single();

      return TipoPrioridadResponse(
        data: TipoPrioridad.fromJson(response),
        message: 'Tipo de prioridad creado correctamente',
      );
    } catch (error) {
      return TipoPrioridadResponse(
        data: null,
        message: 'Error al crear tipo de prioridad: ${error.toString()}',
      );
    }
  }

  @override
  Future<TipoPrioridadResponse> updateTipoPrioridad(
    int id,
    TipoPrioridad tipoPrioridad,
  ) async {
    try {
      final response = await dataSource
          .from('TipoPrioridad')
          .update(tipoPrioridad.toJson())
          .eq('idTipoPrioridad', id)
          .select()
          .single();

      return TipoPrioridadResponse(
        data: TipoPrioridad.fromJson(response),
        message: 'Tipo de prioridad actualizado correctamente',
      );
    } catch (error) {
      return TipoPrioridadResponse(
        data: null,
        message: 'Error al actualizar tipo de prioridad: ${error.toString()}',
      );
    }
  }

  @override
  Future<TipoPrioridadResponse> deleteTipoPrioridad(int id) async {
    try {
      await dataSource.from('TipoPrioridad').delete().eq('idTipoPrioridad', id);
      return TipoPrioridadResponse(
        message: 'Tipo de prioridad eliminado correctamente',
      );
    } catch (error) {
      return TipoPrioridadResponse(
        data: null,
        message: 'Error al eliminar tipo de prioridad: ${error.toString()}',
      );
    }
  }
}
