import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraficoGastosCirculares extends StatefulWidget {
  const GraficoGastosCirculares({super.key});

  @override
  State<GraficoGastosCirculares> createState() => _GraficoGastosCircularesState();
}

class _GraficoGastosCircularesState extends State<GraficoGastosCirculares> {
  int indiceTocado = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                      indiceTocado = -1;
                      return;
                    }
                    indiceTocado = pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(show: false),
              sectionsSpace: 3,
              centerSpaceRadius: 70,
              sections: mostrarSecciones(),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Total', style: TextStyle(color: Colors.grey, fontSize: 16)),
              Text(
                'S/6,653',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ],
          )
        ],
      ),
    );
  }

  List<PieChartSectionData> mostrarSecciones() {
    // Datos de ejemplo
    final secciones = [
      {'valor': 52.0, 'color': const Color(0xFFF07569), 'monto': 'S/3 459.56'},
      {'valor': 40.0, 'color': const Color(0xFF73CBB6), 'monto': 'S/2,661.2'},
      {'valor': 3.0, 'color': const Color(0xFFF9C76E), 'monto': 'S/199.59'},
      {'valor': 5.0, 'color': const Color(0xFFA6D88A), 'monto': 'S/332.65'},
    ];

    return List.generate(secciones.length, (i) {
      final estaTocado = i == indiceTocado;
      final radio = estaTocado ? 60.0 : 50.0;
      final datosSeccion = secciones[i];

      return PieChartSectionData(
        color: datosSeccion['color'] as Color,
        value: datosSeccion['valor'] as double,
        title: '',
        radius: radio,
        badgeWidget: estaTocado ? _buildBadge(datosSeccion['monto'] as String) : null,
        badgePositionPercentageOffset: .98,
      );
    });
  }

  Widget _buildBadge(String texto) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        texto,
        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
