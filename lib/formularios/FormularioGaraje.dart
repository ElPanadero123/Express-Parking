import 'dart:convert';
import 'package:express_parking/formularios/FormularioSeccion.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario de Garaje',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormularioGaraje(),
    );
  }
}

class FormularioGaraje extends StatefulWidget {
  const FormularioGaraje({Key? key}) : super(key: key);

  @override
  _FormularioGarajeState createState() => _FormularioGarajeState();
}

class _FormularioGarajeState extends State<FormularioGaraje> {
  final anchoController = TextEditingController();
  final largoController = TextEditingController();
  final alturaController = TextEditingController();
  final direccionController = TextEditingController();
  final descripcionController = TextEditingController();
  final seccionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> secciones = [];

  @override
  Widget build(BuildContext context) {
    bool seccionesGuardadas = secciones.isNotEmpty;

    Future<void> _guardarGaraje(BuildContext context) async {
      if (!formKey.currentState!.validate() || !seccionesGuardadas) {
        return;
      }

      final garaje = {
        'ancho': anchoController.text,
        'largo': largoController.text,
        'altura': alturaController.text,
        'direccion': direccionController.text,
        'descripcion': descripcionController.text,
        'secciones': secciones,
      };

      // Lógica para guardar el garaje aquí
    }

    void _agregarSeccion(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Agregar Sección"),
            content: Builder(
              builder: (context) => FormularioSeccion(),
            ),
          );
        },
      );
    }

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
                  SizedBox(height: 20),
                  _buildTextField(Icons.aspect_ratio, "Ancho del Garaje (metros)", anchoController),
                  SizedBox(height: 10),
                  _buildTextField(Icons.height, "Largo del Garaje (metros)", largoController),
                  SizedBox(height: 10),
                  _buildTextField(Icons.vertical_align_bottom, "Altura del Garaje (metros)", alturaController),
                  SizedBox(height: 10),
                  _buildTextField(Icons.location_on, "Dirección del Garaje", direccionController),
                  SizedBox(height: 10),
                  _buildTextField(Icons.description, "Descripción del Garaje", descripcionController),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "Secciones",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              seccionesGuardadas
                                  ? _buildDropdownButton()
                                  : _buildAgregarSeccionButton(context),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 80),
                  _buildButton(Icons.save, "GUARDAR GARAJE", () {
                    _guardarGaraje(context);
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
        height: 100,
        child: TextFormField(
          controller: controller,
          maxLines: null,
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

  Widget _buildButton(IconData icon, String text, void Function()? onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(text),
    );
  }

  Widget _buildDropdownButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Text(
              "Secciones",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        DropdownButton<String>(
          alignment: Alignment.centerLeft,
          items: secciones
              .map((seccion) => DropdownMenuItem<String>(
                    value: seccion,
                    child: Text(seccion),
                  ))
              .toList(),
          onChanged: (value) {
            // Puedes implementar lógica adicional aquí
          },
          hint: Text('Seleccionar Sección'),
        ),
      ],
    );
  }

  Widget _buildAgregarSeccionButton(BuildContext context) {
    return DropdownButton<String>(
      items: [
        DropdownMenuItem<String>(
          value: 'Agregar Sección',
          child: Text('Agregar Sección'),
        ),
      ],
      onChanged: (String? value) {
        if (value != null && value == "Agregar Sección") {
          // Navega a la pantalla FormularioSeccion
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormularioSeccion()),
          );
        }
      },
      hint: Text('Seleccionar Sección'),
    );
  }
}

class ParkingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Garajes"),
      ),
      body: Center(
        child: Text("Aquí va la lista de garajes"),
      ),
    );
  }
}
