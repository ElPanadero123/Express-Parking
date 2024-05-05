import 'package:flutter/material.dart';

class HistorialAccionesExitosas extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HistorialAccionesExitosasState();
  }
}

class HistorialAccionesExitosasState extends State<HistorialAccionesExitosas> {
  // Lista para almacenar las acciones exitosas del usuario en formato JSON
  List<Map<String, dynamic>> accionesExitosas = [
    {
      'ubicacion': 'Ubicacion 1',
      'hora': 'Hora 1',
      'precio': 'Precio 1',
    },
    {
      'ubicacion': 'Ubicacion 2',
      'hora': 'Hora 2',
      'precio': 'Precio 2',
    },
    {
      'ubicacion': 'Ubicacion 3',
      'hora': 'Hora 3',
      'precio': 'Precio 3',
    },
    // Agrega más acciones exitosas aquí según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Acciones Exitosas'),
      ),
      body: ListView.builder(
        itemCount: accionesExitosas.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Navega a la pantalla de detalles al tocar la tarjeta
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetallesHistorial(
                    ubicacion: accionesExitosas[index]['ubicacion'],
                    hora: accionesExitosas[index]['hora'],
                    precio: accionesExitosas[index]['precio'],
                  ),
                ),
              );
            },
            child: Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ubicación: ${accionesExitosas[index]['ubicacion']}'),
                    SizedBox(height: 8),
                    Text('Hora: ${accionesExitosas[index]['hora']}'),
                    SizedBox(height: 8),
                    Text('Precio: ${accionesExitosas[index]['precio']}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetallesHistorial extends StatelessWidget {
  final String ubicacion;
  final String hora;
  final String precio;

  DetallesHistorial({required this.ubicacion, required this.hora, required this.precio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Historial'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ubicación: $ubicacion'),
            SizedBox(height: 8),
            Text('Hora: $hora'),
            SizedBox(height: 8),
            Text('Precio: $precio'),
          ],
        ),
      ),
    );
  }
}
