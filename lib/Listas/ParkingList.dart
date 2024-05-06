import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:express_parking/token/token.dart'; // Asegúrate de tener el token disponible
import 'package:express_parking/fakeTaxi/ParqueosDataModel.dart'; // Importa la definición correcta de Garaje y Seccion
import 'package:express_parking/Listas/GarajeInfo.dart';
import 'package:express_parking/formularios/FormularioGaraje.dart';

class ParkingList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ParkingListState();
}

class ParkingListState extends State<ParkingList> {
  List<Garaje> garajes = [];
  bool _isLoading = true; // Estado de carga
  String? _errorMessage; // Mensaje de error si no hay garajes

  @override
  void initState() {
    super.initState();
    fetchGarajes();
  }

  Future<void> fetchGarajes() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://laravelapiparking-production.up.railway.app/api/getGarajes'),
        headers: {'Authorization': 'Bearer ${GlobalToken.userToken}'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List garajesData = data['garajes'] as List;

        setState(() {
          garajes = garajesData.map((i) => Garaje.fromJson(i)).toList();
          _isLoading = false;
        });
      } else if (response.statusCode == 404) {
        setState(() {
          _errorMessage =
              "No se encontraron garajes registrados por este usuario";
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load garajes');
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Garajes"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : ListView.builder(
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
