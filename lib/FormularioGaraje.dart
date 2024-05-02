import 'package:flutter/material.dart';
import 'CrearOferta.dart'; // Importa la pantalla CrearOfertaPage

class FormularioGaraje extends StatelessWidget {
  const FormularioGaraje({Key? key});

  @override
  Widget build(BuildContext context) {
    final anchoController = TextEditingController();
    final largoController = TextEditingController();
    final alturaController = TextEditingController();
    final direccionController = TextEditingController();
    final descripcionController = TextEditingController(); // Nuevo controlador de texto para la descripción
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: Text("AGREGAR GARAJE"),
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
                        "Agregar un Nuevo Garaje",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "EMPIEZA A GANAR DINERO",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  _buildTextField(Icons.aspect_ratio, "Ancho del Garaje (metros)", anchoController),
                  SizedBox(height: 10),
                  _buildTextField(Icons.height, "Largo del Garaje (metros)", largoController),
                  SizedBox(height: 10),
                  _buildTextField(Icons.vertical_align_bottom, "Altura del Garaje (metros)", alturaController),
                  SizedBox(height: 10),
                  _buildTextField(Icons.location_on, "Dirección del Garaje", direccionController),
                  SizedBox(height: 10), // Espacio adicional entre los campos
                  _buildTextField(Icons.description, "Descripción del Garaje", descripcionController), // Nuevo campo de descripción
                  SizedBox(height: 80), // Ajusta el espacio según sea necesario
                  _buildButton(Icons.save, "CREA UNA OFERTA", () {
                    if (formKey.currentState!.validate()) {
                      // Aquí puedes definir la lógica para guardar los datos del garaje
                      
                      // Después de guardar los datos del garaje, navega a la pantalla CrearOfertaPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CrearOfertaPage()),
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
    child: SizedBox(
      height: 100, // Altura máxima del campo de descripción antes de expandirse hacia abajo
      child: TextFormField(
        controller: controller,
        maxLines: null, // Permite que el campo de texto tenga múltiples líneas
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
          contentPadding: EdgeInsets.symmetric(vertical: 10), // Espaciado interno vertical para el campo de texto
        ),
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
