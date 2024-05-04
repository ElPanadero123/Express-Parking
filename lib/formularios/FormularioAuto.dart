import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormularioAuto extends StatelessWidget {
  final TextEditingController matriculaController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  final TextEditingController anchoController = TextEditingController();
  final TextEditingController largoController = TextEditingController();
  final TextEditingController modeloController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FormularioAuto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: Text("AGREGAR AUTO"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Agregar un Nuevo Auto",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  _buildTextField(Icons.car_rental, "Matrícula", matriculaController),
                  SizedBox(height: 10),
                  _buildTextField(Icons.color_lens, "Color", colorController),
                  SizedBox(height: 10),
                  _buildTextField(Icons.height, "Altura", alturaController),
                  SizedBox(height: 10),
                  _buildTextField(Icons.aspect_ratio, "Ancho", anchoController),
                  SizedBox(height: 10),
                  _buildTextField(Icons.height, "Largo", largoController),
                  SizedBox(height: 10),
                  _buildTextField(Icons.model_training, "Modelo", modeloController),
                  SizedBox(height: 90),
                  _buildButton(Icons.save, "GUARDAR", () {
                    if (formKey.currentState!.validate()) {
                      _enviarAuto();
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es obligatorio';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon, String text, void Function() onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(text),
    );
  }

  void _enviarAuto() {
    final matricula = matriculaController.text;
    final color = colorController.text;
    final altura = alturaController.text;
    final ancho = anchoController.text;
    final largo = largoController.text;
    final modelo = modeloController.text;

    final autoData = {
      'matricula': matricula,
      'color': color,
      'altura': altura,
      'ancho': ancho,
      'largo': largo,
      'modelo': modelo,
    };

    final jsonData = jsonEncode(autoData);

    _enviarDatos(jsonData);
  }

  Future<void> _enviarDatos(String jsonData) async {
    try {
      final response = await http.post(
        Uri.parse('https://tu-backend.com/api/agregar_auto'),// cambiar url
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        print('Auto agregado exitosamente');
      } else {
        print('Error al agregar el auto: ${response.body}');
      }
    } catch (error) {
      print('Error al agregar el auto: $error');
    }
  }
}
