import 'package:flutter/material.dart';

class PantallaPrincipalApp extends StatelessWidget {
  const PantallaPrincipalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Principal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
            },
          )
        ],
      ),
      body: const Center(
        child: Text('¡Has iniciado sesión!'),
      ),
    );
  }
}
