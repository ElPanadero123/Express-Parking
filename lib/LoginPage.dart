import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'PantallaPrincipal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

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
          // Intentar iniciar sesión
          _iniciarSesion(correoController.text, passwordController.text, context);
        }
      },
      icon: Icon(icon),
      label: Text(text),
    );
  }

  Future<void> _iniciarSesion(String correo, String password, BuildContext context) async {
    try {
      // Aquí debes implementar la lógica para iniciar sesión con el backend
      // Por ahora, simplemente simularemos un inicio de sesión exitoso si los campos no están vacíos
      if (correo.isNotEmpty && password.isNotEmpty) {
        // Iniciar sesión exitoso, navegar a la pantalla principal
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PantallaPrincipal()),
        );
      } else {
        // Iniciar sesión fallido, mostrar un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Inicio de sesión fallido. Verifique sus credenciales.'),
          ),
        );
      }
    } catch (error) {
      // Error al intentar iniciar sesión
      print('Error al iniciar sesión: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al iniciar sesión: $error'),
        ),
      );
    }
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
    final telefonoController = TextEditingController();
    final passwordController = TextEditingController();
    final imagenPerfilController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: Text(" REGISTRATE AQUI "),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Aquí puedes implementar la lógica para seleccionar una imagen de perfil
                // Por ahora, simplemente imprimiremos un mensaje
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
                  _buildTextField(Icons.phone, "Teléfono", telefonoController),
                  const SizedBox(height: 10),
                  _buildTextField(Icons.lock, "Contraseña", passwordController),
                  const SizedBox(height: 10),
                  _buildTextField(Icons.image, "Imagen de Perfil", imagenPerfilController, isRequired: false),
                  const SizedBox(height: 30),
                  _buildButton(Icons.app_registration, "REGISTRARSE", context, formKey, nombreController, apellidoController, ciController, correoController, telefonoController, passwordController, imagenPerfilController),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String label, TextEditingController controller, {bool isRequired = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'Este campo es obligatorio';
          }
          // Validación adicional para los campos de CI y Teléfono
          if (label == 'CI' && (value != null && value.isNotEmpty && int.tryParse(value) == null)) {
            return 'Ingrese un valor numérico válido';
          }
          if (label == 'Teléfono' && (value != null && value.isNotEmpty && int.tryParse(value) == null)) {
            return 'Ingrese un número de teléfono válido';
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

  Widget _buildButton(IconData icon, String text, BuildContext context, GlobalKey<FormState> formKey, TextEditingController nombreController, TextEditingController apellidoController, TextEditingController ciController, TextEditingController correoController, TextEditingController telefonoController, TextEditingController passwordController, TextEditingController imagenPerfilController) {
    return ElevatedButton.icon(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          // Realizar la conversión adecuada para los campos numéricos (CI y teléfono)
          final int ci = int.tryParse(ciController.text) ?? 0;
          final int telefono = int.tryParse(telefonoController.text) ?? 0;

          // Crear el objeto de datos del usuario
          final userData = {
            'nombre': nombreController.text,
            'apellido': apellidoController.text,
            'ci': ci,
            'correo': correoController.text,
            'telefono': telefono,
            'password': passwordController.text,
            'imagenPerfil': imagenPerfilController.text, // Puedes usar la URL de la imagen o dejarla como un campo vacío si no se selecciona ninguna imagen
          };

          // Enviar los datos del registro al backend en formato JSON
          enviarRegistroABackend(userData, context);
        }
      },
      icon: Icon(icon),
      label: Text(text),
    );
  }

  Future<void> enviarRegistroABackend(Map<String, dynamic> userData, BuildContext context) async {
    try {
      // Enviar la solicitud HTTP al backend
      final response = await http.post(
        Uri.parse('URL_DE_TU_ENDPOINT'), // Reemplaza 'URL_DE_TU_ENDPOINT' por la URL de tu endpoint de registro
        body: userData,
      );

      // Verificar la respuesta
      if (response.statusCode == 200) {
        // Registro exitoso
        print('Registro exitoso');
        // Puedes realizar alguna acción adicional, como navegar a la pantalla principal
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PantallaPrincipal()),
        );
      } else {
        // Error en la solicitud
        print('Error en el registro: ${response.body}');
        // Puedes mostrar un mensaje de error al usuario
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error en el registro: ${response.body}'),
          ),
        );
      }
    } catch (error) {
      // Error al enviar la solicitud
      print('Error al enviar datos al backend: $error');
      // Puedes mostrar un mensaje de error al usuario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al enviar datos al backend: $error'),
        ),
      );
    }
  }
}
