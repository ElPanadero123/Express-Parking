import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FormularioGaraje extends StatelessWidget {
  const FormularioGaraje({Key? key});

  @override
  Widget build(BuildContext context) {
    final anchoController = TextEditingController();
    final largoController = TextEditingController();
    final alturaController = TextEditingController();
    final direccionController = TextEditingController();
    final descripcionController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    // Simulando secciones guardadas
    bool seccionesGuardadas = false;

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
                        "Secciones",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(width: 10),
                      seccionesGuardadas
                          ? _buildDropdownButton(context)
                          : _buildAgregarSeccionButton(context),
                    ],
                  ),
                  SizedBox(height: 20),
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
                  SizedBox(height: 10),
                  _buildTextField(Icons.description, "Descripción del Garaje", descripcionController),
                  SizedBox(height: 80),
                  _buildButton(Icons.save, "GUARDAR GARAJE", () {}),
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

  Widget _buildDropdownButton(BuildContext context) {
    return DropdownButton<String>(
      items: [
        DropdownMenuItem<String>(
          value: 'Sección A',
          child: Text('Sección A'),
        ),
        DropdownMenuItem<String>(
          value: 'Sección B',
          child: Text('Sección B'),
        ),
        DropdownMenuItem<String>(
          value: 'Sección C',
          child: Text('Sección C'),
        ),
      ],
      onChanged: (value) {
        if (value == "Agregar Sección") {
          _mostrarFormularioSeccion(context);
        } else {
          _mostrarToast(context, "Secciones: $value");
        }
      },
      hint: Text('Seleccionar Sección'),
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
      onChanged: (value) {
        if (value == "Agregar Sección") {
          _mostrarFormularioSeccion(context);
        }
      },
      hint: Text('Seleccionar Sección'),
    );
  }

  void _mostrarToast(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM_LEFT,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
  }

  void _mostrarFormularioSeccion(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Agregar Sección'),
          ),
          body: SingleChildScrollView( // Agregar SingleChildScrollView
            child: FormularioSeccion(),
          ),
        );
      },
    ),
  );
}


}


class FormularioSeccion extends StatelessWidget {
  const FormularioSeccion({Key? key});

  @override
  Widget build(BuildContext context) {
    final imagenSeccionController = TextEditingController();
    final anchoController = TextEditingController();
    final largoController = TextEditingController();
    final horaInicioController = TextEditingController();
    final horaFinalController = TextEditingController();
    final alturaController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Imagen de la Sección:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: imagenSeccionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Ingrese la URL de la Imagen',
                    prefixIcon: Icon(Icons.image),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ancho (metros):',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: anchoController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Ingrese el Ancho',
                    prefixIcon: Icon(Icons.aspect_ratio),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Largo (metros):',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: largoController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Ingrese el Largo',
                    prefixIcon: Icon(Icons.height),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Altura (metros):',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: alturaController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Ingrese la Altura',
                    prefixIcon: Icon(Icons.vertical_align_bottom),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
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
                      horaInicioController.text = pickedTime.format(context);
                    }
                  },
                  child: Text(
                    horaInicioController.text.isNotEmpty ? horaInicioController.text : 'Seleccionar Hora de Inicio',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      horaFinalController.text = pickedTime.format(context);
                    }
                  },
                  child: Text(
                    horaFinalController.text.isNotEmpty ? horaFinalController.text : 'Seleccionar Hora de Fin',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                // Lógica para guardar la sección
              },
              child: Text('Guardar'),
            ),
          ),
        ],
      ),
    );
  }
}

