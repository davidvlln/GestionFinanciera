import 'package:flutter/material.dart';
import 'package:Caney/Core/utils/app_colors.dart';

import '../../componentes/gastos/grafico_gastos_circulares.dart';
import '../../componentes/gastos/indicador_gasto.dart';
import '../../componentes/gastos/item_transaccion_reciente.dart';

class PantallaGastos extends StatelessWidget {
  const PantallaGastos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F4F0),
      appBar: AppBar(
        toolbarHeight: 75,
        title: Text('Gastos Fijos Registrados', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.Verde70)),
        backgroundColor: const Color(0xFFE3F4F0),
        foregroundColor: AppColors.Verde70,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 0),
                const GraficoGastosCirculares(),
                const SizedBox(height: 20),
                _buildIndicadores(),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.47,
            minChildSize: 0.47,
            maxChildSize: 0.63,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  children: [
                    Center(
                      child: Container(
                        height: 5,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Registro de Gastos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    ItemTransaccionReciente(nombre: 'Universidad', hora: 'Hace 7 dias', monto: 'S/-450,00', icono: Icons.book_rounded, color: Color(0xFF73CBB6)),
                    ItemTransaccionReciente(nombre: 'Comida', hora: 'Hace 1 hora', monto: 'S/-10,00', icono: Icons.fastfood, color: Colors.orange),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildIndicadores() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IndicadorGasto(nombre: 'Valorant', porcentaje: '52', color: Color(0xFFF07569)),
        IndicadorGasto(nombre: 'Universidad', porcentaje: '40', color: Color(0xFF73CBB6)),
        IndicadorGasto(nombre: 'Comida', porcentaje: '3', color: Color(0xFFF9C76E)),
        IndicadorGasto(nombre: 'Pasajes', porcentaje: '5', color: Color(0xFFA6D88A)),
      ],
    );
  }
}
