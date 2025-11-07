import '../models/objetivo_model.dart';

abstract class IObjetivoServ {
  Future<ObjetivoResponse> getObjetivos();
  Future<ObjetivoResponse> createObjetivo(Objetivo obj);
  Future<ObjetivoResponse> updateObjetivo(int id, Objetivo obj);
  Future<ObjetivoResponse> deleteObjetivo(int id);
}
