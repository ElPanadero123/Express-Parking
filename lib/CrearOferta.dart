import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CrearOfertaPage extends StatefulWidget {
  @override
  _CrearOfertaPageState createState() => _CrearOfertaPageState();
}

class _CrearOfertaPageState extends State<CrearOfertaPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime? _selectedDate;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;
  double _minPrice = 0.0;
  bool _isAllDay = false; // Variable para controlar si la oferta es para todo el día
  bool _offerSaved = false; // Variable para controlar si la oferta fue guardada
  Map<DateTime, List<dynamic>> _events = {}; // Mapa para almacenar los días en los que se ha realizado una oferta

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Oferta'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCalendar(),
            _buildAllDayOption(),
            if (!_isAllDay) ...[
              _buildTimePickers(),
            ],
            _buildMinPriceInput(),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2022, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _selectedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      eventLoader: (day) {
        return _events[day] ?? [];
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = focusedDay;
          _selectedDate = selectedDay;
          _isAllDay = false; // Al seleccionar un día, desactiva la opción de todo el día
          _selectedStartTime = null; // Reinicia la hora de inicio al seleccionar un nuevo día
          _selectedEndTime = null; // Reinicia la hora de fin al seleccionar un nuevo día
        });
      },
    );
  }

  Widget _buildAllDayOption() {
    return CheckboxListTile(
      title: Text('Oferta para todo el día'),
      value: _isAllDay,
      onChanged: (value) {
        setState(() {
          _isAllDay = value ?? false;
          if (_isAllDay) {
            _selectedStartTime = null; // Reinicia la hora de inicio al activar la opción de todo el día
            _selectedEndTime = null; // Reinicia la hora de fin al activar la opción de todo el día
          }
        });
      },
    );
  }

  Widget _buildTimePickers() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hora de Inicio:',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime != null) {
                setState(() {
                  _selectedStartTime = pickedTime;
                });
              }
            },
            child: Text(
              _selectedStartTime != null ? '${_selectedStartTime!.format(context)}' : 'Seleccionar Hora de Inicio',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Hora de Fin:',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime != null) {
                setState(() {
                  _selectedEndTime = pickedTime;
                });
              }
            },
            child: Text(
              _selectedEndTime != null ? '${_selectedEndTime!.format(context)}' : 'Seleccionar Hora de Fin',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMinPriceInput() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Precio Mínimo:',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Ingrese el Precio Mínimo',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _minPrice = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _offerSaved = true; // Marca que la oferta fue guardada
            _events[_selectedDate!] = [_minPrice]; // Almacena el día en el que se realizó la oferta
          });
          // Mostrar un diálogo o mensaje indicando que la oferta fue guardada
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Oferta Guardada'),
                content: Text('La oferta ha sido guardada exitosamente.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        child: Text('Guardar Oferta'),
      ),
    );
  }
}
