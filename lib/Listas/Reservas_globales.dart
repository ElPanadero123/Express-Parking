import 'package:flutter/material.dart';

class Reservasglobales extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ReservasglobalesState();
  }
}

class ReservasglobalesState extends State<Reservasglobales> {
  // Lista para almacenar las acciones exitosas del usuario en formato JSON
  List<Map<String, dynamic>> accionesExitosas = [
    {
      'direccion': 'Calle 1',
      'secciones': '1',
      'precio': 'Precio 1',
    },
    {
      'direccion': 'calle 2',
      'secciones': '32',
      'precio': 'Precio 2',
    },
    {
      'direccion': 'calle 3',
      'secciones': '3',
      'precio': 'Precio 3',
    },
    // Agrega más acciones exitosas aquí según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Garajes disponibles'),
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
                    ubicacion: accionesExitosas[index]['direccion'],
                    hora: accionesExitosas[index]['secciones'],
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
                    Text('Direccion: ${accionesExitosas[index]['direccion']}'),
                    SizedBox(height: 8),
                    Text('Secciones: ${accionesExitosas[index]['secciones']}'),
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
        title: Text('Detalles del Garaje'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Direccion: $ubicacion'),
            SizedBox(height: 8),
            Text('Secciones: $hora'),
            SizedBox(height: 8),
            Text('Precio: $precio'),
          ],
        ),
      ),
    );
  }
}
