import 'dart:convert';


import 'package:express_parking/fakeTaxi/ParqueosDataModel.dart';
import 'package:express_parking/formularios/FormularioGaraje.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

class ParkingList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ParkingListState();
  }
}

class ParkingListState extends State<ParkingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                'Av Piray 6to anillo',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la pantalla de creación de nuevo vehículo
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormularioGaraje()),
          );
        },
        tooltip: 'Crear nuevo vehiculo',
        child: Icon(Icons.add),
      ),
    );
  }
}

  Future<List<Garaje>> ReadJsonData() async {
    // En lugar de cargar datos desde un archivo JSON, podrías obtenerlos de otra manera
    // Por ejemplo, podrías realizar una solicitud HTTP a una API para obtener datos reales
    // Aquí simplemente retornaremos una lista vacía para simular la obtención de datos
    return [];
  }

