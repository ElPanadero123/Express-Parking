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
      List<dynamic> jsonList =
          jsonDecode(data); // Cambiado a List<dynamic> para mejor claridad
      Set<Marker> markers = {};

      for (var garajeJson in jsonList) {
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
          throw Exception('Latitud o longitud nulas para garaje ${garaje.id}');
        }
      }
      return markers;
    } catch (e) {
      print('Error al cargar o parsear los marcadores: $e');
      rethrow;
    }
  }
}
