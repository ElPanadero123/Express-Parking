import 'package:flutter/material.dart';
import '../fakeTaxi/ParqueosDataModel.dart'; // Asegúrate de que la ruta de importación es correcta

class GarajeInfo extends StatefulWidget {
  final Garaje data;

  GarajeInfo({required this.data});

  @override
  _GarajeInfoState createState() => _GarajeInfoState();
}

class _GarajeInfoState extends State<GarajeInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildTopContent(),
          Expanded(child: _buildBottomContent()),
        ],
      ),
    );
  }

Widget _buildTopContent() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
          bottom:
              Radius.circular(25.0)), // Bordes redondeados en la parte inferior
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade800, Colors.black87],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
              vertical: 40.0), // Eliminado el padding horizontal
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              ),
              SizedBox(height: 20),
              Text(
                'Información del Garaje',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '${widget.data.nombre}',
                style: TextStyle(color: Colors.white70, fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildBottomContent() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Dirección: ${widget.data.direccion}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Referencias: ${widget.data.referencias}',
                style: TextStyle(fontSize: 16)),
            Divider(),
            Text('Secciones:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...widget.data.secciones.map((seccion) => ListTile(
                  title:
                      Text('Sección ${seccion.idSeccion} - ${seccion.estado}'),
                  subtitle: Text(
                      'Dimensiones: ${seccion.ancho}m x ${seccion.largo}m, Altura: ${seccion.altura}m'),
                  trailing: Icon(Icons.info_outline),
                  onTap: () => _showSeccionInfo(seccion),
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Guardar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Nuevo color para el botón
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSeccionInfo(Seccion seccion) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Detalles de la Sección ${seccion.idSeccion}"),
          content: Text('Estado: ${seccion.estado}\n'
              'Dimensiones: ${seccion.ancho}m x ${seccion.largo}m\n'
              'Altura: ${seccion.altura}m\n'
              'Disponibilidad: ${seccion.horaInicio} - ${seccion.horaFinal}'),
          actions: <Widget>[
            TextButton(
              child: Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  void _saveData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Guardar Datos"),
          content:
              const Text("Los datos del garaje se han guardado correctamente."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
          ],
        );
      },
    );
  }
}
