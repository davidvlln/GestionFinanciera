import 'package:flutter/material.dart';

class IndicadorGasto extends StatelessWidget {
  final String nombre;
  final String porcentaje;
  final Color color;

  const IndicadorGasto({
    super.key,
    required this.nombre,
    required this.porcentaje,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(nombre, style: const TextStyle(color: Colors.black54, fontSize: 14)),
        const SizedBox(height: 4),
        Text(
          porcentaje + '%',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 6,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            Container(
              height: 6,
              width: 60 * (double.parse(porcentaje.replaceAll('%', '')) / 100),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
