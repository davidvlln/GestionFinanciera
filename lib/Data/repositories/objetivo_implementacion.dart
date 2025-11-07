import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/objetivo_model.dart';
import '../services/objetivo_service.dart';
import '../../Core/errors/error_common.dart';

class ObjetivoImp implements IObjetivoServ {
  final dynamic dataSource;

  ObjetivoImp({dynamic dataSourceClient})
    : dataSource = dataSourceClient ?? Supabase.instance.client;

  @override
  Future<ObjetivoResponse> getObjetivos() async {
    try {
      final response = await dataSource.from('Objetivo').select();
      final lista = (response as List)
          .map((e) => Objetivo.fromJson(e))
          .toList();

      return ObjetivoResponse(data: lista, message: 'Consulta exitosa');
    } catch (error) {
      return ObjetivoResponse(
        data: null,
        message: '${ErrorCommon.errorResponse}${error.toString()}',
      );
    }
  }

  @override
  Future<ObjetivoResponse> createObjetivo(Objetivo obj) async {
    try {
      final response = await dataSource
          .from('Objetivo')
          .insert(obj.toJson())
          .select()
          .single();

      final nuevoObjetivo = Objetivo.fromJson(response);

      return ObjetivoResponse(
        data: nuevoObjetivo,
        message: 'Objetivo creado correctamente',
      );
    } catch (error) {
      return ObjetivoResponse(
        data: null,
        message: 'Error al crear objetivo: ${error.toString()}',
      );
    }
  }

  @override
  Future<ObjetivoResponse> updateObjetivo(int id, Objetivo obj) async {
    try {
      final response = await dataSource
          .from('Objetivo')
          .update(obj.toJson())
          .eq('idObjetivo', id)
          .select()
          .single();

      final objetivoActualizado = Objetivo.fromJson(response);

      return ObjetivoResponse(
        data: objetivoActualizado,
        message: 'Objetivo actualizado correctamente',
      );
    } catch (error) {
      return ObjetivoResponse(
        data: null,
        message: 'Error al actualizar objetivo: ${error.toString()}',
      );
    }
  }

  @override
  Future<ObjetivoResponse> deleteObjetivo(int id) async {
    try {
      await dataSource.from('Objetivo').delete().eq('idObjetivo', id);
      return ObjetivoResponse(message: 'Objetivo eliminado correctamente');
    } catch (error) {
      return ObjetivoResponse(
        data: null,
        message: 'Error al eliminar objetivo: ${error.toString()}',
      );
    }
  }

  Future<ObjetivoResponse> completarObjetivo(int id) async {
    try {
      final objetivoData = await dataSource
          .from('Objetivo')
          .select()
          .eq('idObjetivo', id)
          .maybeSingle();

      if (objetivoData == null) {
        return ObjetivoResponse(message: 'Objetivo no encontrado');
      }

      final objetivo = Objetivo.fromJson(objetivoData);

      if (objetivo.estado == 'Cumplido') {
        return ObjetivoResponse(message: 'Este objetivo ya está cumplido');
      }

      final response = await dataSource
          .from('Objetivo')
          .update({'estado': 'Cumplido'})
          .eq('idObjetivo', id)
          .select()
          .single();

      final objetivoCumplido = Objetivo.fromJson(response);

      try {
        await dataSource.rpc(
          'actualizar_progreso_meta',
          params: {
            'p_id_meta': objetivoCumplido.idMeta,
            'p_monto': objetivoCumplido.montoEsperado ?? 0.0,
          },
        );
      } catch (_) {}

      return ObjetivoResponse(
        data: objetivoCumplido,
        message: 'Objetivo marcado como cumplido correctamente',
      );
    } catch (error) {
      return ObjetivoResponse(
        data: null,
        message: 'Error al completar objetivo: ${error.toString()}',
      );
    }
  }
}
