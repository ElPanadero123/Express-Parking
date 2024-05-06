import 'package:express_parking/fakeTaxi/ParqueosDataModel.dart';
import 'package:flutter/material.dart';

class GarajeDetailPage extends StatelessWidget {
  final Garaje garaje;

  const GarajeDetailPage({Key? key, required this.garaje}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(garaje.nombre),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Dirección: ${garaje.direccion}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Referencias: ${garaje.referencias}',
                style: TextStyle(fontSize: 16)),
            // Continúa añadiendo otros detalles que necesites mostrar.
          ],
        ),
      ),
    );
  }
}
