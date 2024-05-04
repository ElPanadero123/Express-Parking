import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Listas/GarajeInfo.dart';
import '../fakeTaxi/ParqueosDataModel.dart'; // Asegúrate de que el import es correcto

class MarkerManager {
  final BuildContext context;

  MarkerManager(this.context);

  Future<Set<Marker>> loadMarkers() async {
    try {
      String data = await rootBundle.loadString('json/parqueos.json');
      Iterable json = jsonDecode(data);
      return json.map((garaje) {
        var parqueoData = ParqueosDataModel.fromJson(garaje);
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
    } catch (e) {
      print('Error al cargar o parsear los marcadores: $e');
      rethrow;
    }
  }
}
