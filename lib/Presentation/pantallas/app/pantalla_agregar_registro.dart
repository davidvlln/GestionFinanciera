import 'package:Caney/Core/utils/app_colors.dart';
import 'package:Caney/Data/models/egreso_model.dart';
import 'package:Caney/Data/models/tipoegreso_model.dart';
import 'package:Caney/Data/models/tipoingreso_model.dart';
import 'package:Caney/Data/models/usuario_model.dart';
import 'package:Caney/Data/repositories/egreso_implementacion.dart';
import 'package:Caney/Data/repositories/tipoegreso_implementacion.dart';
import 'package:Caney/Data/repositories/tipoingreso_implementacion.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../componentes/acceso/boton_principal.dart';



class Categoria {
  final int id;
  final String nombre;
  final IconData icono;
  final Color color;
  final String tipo;

  const Categoria({required this.id,required this.nombre, required this.icono, required this.color, required this.tipo});

    Categoria copyWith({
    int? id,
    String? nombre,
    IconData? icono,
    Color? color,
    String? tipo,
  }) {
    return Categoria(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      icono: icono ?? this.icono,
      color: color ?? this.color,
      tipo: tipo ?? this.tipo,
    );
  }

}

enum TipoTransaccion { ingreso, egreso }

class PantallaAgregarRegistro extends StatefulWidget {
  final Usuario? user;
  const PantallaAgregarRegistro({super.key, this.user});

  @override
  State<PantallaAgregarRegistro> createState() => _PantallaAgregarRegistroState();
}

class _PantallaAgregarRegistroState extends State<PantallaAgregarRegistro> {
  final _formKey = GlobalKey<FormState>();
  TipoTransaccion _tipoSeleccionado = TipoTransaccion.egreso;

  final _montoController = TextEditingController();
  final _tituloController = TextEditingController();
  final _notasController = TextEditingController();

  DateTime _fechaSeleccionada = DateTime.now();
  Categoria? _categoriaSeleccionada;
  bool _esGastoFijo = false;

  List<Categoria> _categorias = const [
    Categoria(id: 0, nombre: 'Comida',     icono: Icons.fastfood,       color: Colors.orange,   tipo: 'egreso'),
    Categoria(id: 0, nombre: 'Transporte', icono: Icons.directions_car, color: Colors.blue,     tipo: 'egreso'),
    Categoria(id: 0, nombre: 'Compras',    icono: Icons.shopping_bag,   color: Colors.purple,   tipo: 'egreso'),
    Categoria(id: 0, nombre: 'Salud',      icono: Icons.healing,        color: Colors.red,      tipo: 'egreso'),
    Categoria(id: 0, nombre: 'Ocio',       icono: Icons.sports_esports, color: Colors.green,    tipo: 'egreso'),
    Categoria(id: 0, nombre: 'Salario',    icono: Icons.attach_money,   color: Colors.teal,     tipo: 'ingreso'),
  ];


  Map<String, int> _nombreTipoAId = {}; // 'servicio público' → 1

  @override
  void initState() {
    super.initState();
    _cargarTipos();
    _categoriaSeleccionada = _categorias[0]; // por defecto
  }

  Future<void> _cargarTipos() async {
    try {
      final ingresoService = TipoIngresoImp();
      final egresoService = TipoEgresoImp();

      final ingresoResp = await ingresoService.getTipoIngresos();
      final egresoResp = await egresoService.getTipoEgreso();

      final List<Categoria> actualizadas = _categorias.map((categoria) {
        if (categoria.tipo == 'ingreso') {
          TipoIngreso? match;
          try {
            match = ingresoResp.data?.firstWhere(
              (item) {
                final nombreOriginal = item.desTipoIngreso.toString();
                final nombreNormalizado = nombreOriginal.toLowerCase().contains('salario')
                    ? 'Salario'
                    : nombreOriginal;
                return categoria.nombre.trim().toLowerCase() == nombreNormalizado.trim().toLowerCase();
              },
            );
          } catch (_) {
            match = null;
          }

          if (match != null) {
            return categoria.copyWith(id: match.idTipoIngreso);
          }
        }

        if (categoria.tipo == 'egreso') {
          TipoEgreso? match;
          try {
            match = egresoResp.data?.firstWhere(
              (item) => categoria.nombre.trim().toLowerCase() ==
                  item.desTipoEgreso.toString().trim().toLowerCase(),
            );
          } catch (_) {
            match = null;
          }

          if (match != null) {
            return categoria.copyWith(id: match.idTipoEgreso);
          }
        }

        return categoria;
      }).toList();

      setState(() {
        _categorias = actualizadas;
        final tipoActual = _tipoSeleccionado == TipoTransaccion.ingreso ? 'ingreso' : 'egreso';
        final filtradas = actualizadas.where((c) => c.tipo == tipoActual).toList();
        _categoriaSeleccionada = filtradas.isNotEmpty ? filtradas[0] : null;
      });
    } catch (e) {
      // Manejo de error silencioso
    }
  }

