import 'package:flutter/material.dart';
import '../../componentes/acceso/boton_principal.dart';
import 'package:Caney/generated/assets.dart';
import 'package:Caney/Core/utils/app_colors.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key});

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final _formKey = GlobalKey<FormState>();

  final _usuarioController = TextEditingController();
  final _nombresController = TextEditingController();
  final _apellidoPaternoController = TextEditingController();
  final _apellidoMaternoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _usuarioController.dispose();
    _nombresController.dispose();
    _apellidoPaternoController.dispose();
    _apellidoMaternoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5E5),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: AppColors.Verde70),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text('Volver al login', style: TextStyle(color: AppColors.Verde70, fontSize: 16)),
                      const Spacer(),
                      Image.asset(
                        Assets.imgMoneda,
                        width: 75,
                        height: 75,
                      ),
                    ],
                  ),
                  const SizedBox(height: 0),
                  Text(
                    'Regístrate!',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: AppColors.Verde70,
                    ),
                  ),
                  const SizedBox(height: 30),

                  TextFormField(
                    controller: _usuarioController,
                    decoration: _buildInputDecoration(hintText: 'Usuario', icon: Icons.person_outline),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ingresa un nombre de usuario';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nombresController,
                    decoration: _buildInputDecoration(hintText: 'Nombres', icon: Icons.person_outline),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ingresa tus nombres';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsetsGeometry.directional(start: 15),
                    child: Text('Apellidos', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.Verde70)),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _apellidoPaternoController,
                          decoration: _buildInputDecoration(hintText: 'Paterno', icon: Icons.person_outline),
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Ingresa tu apellido';
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _apellidoMaternoController,
                          decoration: _buildInputDecoration(hintText: 'Materno', icon: Icons.person_outline),
                           validator: (value) {
                            if (value == null || value.isEmpty) return 'Ingresa tu apellido';
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _buildInputDecoration(hintText: 'Correo', icon: Icons.email_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ingresa tu correo';
                      if (!value.contains('@')) return 'Ingresa un correo válido';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: _buildInputDecoration(hintText: 'Contraseña', icon: Icons.lock_outline),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ingresa una contraseña';
                      if (value.length < 6) return 'La contraseña debe tener al menos 6 caracteres';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: _buildInputDecoration(hintText: 'Confirmar Contraseña', icon: Icons.lock_outline),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Confirma tu contraseña';
                      if (value != _passwordController.text) return 'Las contraseñas no coinciden';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: _buildInputDecoration(hintText: 'Teléfono', icon: Icons.phone_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ingresa tu teléfono';
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  BotonPrincipal(
                    texto: 'Registrarse',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Procesando registro...')),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({required String hintText, required IconData icon}) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon, color: Colors.grey),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
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
        borderSide: BorderSide(
          color: const Color(0xFF169C88),
          width: 2.0,
        ),
      ),
    );
  }
}
