import 'package:flutter/material.dart';

class FormularioAuto extends StatelessWidget {
  const FormularioAuto({Key? key});

  @override
  Widget build(BuildContext context) {
    final matriculaController = TextEditingController();
    final colorController = TextEditingController();
    final alturaController = TextEditingController();
    final anchoController = TextEditingController();
    final largoController = TextEditingController();
    final modeloController = TextEditingController();
    final formKey = GlobalKey<FormState>();

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
                      // Aquí puedes definir la lógica para guardar los datos del auto
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
}
