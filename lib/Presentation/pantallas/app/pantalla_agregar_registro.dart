import 'package:flutter/material.dart';

class PantallaAgregarRegistro extends StatelessWidget {
  const PantallaAgregarRegistro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Nuevo Registro'),
        backgroundColor: const Color(0xFF169C88),
      ),
      body: const Center(
        child: Text(
          'Aquí irá el formulario para agregar un nuevo registro',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
