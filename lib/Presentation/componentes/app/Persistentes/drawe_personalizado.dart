import 'package:Caney/Presentation/pantallas/app/pantalla_agregar_registro.dart';
import 'package:Caney/Presentation/pantallas/app/pantalla_gastos.dart';
import 'package:flutter/material.dart';
import 'package:Caney/generated/assets.dart';

class DrawerPersonalizado extends StatelessWidget {
  const DrawerPersonalizado({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(

            decoration: const BoxDecoration(
              color: Color(0xFF169C88),
            ),
            padding: EdgeInsetsGeometry.directional(start: 10, top: 0, end: 15, bottom: 0),
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Caney Menú',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentGeometry.directional(1.5, 1),
                  child: Image.asset(
                    Assets.imgLogo,
                    height: 220,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.app_registration),
            title: const Text('Nuevo Gasto/Ingreso'),
            onTap: () {
              Navigator.pop(context); // Cierra el drawer primero
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PantallaAgregarRegistro()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.sticky_note_2_outlined),
            title: const Text('Historial de Gastos'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PantallaGastos()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Acerca de'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
