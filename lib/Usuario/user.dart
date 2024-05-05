import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:express_parking/token/token.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late String _username;
  late String _email;

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    final response = await http.get(
      Uri.parse('https://laravelapiparking-production.up.railway.app/api/showUser'),
      headers: <String, String>{
        'Authorization': 'Bearer ${GlobalToken.userToken}',
      },
    );
    print('Body: ${response.body}');
    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);
  final usuarioData = userData['usuario'];
  setState(() {
    _username = usuarioData['nombre'];
    _email = usuarioData['correo'];

      });
    } else {
      print('Error al obtener los datos del usuario: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Text(
                    _username ?? 'Cargando...',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _email ?? 'Cargando...',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Lógica para editar el perfil
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
