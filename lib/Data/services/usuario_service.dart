import '../models/usuario_model.dart';

abstract class IUsuarioServ {

Future<UsuarioResponse> getUsuario();
Future<UsuarioResponse> getValidarUsuario();

} 

