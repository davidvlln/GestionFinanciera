import 'package:gestfinan/Data/models/usuario_model.dart';
import '../services/usuario_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Core/errors/error_ common.dart';

class UsuarioImp implements IUsuarioServ {
  final dataSource = Supabase.instance.client;

  @override
  Future<UsuarioResponse> getUsuario() async {
    UsuarioResponse userResponse = new UsuarioResponse();
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
  Future<UsuarioResponse> getValidarUsuario() {
    throw UnimplementedError();
  }
}
