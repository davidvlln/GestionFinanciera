import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraficoEstadisticas extends StatelessWidget {
  const GraficoEstadisticas({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            _buildLineChartBarData(
              [
                const FlSpot(1, 300),
                const FlSpot(2, 200),
                const FlSpot(3, 500),
                const FlSpot(4, 300.50),
                const FlSpot(5, 400),
                const FlSpot(6, 300),
                const FlSpot(7, 400),
              ],
              Colors.white.withOpacity(0.7),
            ),
            _buildLineChartBarData(
              [
                const FlSpot(1, 100.50),
                const FlSpot(2, 200.80),
                const FlSpot(3, 200.0),
                const FlSpot(4, 400.50),
                const FlSpot(5, 300.50),
                const FlSpot(6, 200.80),
                const FlSpot(7, 300.80),
              ],
              const Color(0xFFFACC15),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) => const Color(0xFFFACC15),
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((barSpot) {
                  return LineTooltipItem(
                    'S/${barSpot.y.toInt()}',
                    const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  );
                }).toList();
              },
            ),
            getTouchedSpotIndicator: (barData, spotIndexes) {
              return spotIndexes.map((spotIndex) {
                return TouchedSpotIndicatorData(
                  const FlLine(color: Colors.white, strokeWidth: 2, dashArray: [5, 5]),
                  FlDotData(
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 8,
                        color: const Color(0xFFFACC15),
                        strokeWidth: 4,
                        strokeColor: Colors.white,
                      );
                    },
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  LineChartBarData _buildLineChartBarData(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }
}
