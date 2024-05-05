import 'dart:convert'; 

import 'package:express_parking/token/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'PantallaPrincipal.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final correoController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: const Text("INICIA SESIÓN"),
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
                  const Text("Bienvenido de Nuevo",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  const Text("LOGIN",
                      style:
                          TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 30),
                  _buildTextField(
                      Icons.email, "Correo Electrónico", correoController),
                  const SizedBox(height: 10),
                  _buildPasswordField(
                      Icons.lock, "Contraseña", passwordController),
                  const SizedBox(height: 30),
                  _buildButton(Icons.login, "INGRESAR", () {
                    if (formKey.currentState!.validate()) {
                      _iniciarSesion(correoController.text,
                          passwordController.text, context);
                    }
                  }),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("¿No tienes una cuenta?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegistroPage()));
                        },
                        child: const Text("Regístrate aquí"),
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

  Widget _buildTextField(
      IconData icon, String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es obligatorio';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField(
      IconData icon, String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es obligatorio';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildButton(IconData icon, String text, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
    );
  }

  Future<void> _iniciarSesion(
      String correo, String password, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://laravelapiparking-production.up.railway.app/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'correo': correo,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final String token = json.decode(response.body)['token'];
        GlobalToken.userToken = token;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const PantallaPrincipal()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Inicio de sesión fallido. Verifique sus credenciales.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: $e')),
      );
    }
  }
}
class RegistroPage extends StatelessWidget {
  const RegistroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nombreController = TextEditingController();
    final apellidoController = TextEditingController();
    final ciController = TextEditingController();
    final correoController = TextEditingController();
    final telefonoController = TextEditingController();
    final passwordController = TextEditingController();
    final imagenPerfilController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: const Text("REGÍSTRATE AQUÍ"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                print('Seleccionar imagen de perfil');
              },
            ),
          ),
        ],
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
                  const Text("Bienvenido",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  const Text("REGISTRO",
                      style:
                          TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 30),
                  _buildTextField(Icons.person, "Nombre", nombreController),
                  const SizedBox(height: 10),
                  _buildTextField(Icons.person, "Apellido", apellidoController),
                  const SizedBox(height: 10),
                  _buildTextField(Icons.credit_card, "CI", ciController),
                  const SizedBox(height: 10),
                  _buildTextField(
                      Icons.email, "Correo Electrónico", correoController),
                  const SizedBox(height: 10),
                  _buildTextField(Icons.phone, "Teléfono", telefonoController),
                  const SizedBox(height: 10),
                  _buildTextField(Icons.lock, "Contraseña", passwordController),
                  const SizedBox(height: 10),
                  _buildTextField(
                      Icons.image, "Imagen de Perfil", imagenPerfilController,
                      isRequired: false),
                  const SizedBox(height: 30),
                  _buildButton(Icons.app_registration, "REGISTRARSE", () {
                    if (formKey.currentState!.validate()) {
                      _registrar(
                          nombreController.text,
                          apellidoController.text,
                          ciController.text,
                          correoController.text,
                          telefonoController.text,
                          passwordController.text,
                          imagenPerfilController.text,
                          context);
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

  Widget _buildTextField(
      IconData icon, String label, TextEditingController controller,
      {bool isRequired = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'Este campo es obligatorio';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon, String text, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
    );
  }

  Future<void> _registrar(
      String nombre,
      String apellido,
      String ci,
      String correo,
      String telefono,
      String password,
      String imagenPerfil,
      BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://laravelapiparking-production.up.railway.app/api/usuarios'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'nombre': nombre,
          'apellido': apellido,
          'ci': ci,
          'correo': correo,
          'telefono': telefono,
          'password': password,
          'imagenPerfil': imagenPerfil
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registro exitoso')),
        );
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error en el registro: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al enviar datos al backend: $e')),
      );
    }
  }
}