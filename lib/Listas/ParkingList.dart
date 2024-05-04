import 'dart:convert';

import 'package:express_parking/formularios/FormularioGaraje.dart';
import 'package:express_parking/Listas/GarajeInfo.dart';
import 'package:express_parking/fakeTaxi/ParqueosDataModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

class parkingList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new parkingListState();
  }
}

class parkingListState extends State<parkingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            //in case if error found
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            //once data is ready this else block will execute
            // items will hold all the data of DataModel
            //items[index].name can be used to fetch name of product as done below
            var items = data.data as List<ParqueosDataModel>;
            return ListView.builder(
              itemCount: items == null ? 0 : items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navegar a Garajeinfo al hacer clic en el elemento de la lista
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GarajeInfo(data: items[index]),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, right: 8),
                                    child: Text(
                                      items[index].direccion.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, right: 8),
                                    child: Text(
                                      items[index].referencias.toString(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            // Muestra un círculo de progreso mientras se obtienen los datos del archivo JSON
            return Center(
              child: CircularProgressIndicator(),
            );
          }
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
        tooltip: 'Crear nuevo garaje',
        child: Icon(Icons.add),
      ),
    );
  }
}

Future<List<ParqueosDataModel>> ReadJsonData() async {
  final jsondata = await rootBundle.rootBundle.loadString('json/parqueos.json');
  final list = json.decode(jsondata) as List<dynamic>;

  return list.map((e) => ParqueosDataModel.fromJson(e)).toList();
}
