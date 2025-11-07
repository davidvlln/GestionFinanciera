import 'package:flutter/material.dart';

class ItemTransaccion extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String subtitulo;
  final String monto;
  final Color colorIcono;

  const ItemTransaccion({
    super.key,
    required this.icono,
    required this.titulo,
    required this.subtitulo,
    required this.monto,
    required this.colorIcono,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF1A4D5D),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: colorIcono.withOpacity(0.2),
            child: Icon(icono, color: colorIcono),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text(subtitulo, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
              ],
            ),
          ),
          Text(monto, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
