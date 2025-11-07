import 'package:flutter/material.dart';

class ItemHistorial extends StatelessWidget {
  final String iniciales;
  final String nombre;
  final String hora;
  final String monto;
  final String tipo;
  final bool esPositivo;

  const ItemHistorial({
    super.key,
    required this.iniciales,
    required this.nombre,
    required this.hora,
    required this.monto,
    required this.tipo,
    this.esPositivo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey.shade300,
            child: Text(
              iniciales,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nombre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(hora, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                monto,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: esPositivo ? Colors.green : Color(0xFFF24822),
                ),
              ),
              Text(tipo, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
