import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormularioAuto extends StatefulWidget {
  const FormularioAuto({Key? key}) : super(key: key);

  @override
  _FormularioAutoState createState() => _FormularioAutoState();
}

class _FormularioAutoState extends State<FormularioAuto> {
  final matriculaController = TextEditingController();
  final colorController = TextEditingController();
  final alturaController = TextEditingController();
  final anchoController = TextEditingController();
  final largoController = TextEditingController();
  final modeloController = TextEditingController();
  final marcaController = TextEditingController(); // Nuevo controlador para la marca
  String imageUrl = ''; // Variable para almacenar la URL de la imagen
  final formKey = GlobalKey<FormState>();

  // Función para seleccionar una imagen de la galería
  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageUrl = pickedFile.path; // Almacena la URL de la imagen seleccionada
      });
    }
  }

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
                  SizedBox(height: 10),
                  _buildTextField(Icons.label, "Marca", marcaController), // Agregar campo de marca
                  SizedBox(height: 10),
                  _buildImagePicker(), // Agregar el campo de carga de imagen
                  SizedBox(height: 90),
                  _buildButton(Icons.save, "GUARDAR", () {
                    if (formKey.currentState!.validate()) {
                      // Aquí puedes definir la lógica para guardar los datos del auto,
                      // incluyendo la URL de la imagen
                      String matricula = matriculaController.text;
                      String color = colorController.text;
                      String altura = alturaController.text;
                      String ancho = anchoController.text;
                      String largo = largoController.text;
                      String modelo = modeloController.text;
                      String marca = marcaController.text; // Obtener el valor del campo de marca
                      // La variable 'imageUrl' ya almacena la URL de la imagen seleccionada

                      // Mostrar mensaje de éxito al guardar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('¡Guardado con éxito!'),
                          backgroundColor: Colors.green,
                        ),
                      );
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

  Widget _buildImagePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.image, size: 30),
          Expanded(
            child: TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Seleccionar Imagen',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: imageUrl),
            ),
          ),
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: _getImage, // Llama a la función para seleccionar la imagen
          ),
        ],
      ),
    );
  }

 Widget _buildButton(IconData icon, String text, void Function() onTap) {
  return ElevatedButton.icon(
    onPressed: () {
      if (formKey.currentState!.validate() && imageUrl.isNotEmpty) {
        // Aquí puedes definir la lógica para guardar los datos del auto,
        // incluyendo la URL de la imagen
        String matricula = matriculaController.text;
        String color = colorController.text;
        String altura = alturaController.text;
        String ancho = anchoController.text;
        String largo = largoController.text;
        String modelo = modeloController.text;
        String marca = marcaController.text; // Obtener el valor del campo de marca
        // La variable 'imageUrl' ya almacena la URL de la imagen seleccionada

        // Mostrar mensaje de éxito al guardar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('¡Guardado con éxito!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Mostrar un mensaje de error si la imagen no ha sido seleccionada
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Debes seleccionar una imagen'),
            backgroundColor: Colors.red,
          ),
        );
      }
    },
    icon: Icon(icon),
    label: Text(text),
  );
}

}
