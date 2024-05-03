import 'dart:convert';

import 'package:express_parking/fakeTaxi/ParqueadasDataModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

class HistorialParqueadas extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HistorialParqueadasState();
  }
}

class HistorialParqueadasState extends State<HistorialParqueadas> {
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
          var items = data.data as List<ParqueadasDataModel>;
          return ListView.builder(
              itemCount: items == null ? 0 : items.length,
              itemBuilder: (context, index) {
                return Card(
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
                                  items[index].horaInicio.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Text(items[index].horaFin.toString()),
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              });
        } else {
          // show circular progress while data is getting fetched from json file
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  Future<List<ParqueadasDataModel>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('json/Historial.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => ParqueadasDataModel.fromJson(e)).toList();
  }
}