  @override
  void dispose() {
    _montoController.dispose();
    _tituloController.dispose();
    _notasController.dispose();
    super.dispose();
  }

  

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? fechaElegida = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (fechaElegida != null && fechaElegida != _fechaSeleccionada) {
      setState(() {
        _fechaSeleccionada = fechaElegida;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title: const Text('Agregar Registro'),
        backgroundColor: _tipoSeleccionado == TipoTransaccion.ingreso ? Colors.green : Colors.red,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildSelectorTipo(),
              const SizedBox(height: 20),
              _buildCampoMonto(),
              const SizedBox(height: 20),
              _buildCampoTitulo(),
              const SizedBox(height: 30),
              _buildSelectorCategoria(),
              const SizedBox(height: 20),
              _buildSelectorFecha(context),
              const SizedBox(height: 10),
              _buildSwitchGastoFijo(),
              const SizedBox(height: 20),
              _buildCampoNotas(),
              const SizedBox(height: 40),
              BotonPrincipal(
                texto: 'Guardar Registro',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final monto = double.tryParse(_montoController.text.trim()) ?? 0.0;
                    final titulo = _tituloController.text.trim();
                    final tipo = _categoriaSeleccionada?.id;
                    final fecha = _fechaSeleccionada;
                    final esGastoFijo = _esGastoFijo;
                    final notas = _notasController.text.trim().isEmpty ? null : _notasController.text.trim();


                    final idCuenta = widget.user?.idUser;
                    if (idCuenta == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: usuario sin cuenta'), backgroundColor: AppColors.Rojo70),
                      );
                      return;
                    }

                    // Construir descripción
                    String? descripcion;
                    if (titulo.isNotEmpty || notas != null || esGastoFijo) {
                      final partes = <String>[];
                      if (titulo.isNotEmpty) partes.add(titulo);
                      if (notas != null) partes.add(notas);
                      if (esGastoFijo) partes.add('(Fijo)');
                      descripcion = partes.join(' - ');
                    }

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => Center(
                        child: CircularProgressIndicator(color: AppColors.Verde70),
                      ),
                    );

                

                    try {
                      final dataSource = Supabase.instance.client;

                      final int? tipoId = _categoriaSeleccionada?.id;

                      if (tipoId == null || tipoId == 0) {
                        if (context.mounted) Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Categoría no válida'), backgroundColor: AppColors.Rojo70),
                        );
                        return;
                      }

                      if (_tipoSeleccionado == TipoTransaccion.ingreso) {
                        // === INGRESO ===
                        await dataSource.from('Ingresos').insert({
                          'idCuenta': idCuenta,
                          'idTipoIngreso': tipoId,
                          'fechaRegistro': fecha.toIso8601String(),
                          'monto': monto,
                          'descripcion': descripcion,
                        });

                        // Aumentar saldo
                        final cuenta = await dataSource.from('Cuenta').select('Saldo').eq('id', idCuenta).single();
                        final nuevoSaldo = (cuenta['Saldo'] as num).toDouble() + monto;
                        await dataSource.from('Cuenta').update({'Saldo': nuevoSaldo}).eq('id', idCuenta);
                      } else {
                        // === EGRESO ===
                        await dataSource.from('Egresos').insert({
                          'idCuenta': idCuenta,
                          'idTipoEgreso': tipoId,
                          'fechaRegistro': fecha.toIso8601String(),
                          'monto': monto,
                          'descripcion': descripcion,
                        });

                        // Disminuir saldo
                        final cuenta = await dataSource.from('Cuenta').select('Saldo').eq('id', idCuenta).single();
                        final nuevoSaldo = (cuenta['Saldo'] as num).toDouble() - monto;
                        await dataSource.from('Cuenta').update({'Saldo': nuevoSaldo}).eq('id', idCuenta);
                      }

                      if (context.mounted) Navigator.pop(context); // spinner

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${_tipoSeleccionado == TipoTransaccion.ingreso ? 'Ingreso' : 'Egreso'} guardado'),
                          backgroundColor: AppColors.Verde70,
                        ),
                      );

