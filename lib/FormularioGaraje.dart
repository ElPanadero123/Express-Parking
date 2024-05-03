import 'package:flutter/material.dart';
import 'CrearOferta.dart';  // Importa la pantalla CrearOfertaPage

class FormularioGaraje extends StatelessWidget {
  const FormularioGaraje({Key? key});

  @override
  Widget build(BuildContext context) {
    final anchoController = TextEditingController();
    final largoController = TextEditingController();
    final direccionController = TextEditingController();
    final notasController = TextEditingController(); // Cambiado a notas
    final referenciasController = TextEditingController(); // Nuevo controlador para referencias
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Agregar un Nuevo Garaje",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "EMPIEZA A GANAR DINERO",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 30),
                  _buildTextField(Icons.aspect_ratio, "Ancho del Garaje (metros)", anchoController),
                  SizedBox(height: 10),
                  _buildTextField(Icons.height, "Largo del Garaje (metros)", largoController),
                  SizedBox(height: 10),
                  _buildTextField(Icons.location_on, "Dirección del Garaje", direccionController),
                  SizedBox(height: 10), // Espacio adicional entre los campos
                  _buildTextField(Icons.notes, "Notas", notasController), // Cambiado a notas
                  SizedBox(height: 10),
                  _buildTextField(Icons.notes, "Referencias", referenciasController), // Cambiado a notas
                  SizedBox(height: 30),
                  _buildButton(Icons.map, "Ir al Mapa", () {
                    // Agrega aquí la lógica para ir al mapa
                  }),
                  SizedBox(height: 30), // Ajusta el espacio según sea necesario
                  _buildButton(Icons.save, "CREA UNA OFERTA", () {
                    if (formKey.currentState!.validate()) {
                      // Obtener los valores de los campos
                      final ancho = double.tryParse(anchoController.text);
                      final largo = double.tryParse(largoController.text);
                      final direccion = direccionController.text;
                      final notas = notasController.text;
                      final referencias = referenciasController.text;
                      final latitud = ''; // Agregar la lógica para obtener la latitud
                      final longitud = ''; // Agregar la lógica para obtener la longitud

                      // Validar los tipos de datos
                      if (ancho == null || largo == null) {
                        // Mostrar un mensaje de error si los campos de ancho y largo no son números válidos
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Los campos de ancho y largo deben ser números válidos.'),
                          ),
                        );
                      } else {
                        // Los tipos de datos son correctos, puedes navegar a la pantalla CrearOfertaPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CrearOfertaPage()),
                        );

                        // Limpiar los campos después de guardar los datos
                        anchoController.clear();
                        largoController.clear();
                        direccionController.clear();
                        notasController.clear();
                        referenciasController.clear();
                      }
                    } else {
                      // Mostrar un mensaje de error si algún campo no es válido
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Por favor, completa todos los campos correctamente.'),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: SizedBox(
        height: 60,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.text, // Cambiado a text
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
            contentPadding: EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon, String text, void Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }
}
