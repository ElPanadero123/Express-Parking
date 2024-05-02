import 'package:flutter/material.dart';
import 'PantallaPrincipal.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final correoController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: Text(" INICIA SESION "),
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
                  const SizedBox(height: 20),
                  Text(
                    "Bienvenido de Nuevo",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  _buildTextField(Icons.email, "Correo Electrónico", correoController),
                  const SizedBox(height: 10),
                  _buildTextField(Icons.password, "Contraseña", passwordController),
                  const SizedBox(height: 30),
                  _buildButton(Icons.admin_panel_settings_rounded, "INGRESAR", correoController, passwordController, formKey, context),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("¿No tienes una cuenta?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegistroPage()),
                          );
                        },
                        child: Text("Ingresa aquí"),
                      ),
                    ],
                  ),
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

  Widget _buildButton(IconData icon, String text, TextEditingController correoController, TextEditingController passwordController, GlobalKey<FormState> formKey, BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          // Verificar si los campos de correo y contraseña no están vacíos
          if (correoController.text.isNotEmpty && passwordController.text.isNotEmpty) {
            // Navegar a la PantallaInicio
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PantallaPrincipal()),
            );
          } else {
            // Mostrar un mensaje de error si algún campo está vacío
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Por favor, ingrese un correo electrónico y una contraseña válidos.'),
              ),
            );
          }
        }
      },
      icon: Icon(icon),
      label: Text(text),
    );
  }
}

class RegistroPage extends StatelessWidget {
  const RegistroPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final nombreController = TextEditingController();
    final apellidoController = TextEditingController();
    final ciController = TextEditingController();
    final correoController = TextEditingController();
    final passwordController = TextEditingController();
    final celularController = TextEditingController(); // Nuevo controlador para el número de celular
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: Text(" REGISTRATE AQUI "),
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
                  const SizedBox(height: 20),
                  Text(
                    "Bienvenido",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "REGISTRO",
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  _buildTextField(Icons.person, "Nombre", nombreController),
                  const SizedBox(height: 10),
                  _buildTextField(Icons.person, "Apellido", apellidoController),
                  const SizedBox(height: 10),
                  _buildTextField(Icons.credit_card, "CI", ciController),
                  const SizedBox(height: 10),
                  _buildTextField(Icons.email, "Correo Electrónico", correoController),
                  const SizedBox(height: 10),
                  _buildTextField(Icons.password, "Contraseña", passwordController),
                  const SizedBox(height: 10),
                  _buildTextField(Icons.phone, "Número de Celular", celularController), // Nuevo campo de número de celular
                  const SizedBox(height: 30),
                  _buildButton(Icons.app_registration, "REGISTRARSE", () {
                    if (formKey.currentState!.validate()) {
                      // Aquí puedes definir la lógica para el registro
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
