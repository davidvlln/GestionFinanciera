import 'package:flutter/material.dart';
import 'package:Caney/Core/utils/app_colors.dart';

class CabeceraSeccion extends StatelessWidget {
  final String titulo;
  final Color colorTexto;
  final bool verMas;
  final Widget? direccion;

  const CabeceraSeccion({
    super.key,
    required this.titulo,
    required this.colorTexto,
    required this.verMas,
    this.direccion,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titulo, style: TextStyle(color: colorTexto, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        if (verMas)
          TextButton(
            onPressed: () {
              if (direccion != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => direccion!),
                );
              }
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Ver todo',
              style: TextStyle(color: AppColors.Verde70.withOpacity(0.5), fontWeight: FontWeight.w600)
            ),
          )
      ],
    );
  }
}