                      // Limpiar formulario
                      _formKey.currentState!.reset();
                      _montoController.clear();
                      _tituloController.clear();
                      _notasController.clear();
                      setState(() {
                        _fechaSeleccionada = DateTime.now();
                        _categoriaSeleccionada = _categorias[0];
                        _esGastoFijo = false;
                      });

                      Navigator.pop(context);
                    } catch (e) {
                      if (context.mounted) Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.Rojo70),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectorTipo() {
    return SegmentedButton<TipoTransaccion>(
      segments: const <ButtonSegment<TipoTransaccion>>[
        ButtonSegment(value: TipoTransaccion.egreso, label: Text('Egreso'), icon: Icon(Icons.remove)),
        ButtonSegment(value: TipoTransaccion.ingreso, label: Text('Ingreso'), icon: Icon(Icons.add)),
      ],
      selected: {_tipoSeleccionado},
      onSelectionChanged: (Set<TipoTransaccion> newSelection) {
        setState(() {
          _tipoSeleccionado = newSelection.first;


          final tipo = _tipoSeleccionado == TipoTransaccion.ingreso ? 'ingreso' : 'egreso';
          final filtradas = _categorias.where((c) => c.tipo == tipo).toList();
          _categoriaSeleccionada = filtradas.isNotEmpty ? filtradas[0] : null;
          
        });
      },
      style: SegmentedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.grey,
        selectedForegroundColor: Colors.white,
        selectedBackgroundColor: _tipoSeleccionado == TipoTransaccion.ingreso ? Colors.green : Colors.red,
      ),
    );
  }

  Widget _buildCampoMonto() {
    return TextFormField(
      controller: _montoController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Monto',
        prefixIcon: Icon(_tipoSeleccionado == TipoTransaccion.ingreso ? Icons.arrow_upward : Icons.arrow_downward),
        prefixText: 'S/ ',
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Ingresa un monto';
        if (double.tryParse(value) == null) return 'Ingresa un número válido';
        return null;
      },
    );
  }

  Widget _buildCampoTitulo() {
    return TextFormField(
      controller: _tituloController,
      decoration: const InputDecoration(
        labelText: 'Título o Descripción',
        prefixIcon: Icon(Icons.title),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Ingresa un título';
        return null;
      },
    );
  }

  Widget _buildSelectorCategoria() {
  final tipoActual = _tipoSeleccionado == TipoTransaccion.ingreso ? 'ingreso' : 'egreso';
  final categoriasFiltradas = _categorias.where((c) => c.tipo == tipoActual).toList();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Categoría', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 10),
      Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: categoriasFiltradas.map((categoria) {
          final estaSeleccionada = _categoriaSeleccionada?.nombre == categoria.nombre;
          return ChoiceChip(
            avatar: Icon(categoria.icono, color: estaSeleccionada ? Colors.white : categoria.color),
            label: Text(categoria.nombre),
            selected: estaSeleccionada,
            onSelected: (selected) {
              setState(() {
                _categoriaSeleccionada = selected ? categoria : null;
              });
            },
            selectedColor: categoria.color,
            labelStyle: TextStyle(color: estaSeleccionada ? Colors.white : Colors.black),
            showCheckmark: false,
          );
        }).toList(),
      ),
    ],
  );
}

  Widget _buildSelectorFecha(BuildContext context) {
    return InkWell(
      onTap: () => _seleccionarFecha(context),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Fecha',
          prefixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(),
        ),
        child: Text(DateFormat.yMMMd().format(_fechaSeleccionada)),
      ),
    );
  }

  Widget _buildSwitchGastoFijo() {
    return SwitchListTile(
      title: const Text('Gasto / Ingreso Fijo'),
      subtitle: const Text('Se repetirá mensualmente'),
      value: _esGastoFijo,
      onChanged: (bool value) {
        setState(() {
          _esGastoFijo = value;
        });
      },
      secondary: const Icon(Icons.repeat),
    );
  }

  Widget _buildCampoNotas() {
    return TextFormField(
      controller: _notasController,
      decoration: const InputDecoration(
        labelText: 'Notas (Opcional)',
        prefixIcon: Icon(Icons.notes),
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
    );
  }
}
