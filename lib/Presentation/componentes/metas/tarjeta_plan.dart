import 'package:flutter/material.dart';

class TarjetaPlan extends StatelessWidget {
  const TarjetaPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF00A98B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Comprar Computadora',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      'S/4 060.00',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const Text(' de ', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    Text(
                      'S/6 110.00',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          _buildGraficoProgreso(),
        ],
      ),
    );
  }

  Widget _buildGraficoProgreso() {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 0.75,
            strokeWidth: 8,
            backgroundColor: Colors.white.withOpacity(0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          const Center(
            child: Text(
              '75%',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
