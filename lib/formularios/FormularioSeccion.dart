import 'package:flutter/material.dart';
import 'package:express_parking/fakeTaxi/ParqueosDataModel.dart';

class FormularioSeccion extends StatefulWidget {
  final void Function(Seccion) onAdd;

  const FormularioSeccion({Key? key, required this.onAdd}) : super(key: key);

  @override
  _FormularioSeccionState createState() => _FormularioSeccionState();
}

class _FormularioSeccionState extends State<FormularioSeccion> {
  final TextEditingController imagenSeccionController = TextEditingController();
  final TextEditingController anchoController = TextEditingController();
  final TextEditingController largoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  final TextEditingController horaInicioController = TextEditingController();
  final TextEditingController horaFinalController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _guardarSeccion() {
    if (formKey.currentState!.validate()) {
      Seccion newSection = Seccion(
        idSeccion: DateTime.now().millisecondsSinceEpoch,
        imagenSeccion: imagenSeccionController.text,
        ancho: double.parse(anchoController.text),
        largo: double.parse(largoController.text),
        altura: double.parse(alturaController.text),
        estado: "disponible", // Estado por defecto
        horaInicio: horaInicioController.text,
        horaFinal: horaFinalController.text,
      );
      widget.onAdd(newSection);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agregar Nueva Sección")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _buildTextField(imagenSeccionController,
                  "URL de la imagen de la sección", Icons.image),
              _buildNumericField(
                  anchoController, "Ancho (m)", Icons.square_foot),
              _buildNumericField(
                  largoController, "Largo (m)", Icons.square_foot),
              _buildNumericField(alturaController, "Altura (m)", Icons.height),
              _buildTimePicker(horaInicioController, "Hora de inicio"),
              _buildTimePicker(horaFinalController, "Hora de fin"),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardarSeccion,
                child: Text('Guardar Sección'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.deepPurple, // Un color de fondo atractivo
                  foregroundColor: Colors.white, // Color del texto
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      validator: (value) => value!.isEmpty ? "Este campo es obligatorio" : null,
    );
  }

  Widget _buildNumericField(
      TextEditingController controller, String labelText, IconData icon) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo es obligatorio';
        }
        if (double.tryParse(value) == null) {
          return 'Ingrese un número válido';
        }
        return null;
      },
    );
  }

  Widget _buildTimePicker(TextEditingController controller, String labelText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.timer),
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              // Formatea la hora en formato de 24 horas
              final String formattedTime = _formatTime(pickedTime);
              controller.text = formattedTime;
            }
          },
        ),
      ),
      readOnly: true,
      validator: (value) => value!.isEmpty ? "Este campo es obligatorio" : null,
    );
  }

  String _formatTime(TimeOfDay time) {
    // Formatea el tiempo para que sea compatible con MySQL
    final String formattedTime =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    return formattedTime;
  }
}
