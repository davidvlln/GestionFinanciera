import 'package:flutter/material.dart';

class ItemActividad extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final String hora;
  final bool estaCompletado;

  const ItemActividad({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.hora,
    this.estaCompletado = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
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
                    color: estaCompletado ? const Color(0xFF00A98B) : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade400, width: 2),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: estaCompletado ? const Color(0xFF00A98B) : Colors.black87,
                  ),
                ),
                Text(
                  subtitulo,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            hora,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
