import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tipoegreso_model.dart';
import '../services/tipoegreso_service.dart';
import '../../Core/errors/error_common.dart';

class TipoEgresoImp implements ITipoEgresoServ {
  final dynamic dataSource;

  TipoEgresoImp({dynamic dataSourceClient})
    : dataSource = dataSourceClient ?? Supabase.instance.client;

  @override
  Future<TipoEgresoResponse> getTipoEgreso() async {
    try {
      final response = await dataSource.from('TipoEgreso').select();
      final lista = (response as List)
          .map((e) => TipoEgreso.fromJson(e))
          .toList();
      return TipoEgresoResponse(data: lista, message: 'Consulta exitosa');
    } catch (error) {
      return TipoEgresoResponse(
        data: null,
        message: '${ErrorCommon.errorResponse}${error.toString()}',
      );
    }
  }

  @override
  Future<TipoEgresoResponse> createTipoEgreso(TipoEgreso tipoEgreso) async {
    try {
      final response = await dataSource
          .from('TipoEgreso')
          .insert(tipoEgreso.toJson())
          .select()
          .single();

      final nuevoTipo = TipoEgreso.fromJson(response);

      return TipoEgresoResponse(
        data: nuevoTipo,
        message: 'Tipo de egreso creado correctamente',
      );
    } catch (error) {
      return TipoEgresoResponse(
        data: null,
        message: 'Error al crear tipo de egreso: ${error.toString()}',
      );
    }
  }

  @override
  Future<TipoEgresoResponse> updateTipoEgreso(
    int id,
    TipoEgreso tipoEgreso,
  ) async {
    try {
      await dataSource
          .from('TipoEgreso')
          .update(tipoEgreso.toJson())
          .eq('id', id);
      return TipoEgresoResponse(
        message: 'Tipo de egreso actualizado correctamente',
      );
    } catch (error) {
      return TipoEgresoResponse(
        data: null,
        message: 'Error al actualizar tipo de egreso: ${error.toString()}',
      );
    }
  }

  @override
  Future<TipoEgresoResponse> deleteTipoEgreso(int id) async {
    try {
      await dataSource.from('TipoEgreso').delete().eq('id', id);
      return TipoEgresoResponse(
        message: 'Tipo de egreso eliminado correctamente',
      );
    } catch (error) {
      return TipoEgresoResponse(
        data: null,
        message: 'Error al eliminar tipo de egreso: ${error.toString()}',
      );
    }
  }


  @override
  Future<TipoEgresoResponse> getTipoEgresoPorID(int? id) async {
    try{
    final response = await dataSource
        .from('TipoEgreso')
        .select()
        .eq('id',id);
      
    
    final lista = (response as List)
          .map((e) => TipoEgreso.fromJson(e))
          .toList();
      return TipoEgresoResponse(data: lista, message: 'Consulta exitosa');

    }catch(error){
      return TipoEgresoResponse(data: null,message: 'Error al obtener tipo de egreso:${error.toString()}'); 
    }
  }
  
}
