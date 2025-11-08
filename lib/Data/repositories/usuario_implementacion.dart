import 'package:Caney/Data/models/usuario_model.dart';
import '../services/usuario_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Core/errors/error_common.dart';

class UsuarioImp implements IUsuarioServ {
  final dynamic dataSource;

  UsuarioImp({dynamic dataSourceClient})
    : dataSource = dataSourceClient ?? Supabase.instance.client;

  @override
  Future<UsuarioResponse> getUsuario() async {
    try {
      final response = await dataSource.from('Usuario').select();
      final listUser = (response as List)
          .map((userResp) => Usuario.fromJson(userResp))
          .toList();

      return UsuarioResponse(
        data: listUser,
        message: 'Lista de usuarios obtenida',
      );
    } catch (error) {
      return UsuarioResponse(
        data: null,
        message: '${ErrorCommon.errorResponse}${error.toString()}',
      );
    }
  }

  @override
  Future<UsuarioResponse> getValidarUsuario(
    String nameOrEmail,
    String password,
  ) async {
    try {
      final response = await dataSource
          .from('Usuario')
          .select()
          .or('name.eq.$nameOrEmail,correo.eq.$nameOrEmail')
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
        message: 'Error en la autenticación: ${error.toString()}',
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
        message: 'Usuario actualizado correctamente',
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

  @override
  Future<UsuarioResponse> createUsuarioDesdeAuth() async {
    try {
      final supabase = Supabase.instance.client;
      final userAuth = supabase.auth.currentUser;

      if (userAuth == null) {
        return UsuarioResponse(message: 'No hay usuario autenticado');
      }

      final existingUser = await supabase
          .from('Usuario')
          .select()
          .eq('idAuth', userAuth.id)
          .maybeSingle();

      if (existingUser != null) {
        print('✅ Usuario ya existe en la tabla Usuario.');
        return UsuarioResponse(
          data: Usuario.fromJson(existingUser),
          message: 'Usuario ya registrado',
        );
      }

      print('📝 Insertando nuevo usuario en tabla Usuario...');

      final newUser = {
        'idAuth': userAuth.id,
        'correo': userAuth.email,
        'nombres':
            userAuth.userMetadata?['full_name'] ??
            userAuth.userMetadata?['name'] ??
            userAuth.email?.split('@').first ??
            'Usuario',
        'telefono': userAuth.phone ?? '',
        'name': userAuth.email?.split('@').first ?? '',
        'password': null, // No se usa en Google Sign-In
        'ape_paterno': '',
        'ape_materno': '',
      };

      final inserted = await supabase
          .from('Usuario')
          .insert(newUser)
          .select()
          .single();

      print(
        '✅ Usuario insertado correctamente en Usuario: ${inserted['idUser']}',
      );

      return UsuarioResponse(
        data: Usuario.fromJson(inserted),
        message: 'Usuario creado correctamente desde Auth',
      );
    } catch (error) {
      print('❌ Error al crear usuario desde Auth: $error');
      return UsuarioResponse(
        message: 'Error al crear usuario desde Auth: $error',
        data: null,
      );
    }
  }
}
