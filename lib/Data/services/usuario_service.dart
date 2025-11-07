import '../models/usuario_model.dart';

abstract class IUsuarioServ {
  Future<UsuarioResponse> getUsuario();
  Future<UsuarioResponse> getValidarUsuario(String name, String password);
  Future<UsuarioResponse> createUsuario(Usuario usuario);
  Future<UsuarioResponse> updateUsuario(int id, Usuario usuario);
  Future<UsuarioResponse> deleteUsuario(int id);
}
