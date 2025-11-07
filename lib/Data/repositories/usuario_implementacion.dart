import 'package:gestfinan/Data/models/usuario_model.dart';
import '../services/usuario_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Core/errors/error_ common.dart';

class UsuarioImp implements IUsuarioServ {
  final dataSource = Supabase.instance.client;

  @override
  Future<UsuarioResponse> getUsuario() async {
    UsuarioResponse userResponse = UsuarioResponse();
    try {
      final response = await dataSource.from('Usuario').select();
      final listUser = (response as List)
          .map((userResp) => Usuario.fromJson(userResp))
          .toList();
      userResponse = UsuarioResponse(data: listUser, message: '');
    } catch (error) {
      userResponse = UsuarioResponse(
        data: null,
        message: '${ErrorCommon.errorResponse}${error.toString()}',
      );
    }
    return userResponse;
  }

  @override
  Future<UsuarioResponse> getValidarUsuario(
    String name,
    String password,
  ) async {
    try {
      final response = await dataSource
          .from('Usuario')
          .select()
          .eq('name', name)
          .eq('password', password)
          .maybeSingle();

      if (response == null) {
        return UsuarioResponse(message: 'Usuario no encontrado', data: null);
      }

      return UsuarioResponse(
        data: Usuario.fromJson(response),
        message: 'Login exitoso',
      );
    } catch (error) {
      return UsuarioResponse(
        message: '${ErrorCommon.errorResponse}${error.toString()}',
        data: null,
      );
    }
  }

  @override
  Future<UsuarioResponse> createUsuario(Usuario usuario) async {
    try {
      final response = await dataSource
          .from('Usuario')
          .insert(usuario.toJson())
          .select()
          .single();
      return UsuarioResponse(
        data: Usuario.fromJson(response),
        message: 'Usuario creado correctamente',
      );
    } catch (error) {
      return UsuarioResponse(message: 'Error al crear usuario: $error');
    }
  }

  @override
  Future<UsuarioResponse> updateUsuario(int id, Usuario usuario) async {
    try {
      final response = await dataSource
          .from('Usuario')
          .update(usuario.toJson())
          .eq('idUser', id)
          .select()
          .single();
      return UsuarioResponse(
        data: Usuario.fromJson(response),
        message: 'Usuario actualizado',
      );
    } catch (error) {
      return UsuarioResponse(message: 'Error al actualizar usuario: $error');
    }
  }

  @override
  Future<UsuarioResponse> deleteUsuario(int id) async {
    try {
      await dataSource.from('Usuario').delete().eq('idUser', id);
      return UsuarioResponse(message: 'Usuario eliminado correctamente');
    } catch (error) {
      return UsuarioResponse(message: 'Error al eliminar usuario: $error');
    }
  }
}
