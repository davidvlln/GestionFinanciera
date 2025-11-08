import 'package:flutter/material.dart';
import 'package:Caney/Core/utils/app_colors.dart';

import '../../componentes/metas/tarjeta_plan.dart';
import '../../componentes/metas/item_actividad.dart';

class PantallaMetas extends StatelessWidget {
  const PantallaMetas({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo para la lista de metas detrás
    final List<Map<String, dynamic>> metasDeFondo = [
      {'titulo': 'Viaje a Cusco', 'monto': 'S/2,500', 'icono': Icons.flight_takeoff},
      {'titulo': 'Nuevo Setup Gamer', 'monto': 'S/8,000', 'icono': Icons.videogame_asset},
      {'titulo': 'Entrada Concierto', 'monto': 'S/700', 'icono': Icons.music_note},
      {'titulo': 'Laptop Nueva', 'monto': 'S/5,500', 'icono': Icons.laptop_mac},
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Un fondo neutro
      body: Stack(
        children: [
          // --- 1. CONTENIDO SUPERIOR + LISTA DE METAS DE FONDO ---
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    const Text('07 Octubre, 2025', style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w600)),
                    const Text('Objetivos del día!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 150,
                      child: PageView(
                        controller: PageController(viewportFraction: 0.9),
                        children: const [TarjetaPlan(), Padding(padding: EdgeInsets.only(left: 15.0), child: TarjetaPlan())],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Metas a Largo Plazo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              // Lista de metas detrás de la hoja deslizable
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 100), // Padding inferior para que no se corte con el Draggable
                  itemCount: metasDeFondo.length,
                  itemBuilder: (context, index) {
                    final meta = metasDeFondo[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))]
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(child: Icon(meta['icono']), backgroundColor: AppColors.Verde70.withOpacity(0.1), foregroundColor: AppColors.Verde70),
                          const SizedBox(width: 15),
                          Expanded(child: Text(meta['titulo'], style: const TextStyle(fontWeight: FontWeight.bold))),
                          Text(meta['monto'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),

          // --- 2. HOJA DESLIZABLE ---
          DraggableScrollableSheet(
            initialChildSize: 0.5, // Ajustado para que se vea la lista de atrás
            minChildSize: 0.5,
            maxChildSize: 0.85,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: AppColors.Blanco,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))]
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
                          color: AppColors.Verde70, 
                          borderRadius: BorderRadius.circular(12)
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Actividad de Hoy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    ItemActividad(
                      titulo: 'Comprar Computadora',
                      subtitulo: 'Lo necesito no debo fallar',
                      hora: '22/12/2025',
                      estaCompletado: false,
                      onTap: () => print('Tocado: Comprar Computadora'), // Lógica de ejemplo
                    ),
                    ItemActividad(
                      titulo: 'Comprar Celular',
                      subtitulo: 'Es opcional pero debo hacerlo',
                      hora: '16/08/2022',
                      estaCompletado: true,
                      onTap: () => print('Tocado: Comprar Celular'), // Lógica de ejemplo
                    ),
                    ItemActividad(
                      titulo: 'Comprar Carro',
                      subtitulo: 'Ya ir a pie cansa pes papi',
                      hora: '05/06/2022',
                      estaCompletado: true,
                      onTap: () => print('Tocado: Comprar Carro'), // Lógica de ejemplo
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
