

class Usuario {
  final int? idUser;
  final String? name;
  final String? password;
  final String? nombres;
  final String? apePaterno;
  final String? apeMaterno;
  final String? correo;
  final String? telefono;
  
  Usuario({
    this.idUser,
    this.name,
    this.password,
    this.nombres,
    this.apePaterno,
    this.apeMaterno,
    this.correo,
    this.telefono,
  });

 

  factory Usuario.fromJson(Map<String, dynamic> response) => Usuario(
    idUser: response['idUser'] as int,
    name: response['name'] as String,
    password: response['password'] as String,
    nombres: response['nombres'] as String,
    apePaterno: response['ape_paterno'] as String,
    apeMaterno: response['ape_materno'] as String,
    correo: response['correo'] as String,
    telefono: response['telefono'] as String,
  );

 

  Map<String, dynamic> toJson() => {
    if (idUser != null) 'idUser': idUser,
    if (name != null) 'name': name,
    if (password !=null) 'password':password,
    if (nombres !=null) 'nombres': nombres,
    if (apePaterno !=null) 'ape_paterno':apePaterno,
    if (apeMaterno !=null) 'ape_materno':apeMaterno,
    if (correo !=null) 'correo' :correo,
    if (telefono !=null) 'telefono':telefono
  };
}



class UsuarioResponse{
  final dynamic data;
  final String? message;

  UsuarioResponse({this.data,this.message});

  factory UsuarioResponse.fromJson(Map<String,dynamic> response)=>UsuarioResponse(
    data: response['data'] as String,
    message: response['message'] as String
  );
}

