import 'package:flutter/material.dart';
import 'package:Caney/Core/utils/app_colors.dart';

import '../../componentes/metas/tarjeta_plan.dart';
import '../../componentes/metas/item_actividad.dart';

class PantallaMetas extends StatelessWidget {
  const PantallaMetas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Transparent,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  '07 Octubre, 2025',
                  style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 0),
                const Text(
                  'Buenos dias, Carlos!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 150,
                  child: PageView(
                    controller: PageController(viewportFraction: 0.9),
                    children: const [
                      TarjetaPlan(),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: TarjetaPlan(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.15,
            maxChildSize: 1,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: AppColors.Blanco,
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
                          color: AppColors.Verde70,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Lista de Metas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    const ItemActividad(titulo: 'Comprar Computadora', subtitulo: 'Lo necesito no debo fallar', hora: '22/12/2025', estaCompletado: false),
                    const ItemActividad(titulo: 'Comprar Celular', subtitulo: 'Es opcional pero debo hacerlo', hora: '16/08/2022', estaCompletado: true),
                    const ItemActividad(titulo: 'Comprar Carro', subtitulo: 'Ya ir a pie cansa pes papi', hora: '05/06/2022', estaCompletado: true),
                    const IntrinsicHeight(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                            child: Column(
                              children: [
                                SizedBox(height: 15 / 2),
                                Expanded(child: SizedBox()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
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
