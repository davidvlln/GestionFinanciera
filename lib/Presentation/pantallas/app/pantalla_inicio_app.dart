import 'package:Caney/Data/models/usuario_model.dart';
import 'package:Caney/Presentation/pantallas/app/pantalla_gastos.dart';
import 'package:flutter/material.dart';
import 'package:Caney/Core/utils/app_colors.dart';

import '../../componentes/inicio/tarjeta_credito.dart';
import '../../componentes/inicio/cabecera_seccion.dart';
import '../../componentes/inicio/tarjeta_ingresos.dart';
import '../../componentes/inicio/item_transaccion.dart';

class PantallaInicioApp extends StatelessWidget {
  final Usuario? user;
  const PantallaInicioApp({super.key,this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 0),
              TarjetaCredito(user:user),
              const SizedBox(height: 30),
              CabeceraSeccion(titulo: 'Dinero Estructurado', colorTexto: AppColors.Negro100, verMas: false),
              const SizedBox(height: 15),
              const Row(
                children: [
                  Expanded(child: TarjetaIngresos(titulo: 'Ingresos', monto: 'S/2844.50')),
                  SizedBox(width: 15),
                  Expanded(child: TarjetaIngresos(titulo: 'Egresos', monto: 'S/2144.50')),
                ],
              ),
              const SizedBox(height: 30),
              CabeceraSeccion(titulo: 'Gastos Recientes', colorTexto: AppColors.Verde70, verMas: true, direccion: PantallaGastos()),
              const SizedBox(height: 15),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final transacciones = [
                    {
                      'icono': Icons.school,
                      'titulo': 'Universidad',
                      'subtitulo': 'Cuota Mensual',
                      'monto': 'S/-400.00',
                      'color': const Color(0xFF00BFFF)
                    },
                    {
                      'icono': Icons.sports_esports,
                      'titulo': 'Dota Plus',
                      'subtitulo': 'El dotita es el mejor',
                      'monto': 'S/-20',
                      'color': const Color(0xFFF08080)
                    },
                    {
                      'icono': Icons.music_note,
                      'titulo': 'Spotify',
                      'subtitulo': 'Subscripcion',
                      'monto': 'S/-11.59',
                      'color': const Color(0xFF3CB371)
                    },
                  ];
                  final transaccion = transacciones[index];
                  return ItemTransaccion(
                    icono: transaccion['icono'] as IconData,
                    titulo: transaccion['titulo'] as String,
                    subtitulo: transaccion['subtitulo'] as String,
                    monto: transaccion['monto'] as String,
                    colorIcono: transaccion['color'] as Color,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
