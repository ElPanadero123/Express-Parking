import 'dart:convert';
import 'package:express_parking/token/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Listas/GarajeInfo.dart';
import '../fakeTaxi/ParqueosDataModel.dart'; // Asegúrate de que el import es correcto
import 'package:http/http.dart' as http;

class MarkerManager {
  final BuildContext context;

  MarkerManager(this.context);

  Future<Set<Marker>> loadMarkers() async {
    try {
      var url = Uri.parse(
          'https://laravelapiparking-production.up.railway.app/api/getall');
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer ${GlobalToken.userToken}',
      });

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var garajesJson = jsonResponse['garajes'] as List;
        Set<Marker> markers = {};

        for (var garajeJson in garajesJson) {
          var garaje = Garaje.fromJson(garajeJson);
          if (garaje.latitud != null && garaje.longitud != null) {
            var marker = Marker(
              markerId: MarkerId(garaje.id.toString()),
              position: LatLng(garaje.latitud!, garaje.longitud!),
              infoWindow: InfoWindow(
                title: garaje.direccion,
                snippet: garaje.referencias,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GarajeInfo(data: garaje),
                  ));
                },
              ),
              icon: BitmapDescriptor.defaultMarker,
            );
            markers.add(marker);
          } else {
            // Maneja el caso en que la latitud o longitud son nulas
            // Por ejemplo, no agregar el marcador o usar valores predeterminados
            print("Latitud o longitud nulas para garaje ${garaje.id}");
          }
        }
        return markers;
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw Exception('Failed to load garage data');
      }
    } catch (e) {
      print('Error al cargar los garajes: $e');
      rethrow;
    }
  }
}
