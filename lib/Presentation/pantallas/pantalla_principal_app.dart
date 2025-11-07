import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:Caney/Core/utils/app_colors.dart';

import './seguridad/pantalla_acceso.dart';

import '../componentes/app/Persistentes/drawe_personalizado.dart';
import '../componentes/app/Persistentes/barra_superior_personalizada.dart';

import './app/pantalla_inicio_app.dart';
import './app/pantalla_estadisticas.dart';
import './app/pantalla_perfil.dart';
import './app/pantalla_agregar_registro.dart';

class PantallaPrincipalApp extends StatefulWidget {
  const PantallaPrincipalApp({super.key});

  @override
  State<PantallaPrincipalApp> createState() => _PantallaPrincipalAppState();
}

class _PantallaPrincipalAppState extends State<PantallaPrincipalApp> {
  int _selectedIndex = 0;

  static const List<Widget> _pantallas = <Widget>[
    PantallaInicioApp(),
    PantallaEstadisticas(),
    PantallaPerfil(),
  ];

  static final List<Color> _coloresDeFondo = <Color>[
    AppColors.Transparent,
    Color(0xFF22C5A1),
    const Color(0xFF4A148C),
    Colors.orange,
  ];

  static final List<Color> _coloresDeTexto = <Color>[
    AppColors.Verde70,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  static const List<double> _height = <double>[
    75.0,
    75.0,
    75.0,
    75.0,
  ];

  void _onItemTapped(int index) {
    if (index < _pantallas.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final titulos = ['', 'Estadísticas', 'Perfil', 'Ajustes'];

    return Scaffold(
      appBar: BarraSuperiorPersonalizada(
        title: _selectedIndex == 0 ? null : titulos[_selectedIndex],
        nombreCliente: _selectedIndex == 0 ? 'Carlos' : null,
        height: _height[_selectedIndex],
        alineacion: _selectedIndex == 0 ? AlineacionBarra.centro : AlineacionBarra.centro,
        backgroundColor: _coloresDeFondo[_selectedIndex],
        foregroundColor: _coloresDeTexto[_selectedIndex],
        onLogoutPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const PantallaAcceso()),
            (Route<dynamic> route) => false,
          );
        },
      ),
      drawer: const DrawerPersonalizado(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pantallas,
      ),
      floatingActionButton: SizedBox(
        height: 80.0,
        width: 80.0,
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF169C88),
          shape: const _HexagonBorder(),
          child: const Icon(Icons.add, size: 45, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PantallaAgregarRegistro()),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.Blanco,
        child: SizedBox(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(icon: Icons.home, index: 0),
              _buildNavItem(icon: Icons.bar_chart, index: 1),
              const SizedBox(width: 20),
              _buildNavItem(icon: Icons.person, index: 2),
              _buildNavItem(icon: Icons.settings, index: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required int index}) {
    Color iconColor;

    if (_selectedIndex == index) {
      final colorDeFondoSeleccionado = _coloresDeFondo[index];

      if (colorDeFondoSeleccionado == Colors.transparent || colorDeFondoSeleccionado == AppColors.Transparent) {
        iconColor = _coloresDeTexto[index];
      } else {
        iconColor = colorDeFondoSeleccionado;
      }
    } else {
      iconColor = Colors.grey;
    }

    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(30),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 36),
          ],
        ),
      ),
    );
  }
}

class _HexagonBorder extends ShapeBorder {
  const _HexagonBorder();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return getPath(rect);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getPath(rect);
  }

  Path getPath(Rect rect) {
    final path = Path();
    final double centerX = rect.width / 2;
    final double centerY = rect.height / 2;
    final double radius = rect.width / 2;

    for (int i = 0; i < 6; i++) {
      final double angle = (math.pi / 3) * i - (math.pi / 2);
      final double x = centerX + radius * math.cos(angle);
      final double y = centerY + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
