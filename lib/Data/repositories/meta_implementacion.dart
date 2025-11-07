import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/meta_model.dart';
import '../models/objetivo_model.dart';
import '../services/meta_service.dart';
import '../../Core/errors/error_common.dart';

class MetaImp implements IMetaServ {
  final dynamic dataSource;

  MetaImp({dynamic dataSourceClient})
    : dataSource = dataSourceClient ?? Supabase.instance.client;

  @override
  Future<MetaResponse> getMetas() async {
    try {
      final response = await dataSource.from('Meta').select();
      final lista = (response as List).map((e) => Meta.fromJson(e)).toList();
      return MetaResponse(data: lista, message: 'Consulta exitosa');
    } catch (error) {
      return MetaResponse(
        message: '${ErrorCommon.errorResponse}${error.toString()}',
      );
    }
  }

  @override
  Future<MetaResponse> createMeta(Meta meta) async {
    try {
      if (meta.fechaInicio == null || meta.fechaLimite == null) {
        throw Exception('Debe indicar fechaInicio y fechaLimite.');
      }
      if ((meta.montoObjetivo ?? 0) <= 0) {
        throw Exception('El montoObjetivo debe ser mayor a 0.');
      }

      final response = await dataSource
          .from('Meta')
          .insert(meta.toJson())
          .select()
          .single();

      final nuevaMeta = Meta.fromJson(response);

      final inicio = meta.fechaInicio!;
      final fin = meta.fechaLimite!;
      final meses =
          (fin.year - inicio.year) * 12 + (fin.month - inicio.month) + 1;

      if (meses <= 0) {
        throw Exception(
          'La fecha límite debe ser posterior a la fecha de inicio.',
        );
      }

      final total = meta.montoObjetivo!;
      final base = total / meses;

      final List<Map<String, dynamic>> objetivos = [];
      double acumulado = 0.0;

      for (int i = 0; i < meses; i++) {
        final fechaObjetivo = DateTime(inicio.year, inicio.month + i, 1);

        double monto = (i < meses - 1)
            ? double.parse(base.toStringAsFixed(2))
            : double.parse((total - acumulado).toStringAsFixed(2));

        acumulado = double.parse((acumulado + monto).toStringAsFixed(2));

        final objetivo = Objetivo(
          idMeta: nuevaMeta.idMeta,
          desObjetivo: 'Ahorro mes ${i + 1}',
          montoEsperado: monto,
          estado: 'Pendiente',
          fechaObjetivo: fechaObjetivo,
        );

        objetivos.add(objetivo.toJson());
      }

      await dataSource.from('Objetivo').insert(objetivos);

      return MetaResponse(
        data: nuevaMeta,
        message:
            'Meta creada con $meses objetivos mensuales. Total S/.${total.toStringAsFixed(2)}',
      );
    } catch (error) {
      return MetaResponse(message: 'Error al crear meta: ${error.toString()}');
    }
  }

  @override
  Future<MetaResponse> updateMeta(int id, Meta meta) async {
    try {
      final response = await dataSource
          .from('Meta')
          .update(meta.toJson())
          .eq('idMeta', id)
          .select()
          .single();

      final metaActualizada = Meta.fromJson(response);

      return MetaResponse(
        data: metaActualizada,
        message: 'Meta actualizada correctamente',
      );
    } catch (error) {
      return MetaResponse(
        message: 'Error al actualizar meta: ${error.toString()}',
      );
    }
  }

  @override
  Future<MetaResponse> deleteMeta(int id) async {
    try {
      await dataSource.from('Objetivo').delete().eq('idMeta', id);

      await dataSource.from('Meta').delete().eq('idMeta', id);

      return MetaResponse(message: 'Meta y objetivos eliminados correctamente');
    } catch (error) {
      return MetaResponse(
        message: 'Error al eliminar meta: ${error.toString()}',
      );
    }
  }
}
