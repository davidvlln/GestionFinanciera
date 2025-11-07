import 'package:Caney/Presentation/pantallas/carga/pantalla_bienvenida.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pantalla_acceso.dart'; // <-- Cambio aquí
import '../pantalla_principal_app.dart';

class PantallaValidacion extends StatefulWidget {
  const PantallaValidacion({super.key});

  @override
  State<PantallaValidacion> createState() => _PantallaValidacionState();
}

class _PantallaValidacionState extends State<PantallaValidacion> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _redirigir();
    });
  }

  Future<void> _redirigir() async {
    await Future.delayed(const Duration(milliseconds: 2500)); // Aumentado para que se vea el splash

    if (!mounted) return;

    final sesion = Supabase.instance.client.auth.currentSession;

    if (sesion != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const PantallaPrincipalApp()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const PantallaAcceso()), // <-- Cambio aquí
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Usamos la pantalla de bienvenida como "splash screen" durante la validación
    return const PantallaBienvenida();
  }
}
