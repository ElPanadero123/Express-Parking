import 'dart:convert';
import 'package:express_parking/Listas/GarajeInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:express_parking/fakeTaxi/ParqueosDataModel.dart';
import 'package:express_parking/formularios/FormularioGaraje.dart';

class ParkingList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ParkingListState();
}

class ParkingListState extends State<ParkingList> {
  List<Garaje> garajes = [];

  @override
  void initState() {
    super.initState();
    readJsonData().then((data) {
      setState(() {
        garajes = data;
      });
    });
  }

  Future<List<Garaje>> readJsonData() async {
    final String response = await rootBundle.loadString('json/parqueos.json');
    final data = await json.decode(response) as List;
    return data.map((i) => Garaje.fromJson(i)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Garajes"),
      ),
      body: ListView.builder(
        itemCount: garajes.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              title: Text(garajes[index].nombre),
              subtitle: Text(garajes[index].direccion),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GarajeInfo(data: garajes[index])));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormularioGaraje()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Crear nuevo garaje',
      ),
    );
  }
}
