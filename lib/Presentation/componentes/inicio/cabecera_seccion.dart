import 'package:flutter/material.dart';
import 'package:Caney/Core/utils/app_colors.dart';

class CabeceraSeccion extends StatelessWidget {
  final String titulo;
  final Color colorTexto;
  final bool verMas;


  const CabeceraSeccion({super.key, required this.titulo, required this.colorTexto, required this.verMas});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titulo, style: TextStyle(color: colorTexto, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        if (verMas == true) Text('Ver todo', style: TextStyle(color: AppColors.Verde70.withOpacity(0.5), fontWeight: FontWeight.w600)),
      ],
    );
  }
}
