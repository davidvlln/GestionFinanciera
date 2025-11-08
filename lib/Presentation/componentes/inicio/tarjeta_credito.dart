import 'package:flutter/material.dart';
import 'package:Caney/Core/utils/app_colors.dart';

// 1. Convertido a StatefulWidget
class TarjetaCredito extends StatefulWidget {
  const TarjetaCredito({super.key});

  @override
  State<TarjetaCredito> createState() => _TarjetaCreditoState();
}

class _TarjetaCreditoState extends State<TarjetaCredito> {
  final _controladorPagina = PageController(viewportFraction: 0.9);
  int _paginaActual = 0;

  final List<Map<String, dynamic>> _datosTarjetas = [
    {
      'monto': 'S/10,000',
      'titulo': 'Total Ahorrado',
      'nombre': 'BCP',
      'tipo': 'VISA',
      'fecha': '07/11/2025',
      'colorFondo': AppColors.Verde70,
      'colorRecorte': const Color(0xFFF95B51),
    },
    {
      'monto': 'S/5,250',
      'titulo': 'Ahorro Interbank',
      'nombre': 'Carlos Miller',
      'tipo': 'MASTERCARD',
      'fecha': '12/10/2027',
      'colorFondo': Colors.indigo.shade700,
      'colorRecorte': Colors.amber.shade700,
    },
  ];

  @override
  void initState() {
    super.initState();
    _controladorPagina.addListener(() {
      if (_controladorPagina.page != null) {
        setState(() {
          _paginaActual = _controladorPagina.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _controladorPagina.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 220,
          width: 400,
          child: PageView.builder(
            controller: _controladorPagina,
            itemCount: _datosTarjetas.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _TarjetaIndividual(datos: _datosTarjetas[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        _buildIndicadorPagina(),
      ],
    );
  }

  Widget _buildIndicadorPagina() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_datosTarjetas.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _paginaActual == index ? 24.0 : 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: _paginaActual == index
                ? AppColors.Verde70
                : Colors.grey.withOpacity(0.5),
          ),
        );
      }),
    );
  }
}

class _TarjetaIndividual extends StatelessWidget {
  final Map<String, dynamic> datos;

  const _TarjetaIndividual({required this.datos});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: datos['colorFondo'] as Color?,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        ClipPath(
          clipper: _RecortadorTarjeta(),
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: datos['colorRecorte'] as Color?,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  datos['monto'],
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(datos['titulo'], style: const TextStyle(color: Colors.white70)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(datos['nombre'], style: const TextStyle(color: Colors.white, fontSize: 12)),
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
              Text(
                datos['tipo'],
                style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 0),
            ],
          ),
        ),
        Positioned(
          top: 20,
          right: 25,
          child: Text(datos['fecha'], style: TextStyle(color: Colors.white.withOpacity(0.7))),
        ),
      ],
    );
  }
}

// El CustomClipper se mantiene igual
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
