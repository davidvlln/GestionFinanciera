import 'package:flutter/material.dart';
import 'package:Caney/Core/utils/app_colors.dart';

import '../../componentes/metas/tarjeta_plan.dart';
import '../../componentes/metas/item_actividad.dart';

class PantallaMetas extends StatefulWidget {
  const PantallaMetas({super.key});

  @override
  State<PantallaMetas> createState() => _PantallaMetasState();
}

class _PantallaMetasState extends State<PantallaMetas> {

  late final List<Map<String, dynamic>> _actividadesDeHoy;

  @override
  void initState() {
    super.initState();
    _actividadesDeHoy = [
      {'titulo': 'Cena', 'subtitulo': 'No gastar mas de 12 soles', 'hora': '8:00 PM', 'estado': EstadoActividad.pendiente},
      {'titulo': 'Movilidad', 'subtitulo': 'No tomar taxi', 'hora': '5:00 PM', 'estado': EstadoActividad.completada},
      {'titulo': 'Almuerzo', 'subtitulo': 'No gastar mas de 10 soles', 'hora': '1:00 PM', 'estado': EstadoActividad.noCompletada},
      {'titulo': 'Desayuno', 'subtitulo': 'No gastar mas de 5 soles', 'hora': '9:00 AM', 'estado': EstadoActividad.pendiente},
    ];
  }

  void _ciclarEstadoActividad(int index) {
    setState(() {
      final estadoActual = _actividadesDeHoy[index]['estado'];
      if (estadoActual == EstadoActividad.pendiente) {
        _actividadesDeHoy[index]['estado'] = EstadoActividad.completada;
      } else if (estadoActual == EstadoActividad.completada) {
        _actividadesDeHoy[index]['estado'] = EstadoActividad.noCompletada;
      } else {
        _actividadesDeHoy[index]['estado'] = EstadoActividad.pendiente;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> metasDeFondo = [
      {'titulo': 'Viaje a Cusco', 'monto': 'S/2,500', 'icono': Icons.flight_takeoff},
      {'titulo': 'Nuevo Setup Gamer', 'monto': 'S/8,000', 'icono': Icons.videogame_asset},
      {'titulo': 'Entrada Concierto', 'monto': 'S/700', 'icono': Icons.music_note},
      {'titulo': 'Entrada Concierto', 'monto': 'S/700', 'icono': Icons.music_note},
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 0),
                    const Text('07 Octubre, 2025', style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w600)),
                    const Text('Objetivo a Lograr!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 150,
                      child: PageView(controller: PageController(viewportFraction: 0.9), children: const [TarjetaPlan(), Padding(padding: EdgeInsets.only(left: 15.0), child: TarjetaPlan())]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Metas a Largo Plazo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 130),
                  itemCount: metasDeFondo.length,
                  itemBuilder: (context, index) {
                    final meta = metasDeFondo[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))]),
                      child: Row(children: [CircleAvatar(child: Icon(meta['icono']), backgroundColor: AppColors.Verde70.withOpacity(0.1), foregroundColor: AppColors.Verde70), const SizedBox(width: 15), Expanded(child: Text(meta['titulo'], style: const TextStyle(fontWeight: FontWeight.bold))), Text(meta['monto'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))]),
                    );
                  },
                ),
              )
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.62,
            minChildSize: 0.17,
            maxChildSize: 0.62,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                    color: AppColors.Blanco,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))]
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Container(
                          height: 5,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const Text('Actividades de Hoy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    ..._actividadesDeHoy.asMap().entries.map((entry) {
                       final index = entry.key;
                       final actividad = entry.value;
                        return ItemActividad(
                          titulo: actividad['titulo'],
                          subtitulo: actividad['subtitulo'],
                          hora: actividad['hora'],
                          estado: actividad['estado'],
                          onTap: () => _ciclarEstadoActividad(index),
                        );
                    }).toList(),
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
