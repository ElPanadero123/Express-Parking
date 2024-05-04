import 'dart:convert';
import 'package:express_parking/fakeTaxi/ParqueosDataModel.dart';
import 'package:http/http.dart' as http;

import 'package:express_parking/formularios/FormularioGaraje.dart';
import 'package:express_parking/Listas/GarajeInfo.dart';
import 'package:flutter/material.dart';

class ParkingList extends StatefulWidget {
  final String userToken;

  ParkingList({Key? key, required this.userToken}) : super(key: key);

  @override
  State<ParkingList> createState() => ParkingListState();
}

class ParkingListState extends State<ParkingList> {
  Future<List<Garaje>> fetchGarajes() async {
    final url = Uri.parse('http://tu-api-url.com/garajes');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${widget.userToken}',
    });

    if (response.statusCode == 200) {
      final List<dynamic> garajesJson = json.decode(response.body);
      return garajesJson.map((json) => Garaje.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load garages from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Garaje>>(
        future: fetchGarajes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final garaje = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GarajeInfo(data: garaje),
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
                                      garaje.direccion,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, right: 8),
                                    child: Text(garaje.referencias),
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
            return Center(child: CircularProgressIndicator());
          }
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
