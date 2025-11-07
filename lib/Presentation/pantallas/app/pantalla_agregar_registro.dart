import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../componentes/acceso/boton_principal.dart';

class Categoria {
  final String nombre;
  final IconData icono;
  final Color color;

  const Categoria({required this.nombre, required this.icono, required this.color});
}

enum TipoTransaccion { ingreso, egreso }

class PantallaAgregarRegistro extends StatefulWidget {
  const PantallaAgregarRegistro({super.key});

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

  final List<Categoria> _categorias = const [
    Categoria(nombre: 'Comida', icono: Icons.fastfood, color: Colors.orange),
    Categoria(nombre: 'Transporte', icono: Icons.directions_car, color: Colors.blue),
    Categoria(nombre: 'Compras', icono: Icons.shopping_bag, color: Colors.purple),
    Categoria(nombre: 'Salud', icono: Icons.healing, color: Colors.red),
    Categoria(nombre: 'Ocio', icono: Icons.sports_esports, color: Colors.green),
    Categoria(nombre: 'Salario', icono: Icons.attach_money, color: Colors.teal),
  ];

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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Lógica para guardar en la base de datos
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registro guardado (simulado)')),
                    );
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Categoría', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _categorias.map((categoria) {
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
