import 'package:flutter/material.dart';
import '../../componentes/estadisticas/selector_periodo.dart';
import '../../componentes/estadisticas/grafico_estadisticas.dart';
import '../../componentes/estadisticas/item_historial.dart';

class PantallaEstadisticas extends StatelessWidget {
  const PantallaEstadisticas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF22C5A1),
      body: Stack(
        children: [
          const Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(height: 0),
                    SelectorPeriodo(),
                    SizedBox(height: 30),
                    Text(
                      'Gasto total',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    Text(
                      'S/6,340.00',
                      style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    GraficoEstadisticas(),
                  ],
                ),
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: const EdgeInsets.all(25.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Historial de transacciones', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Ver Mas >', style: TextStyle(color: Colors.grey.shade700)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text('Hoy', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                    const ItemHistorial(iniciales: 'MB', nombre: 'Mikle Borie', hora: '10:30 AM', monto: '+\$350.00', tipo: 'Ingreso', esPositivo: true),
                    const ItemHistorial(iniciales: 'Uber', nombre: 'Uber', hora: '02:45 AM', monto: '-\$10.00', tipo: 'Egreso', esPositivo: false,),
                    const ItemHistorial(iniciales: 'a', nombre: 'Amazon Shopping', hora: '09:45 AM', monto: '-\$124.00', tipo: 'Egreso', esPositivo: false,),
                    const SizedBox(height: 10),
                    const Text('Semana', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                    const ItemHistorial(iniciales: 'NL', nombre: 'Noan Lucas', hora: '25 May 2025', monto: '-\$250.00', tipo: 'Egreso', esPositivo: false,),
                    const ItemHistorial(iniciales: 'NL', nombre: 'Noan Lucas', hora: '25 May 2025', monto: '-\$250.00', tipo: 'Egreso', esPositivo: false,),
                    const ItemHistorial(iniciales: 'NL', nombre: 'Noan Lucas', hora: '25 May 2025', monto: '-\$250.00', tipo: 'Egreso', esPositivo: false,),
                    const ItemHistorial(iniciales: 'NL', nombre: 'Noan Lucas', hora: '25 May 2025', monto: '-\$250.00', tipo: 'Egreso', esPositivo: false,),
                    const ItemHistorial(iniciales: 'NL', nombre: 'Noan Lucas', hora: '25 May 2025', monto: '-\$250.00', tipo: 'Egreso', esPositivo: false,),
                    const ItemHistorial(iniciales: 'NL', nombre: 'Noan Lucas', hora: '25 May 2025', monto: '-\$250.00', tipo: 'Egreso', esPositivo: false,),
                    const ItemHistorial(iniciales: 'NL', nombre: 'Noan Lucas', hora: '25 May 2025', monto: '-\$250.00', tipo: 'Egreso', esPositivo: false,),
                    const ItemHistorial(iniciales: 'NL', nombre: 'Noan Lucas', hora: '25 May 2025', monto: '-\$250.00', tipo: 'Egreso', esPositivo: false,),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
