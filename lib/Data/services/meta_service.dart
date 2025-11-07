import '../models/meta_model.dart';

abstract class IMetaServ {
  Future<MetaResponse> getMetas();
  Future<MetaResponse> createMeta(Meta meta);
  Future<MetaResponse> updateMeta(int id, Meta meta);
  Future<MetaResponse> deleteMeta(int id);
}
