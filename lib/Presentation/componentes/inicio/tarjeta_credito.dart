import 'package:flutter/material.dart';
import 'package:Caney/Core/utils/app_colors.dart';

class TarjetaCredito extends StatelessWidget {
  const TarjetaCredito({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.Verde70,
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          ClipPath(
            clipper: _RecortadorTarjeta(),
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: const Color(0xFFF95B51),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'S/10,000',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const Text('Total Ahorrado', style: TextStyle(color: Colors.white70)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text("BCP", style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('VISA', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                const SizedBox(height: 0),
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 25,
            child: Text('07/11/2025', style: TextStyle(color: Colors.white.withOpacity(0.7))),
          ),
        ],
      ),
    );
  }
}

class _RecortadorTarjeta extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.8, 0);
    path.lineTo(size.width, size.height * 0.3);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
