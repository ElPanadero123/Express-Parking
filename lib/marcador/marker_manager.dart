import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../Listas/GarajeInfo.dart';
import '../fakeTaxi/ParqueosDataModel.dart'; // Asegúrate de que el import es correcto

class MarkerManager {
  final BuildContext context;
  final String userToken; // Token del usuario para la autenticación en la API

  MarkerManager(this.context, this.userToken);

  Future<Set<Marker>> loadMarkers() async {
    final url = Uri.parse('http://tu-api-url.com/garajes');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $userToken',
    });

    if (response.statusCode == 200) {
      Iterable json = jsonDecode(response.body);
      return json.map((garaje) {
        var parqueoData = Garaje.fromJson(garaje);
        if (parqueoData.latitud != null && parqueoData.longitud != null) {
          return Marker(
            markerId: MarkerId(parqueoData.id.toString()),
            position: LatLng(parqueoData.latitud!, parqueoData.longitud!),
            infoWindow: InfoWindow(
              title: parqueoData.direccion,
              snippet: parqueoData.referencias,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GarajeInfo(data: parqueoData),
                ));
              },
            ),
            icon: BitmapDescriptor.defaultMarker,
          );
        } else {
          throw Exception(
              'Latitud o longitud nulas para garaje ${parqueoData.id}');
        }
      }).toSet();
    } else {
      throw Exception('Failed to load markers from API');
    }
  }
}
