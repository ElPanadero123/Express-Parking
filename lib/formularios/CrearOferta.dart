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
  int _minPrice = 0; // Cambio de tipo de dato a int para el precio estimado
  int _offerType = 0; // 0 para oferta no todo el día, 1 para oferta todo el día
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
            if (_offerType == 0) ...[
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
          _offerType = 0; // Al seleccionar un día, establece el tipo de oferta como no todo el día
          _selectedStartTime = null; // Reinicia la hora de inicio al seleccionar un nuevo día
          _selectedEndTime = null; // Reinicia la hora de fin al seleccionar un nuevo día
        });
      },
    );
  }

  Widget _buildAllDayOption() {
    return CheckboxListTile(
      title: Text('Oferta para todo el día'),
      value: _offerType == 1,
      onChanged: (value) {
        setState(() {
          _offerType = value! ? 1 : 0; // Actualiza el tipo de oferta según la selección
          if (_offerType == 1) {
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
            'Precio Estimado:',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Ingrese el Precio Estimado',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _minPrice = int.tryParse(value) ?? 0; // Cambio de tipo de dato a int
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
          _sendDataToDatabase(); // Envía los datos a la base de datos
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



void _sendDataToDatabase() {
  // Convertir el valor booleano _offerType a texto
  String offerTypeText = _offerType == 1 ? 'true' : 'false';

  // Formatear las fechas y horas seleccionadas
  String formattedSelectedDate = _selectedDate != null ? _selectedDate!.toString() : '';
  String formattedStartTime = _selectedStartTime != null ? _selectedStartTime!.format(context) : '';
  String formattedEndTime = _selectedEndTime != null ? _selectedEndTime!.format(context) : '';

  // Aquí implementa la lógica para enviar los datos a la base de datos
  // Utiliza los valores de formattedSelectedDate, formattedStartTime, formattedEndTime, _minPrice y offerTypeText
  // para enviar la oferta a la base de datos según tus requisitos.
  // Puedes utilizar paquetes como `http` o `firebase` según tu backend.

  // Ejemplo de cómo podrías enviar los datos a una base de datos ficticia
  Map<String, dynamic> oferta = {
    'fecha': formattedSelectedDate,
    'hora_inicio': formattedStartTime,
    'tipo_oferta': offerTypeText,
    'hora_final': formattedEndTime,
    'precio_estimado': _minPrice,
  };

  // Enviar la oferta a la base de datos ficticia
  enviarOferta(oferta);
}

// Función ficticia para enviar la oferta a la base de datos
void enviarOferta(Map<String, dynamic> oferta) {
  print('Enviando oferta a la base de datos: $oferta');
  // Aquí iría la lógica real para enviar los datos a la base de datos
}

}
