import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
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
            // User Profile Section
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('URL de la foto de perfil'),
              ),
              title: Text('Nombre del Usuario'),
              subtitle: Text('Correo electrónico'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Lógica para editar el perfil
                },
              ),
            ),
            // Account Settings Section
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración de la cuenta'),
              onTap: () {
                // Navegar a la pantalla de configuración de la cuenta
              },
            ),
            // Activity History Section
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Historial de actividad'),
              onTap: () {
                // Navegar a la pantalla de historial de actividad
              },
            ),
            // Search Functionality Section
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Buscar'),
              onTap: () {
                // Navegar a la pantalla de búsqueda
              },
            ),
          ],
        ),
      ),
    );
  }
}
