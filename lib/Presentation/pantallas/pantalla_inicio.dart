import 'dart:async';

import 'package:flutter/material.dart';
import 'package:Caney/Presentation/pantallas/pantalla_bienvenida.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const PantallaBienvenida();
  }
}

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión Financiera'),
      ),
      body: const Center(
        child: Text('¡Bienvenido!'),
      ),
    );
  }
}
