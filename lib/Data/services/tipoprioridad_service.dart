import '../models/tipoprioridad_model.dart';

abstract class ITipoPrioridadServ {
  Future<TipoPrioridadResponse> getTipoPrioridades();
  Future<TipoPrioridadResponse> createTipoPrioridad(
    TipoPrioridad tipoPrioridad,
  );
  Future<TipoPrioridadResponse> updateTipoPrioridad(
    int id,
    TipoPrioridad tipoPrioridad,
  );
  Future<TipoPrioridadResponse> deleteTipoPrioridad(int id);
}
