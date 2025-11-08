import 'package:flutter/material.dart';

enum EstadoActividad { pendiente, completada, noCompletada }

class ItemActividad extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final String hora;
  final EstadoActividad estado;
  final VoidCallback? onTap;

  const ItemActividad({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.hora,
    this.estado = EstadoActividad.pendiente,
    this.onTap,
  });

  Color _getColor() {
    switch (estado) {
      case EstadoActividad.completada:
        return const Color(0xFF00A98B);
      case EstadoActividad.noCompletada:
        return Colors.red;
      case EstadoActividad.pendiente:
      default:
        return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    final bool estaActivo = estado != EstadoActividad.pendiente;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: IntrinsicHeight(
        child: Row(
          children: [
            SizedBox(
              width: 30,
              child: Column(
                children: [
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: estaActivo ? color : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(color: color, width: 2),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 2,
                      color: Colors.grey.shade300,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: estaActivo ? color : Colors.black87,
                      ),
                    ),
                    Text(
                      subtitulo,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              hora,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
