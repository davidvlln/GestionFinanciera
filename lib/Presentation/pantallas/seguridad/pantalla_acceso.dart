import 'package:Caney/Data/models/usuario_model.dart';
import 'package:flutter/material.dart';
import '../../componentes/acceso/boton_principal.dart';
import '../pantalla_principal_app.dart';
import 'pantalla_registro.dart';
import 'package:Caney/generated/assets.dart';
import 'package:Caney/Core/utils/app_colors.dart';
import '../../../Data/repositories/usuario_implementacion.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PantallaAcceso extends StatefulWidget {
  const PantallaAcceso({super.key});

  @override
  State<PantallaAcceso> createState() => _PantallaAccesoState();
}

class _PantallaAccesoState extends State<PantallaAcceso> {
  final _formKey = GlobalKey<FormState>();
  Usuario usuario = Usuario();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) =>
            Center(child: CircularProgressIndicator(color: AppColors.Verde70)),
      );

      final signIn = GoogleSignIn.instance;

      await signIn.initialize(
        clientId:
            '725764042049-4eis5c81g3m2icmt95avdosm2hduu79o.apps.googleusercontent.com', // Android
        serverClientId:
            '725764042049-sth5r87o97epq1ud61avudcahjnqbc3s.apps.googleusercontent.com', // Web
      );

      final googleUser = await signIn.authenticate();

      final auth = googleUser.authentication;

      final response = await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: auth.idToken!,
        accessToken: auth.idToken!,
      );

      if (context.mounted) Navigator.pop(context);

      if (response.session != null) {
        final usuarioRepo = UsuarioImp();
        final usuarioResponse = await usuarioRepo.createUsuarioDesdeAuth();

        final usuarioDB = usuarioResponse.data as Usuario?;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Bienvenido ${usuarioDB?.nombres ?? googleUser.displayName ?? 'Usuario'}!',
            ),
            backgroundColor: AppColors.Verde70,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => PantallaPrincipalApp(
              user:
                  usuarioDB ??
                  Usuario(
                    nombres: googleUser.displayName,
                    correo: googleUser.email,
                  ),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al iniciar sesión con Google.'),
            backgroundColor: AppColors.Rojo70,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.Rojo70),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Verde70,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Hola!',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Bienvenido a Caney',
                        style: TextStyle(fontSize: 20, color: Colors.white70),
                      ),
                    ],
                  ),
                  Image.asset(Assets.imgMoneda, width: 120, height: 120),
                ],
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.75,
              minChildSize: 0.75,
              maxChildSize: 1,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF5E5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                      children: [
                        Center(
                          child: Container(
                            height: 5,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.Verde70,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _emailController,
                          decoration: _buildInputDecoration(
                            hintText: 'Usuario o Correo',
                            icon: Icons.email_outlined,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa tu usuario o correo';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: _buildInputDecoration(
                            hintText: 'Contraseña',
                            icon: Icons.lock_outline,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa tu contraseña';
                            }
                            if (value.length < 6) {
                              return 'Debe tener al menos 6 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        BotonPrincipal(
                          texto: 'Acceder',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final usuarioRepo = UsuarioImp();
                              final nameOrEmail = _emailController.text.trim();
                              final password = _passwordController.text.trim();

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) => Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.Verde70,
                                  ),
                                ),
                              );

                              final response = await usuarioRepo
                                  .getValidarUsuario(nameOrEmail, password);

                              if (context.mounted) Navigator.pop(context);

                              if (response.data != null) {
                                usuario = response.data;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Bienvenido ${usuario.nombres ?? usuario.correo}!',
                                    ),
                                    backgroundColor: AppColors.Verde70,
                                  ),
                                );

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        PantallaPrincipalApp(user: usuario),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      response.message ??
                                          'Credenciales inválidas',
                                    ),
                                    backgroundColor: AppColors.Rojo70,
                                  ),
                                );
                              }
                            }
                          },
                        ),

                        // 🔹 Botón de Google debajo
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => loginWithGoogle(context),
                          icon: Image.asset(
                            'assets/img/google.png',
                            width: 24,
                            height: 24,
                          ),
                          label: const Text('Continuar con Google'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 1,
                          ),
                        ),

                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("¿Aún no tienes cuenta?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const PantallaRegistro(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Regístrate ahora',
                                style: TextStyle(
                                  color: Color(0xFF169C88),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon, color: Colors.grey),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 20.0,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: const Color(0xFF169C88), width: 2.0),
      ),
    );
  }
}
