import 'package:Caney/Data/models/cuenta_model.dart';
import 'package:Caney/Data/models/usuario_model.dart';
import 'package:Caney/Data/repositories/cuenta_implementacion.dart';
import 'package:flutter/material.dart';
import 'package:Caney/Core/utils/app_colors.dart';

class TarjetaCredito extends StatefulWidget {
  final Usuario? user; 
  const TarjetaCredito({super.key, this.user});

  @override
  State<TarjetaCredito> createState() => _TarjetaCreditoState();
}

class _TarjetaCreditoState extends State<TarjetaCredito> {
  final _controladorPagina = PageController(viewportFraction: 0.9);
  final _cuentaRepo = CuentaImp();

  int _paginaActual = 0;
  bool _isLoading = true;
  List<Cuenta> _cuentas = [];

  @override
  void initState() {
    super.initState();

    _cargarCuentas();

    _controladorPagina.addListener(() {
      if (_controladorPagina.page != null) {
        setState(() {
          _paginaActual = _controladorPagina.page!.round();
        });
      }
    });
  }

  Future<void> _cargarCuentas() async {
    if (widget.user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
   
    final response = await _cuentaRepo.getCuentaByUsuario(widget.user!.idUser);
    setState(() {
      _cuentas = response.data ?? [];
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _controladorPagina.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_cuentas.isEmpty) {
      return const Center(child: Text('No hay cuentas registradas'));
    }

    return Column(
      children: [
        SizedBox(
          height: 220,
          width: 400,
          child: PageView.builder(
            controller: _controladorPagina,
            itemCount: _cuentas.length,
            itemBuilder: (context, index) {
              final cuenta = _cuentas[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _TarjetaIndividual(
                  titulo: cuenta.nombreCuenta ?? 'Sin nombre',
                  monto: 'S/${cuenta.saldo?.toStringAsFixed(2) ?? "0.00"}',
                  tipo: 'Cuenta general',
                  colorFondo: AppColors.Verde70,
                  colorRecorte: const Color(0xFFF95B51),
                ),
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
      children: List.generate(_cuentas.length, (index) {
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
  final String titulo;
  final String monto;
  final String tipo;
  final Color colorFondo;
  final Color colorRecorte;

  const _TarjetaIndividual({
    required this.titulo,
    required this.monto,
    required this.tipo,
    required this.colorFondo,
    required this.colorRecorte,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorFondo,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        ClipPath(
          clipper: _RecortadorTarjeta(),
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: colorRecorte,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  monto,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  titulo,
                  style: const TextStyle(color: Colors.white70),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    tipo,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

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
