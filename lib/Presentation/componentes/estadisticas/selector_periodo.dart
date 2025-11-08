import 'package:flutter/material.dart';

class SelectorPeriodo extends StatefulWidget {
  const SelectorPeriodo({super.key});

  @override
  State<SelectorPeriodo> createState() => _SelectorPeriodoState();
}

class _SelectorPeriodoState extends State<SelectorPeriodo> {
  int _indiceSeleccionado = 0;
  final List<String> _opciones = ['Hoy', 'Semana', 'Mes', 'Año'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_opciones.length, (index) {
          final estaSeleccionado = _indiceSeleccionado == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _indiceSeleccionado = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: estaSeleccionado ? const Color(0xFFFACC15) : Colors.transparent,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  _opciones[index],
                  style: TextStyle(
                    color: estaSeleccionado ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
