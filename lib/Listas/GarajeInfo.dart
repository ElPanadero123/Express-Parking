import 'package:flutter/material.dart';
import '../fakeTaxi/ParqueosDataModel.dart'; // Asegúrate de que la ruta de importación es correcta

class GarajeInfo extends StatefulWidget {
  final Garaje  data;

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
          _buildBottomContent(),
        ],
      ),
    );
  }

  Widget _buildTopContent() {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: Color.fromRGBO(130, 131, 134, 0.898),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: Text(
              'Información del Garaje',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomContent() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
                'Dirección: ${widget.data.direccion ?? "Dirección no disponible"}'),
            Text(
                'Referencias: ${widget.data.referencias ?? "Referencias no disponibles"}'),
            SizedBox(height: 20), // Añade un espacio entre textos y el botón
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Guardar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Color del botón
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveData() {
    // Aquí puedes definir la lógica para realmente guardar los datos, por ahora solo mostraremos un mensaje.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Guardar Datos"),
          content: const Text("Los datos del garaje se han guardado correctamente."),
          actions: <Widget>[
            FlatButton(
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
  
  FlatButton({required Text child, required Null Function() onPressed}) {}
}
