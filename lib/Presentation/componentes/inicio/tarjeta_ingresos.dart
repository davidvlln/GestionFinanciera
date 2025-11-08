import 'package:Caney/Core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TarjetaIngresos extends StatelessWidget {
  final String titulo;
  final String monto;

  const TarjetaIngresos({super.key, required this.titulo, required this.monto});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.Verde70.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(titulo, style: TextStyle(color: AppColors.Verde70.withOpacity(0.8))),
          const SizedBox(height: 5),
          Text(monto, style: TextStyle(color: AppColors.Verde70.withOpacity(0.9), fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
