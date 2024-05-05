import 'dart:async';
import 'dart:convert';
import 'package:express_parking/fakeTaxi/ParqueosDataModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'FormularioSeccion.dart';
import 'package:express_parking/token/token.dart';

class FormularioGaraje extends StatefulWidget {
  @override
  _FormularioGarajeState createState() => _FormularioGarajeState();
}

class _FormularioGarajeState extends State<FormularioGaraje> {
  TextEditingController direccionController = TextEditingController();
  TextEditingController latitudController = TextEditingController();
  TextEditingController longitudController = TextEditingController();
  TextEditingController imagenController = TextEditingController();
  TextEditingController anchoController = TextEditingController();
  TextEditingController largoController = TextEditingController();
  TextEditingController notasController = TextEditingController();
  TextEditingController referenciasController = TextEditingController();
  GoogleMapController? mapController;
  LatLng? currentLocation;
  Timer? _debouncer;
  final formKey = GlobalKey<FormState>();
  List<Seccion> secciones = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si los servicios de ubicación están habilitados
    serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(
          msg: 'Los servicios de ubicación están desactivados.');
      return;
    }

    // Verificar los permisos de ubicación
    permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
      if (permission == geo.LocationPermission.denied) {
        Fluttertoast.showToast(
            msg: 'Los permisos de ubicación fueron denegados');
        return;
      }
    }

    if (permission == geo.LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Los permisos de ubicación están permanentemente denegados, no podemos solicitar permisos.');
      return;
    }

    // Obtener la posición actual
    try {
      geo.Position position = await geo.Geolocator.getCurrentPosition(
          desiredAccuracy: geo.LocationAccuracy.high);
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        _updateLocation(currentLocation!);
        mapController
            ?.animateCamera(CameraUpdate.newLatLngZoom(currentLocation!, 15));
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error al obtener la ubicación actual: $e');
    }
  }


  void _onCameraMove(CameraPosition position) {
    if (_debouncer?.isActive ?? false) _debouncer!.cancel();
    _debouncer = Timer(const Duration(milliseconds: 1000), () {
      _updateLocation(position.target);
    });
  }

  void _updateLocation(LatLng location) async {
    setState(() {
      currentLocation = location;
    });
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        direccionController.text =
            '${place.name}, ${place.locality}, ${place.country}';
        latitudController.text = location.latitude.toString();
        longitudController.text = location.longitude.toString();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error al buscar la dirección: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agregar Garaje")),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _buildMap(),
              _buildTextField(
                  direccionController, "Dirección del Garaje", Icons.map),
              _buildTextField(latitudController, "Latitud", Icons.location_on),
              _buildTextField(
                  longitudController, "Longitud", Icons.location_on),
              _buildTextField(
                  imagenController, "URL de la imagen", Icons.image),
              _buildTextField(anchoController, "Ancho", Icons.aspect_ratio),
              _buildTextField(largoController, "Largo", Icons.aspect_ratio),
              _buildTextField(notasController, "Notas", Icons.note),
              _buildTextField(
                  referenciasController, "Referencias", Icons.notes),
              ElevatedButton(
                onPressed: _addNewSeccion,
                child: Text("Agregar Sección"),
              ),
              ...secciones.map(_buildSeccionTile),
              ElevatedButton(
                onPressed: _saveGarage,
                child: Text("Guardar Garaje"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMap() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition:
              CameraPosition(target: currentLocation ?? LatLng(0, 0), zoom: 15),
          markers: {
            if (currentLocation != null)
              Marker(
                markerId: MarkerId("currentLocation"),
                position: currentLocation!,
                draggable: true,
                onDragEnd: _updateLocation,
              )
          },
          onCameraMove: _onCameraMove,
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          prefixIcon: Icon(icon),
        ),
        onChanged: (value) {
          if (_debouncer?.isActive ?? false) _debouncer!.cancel();
          _debouncer = Timer(const Duration(milliseconds: 1000), () {
            if (value != null && value.isNotEmpty) {
              _updateLocationFromAddress(value.toString());
            }
          });
        },

        validator: (value) =>
            value!.isEmpty ? 'Este campo es obligatorio' : null,
      ),
    );
  }

  void _updateLocationFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        setState(() {
          currentLocation = LatLng(location.latitude, location.longitude);
          mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(currentLocation!, 15),
          );
          direccionController.text = address;
          latitudController.text = location.latitude.toString();
          longitudController.text = location.longitude.toString();
        });
      } else {
        Fluttertoast.showToast(
            msg:
                'No se encontraron resultados para la dirección proporcionada');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error al buscar la dirección: $e');
    }
  }


  Widget _buildSeccionTile(Seccion sec) {
    return ListTile(
      title: Text(
          "Sección ${sec.idSeccion}: ${sec.ancho}m x ${sec.largo}m, ${sec.altura}m alto"),
      subtitle: Text(
          "${sec.estado}, Disponible desde ${sec.horaInicio} hasta ${sec.horaFinal}"),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => setState(() => secciones.remove(sec)),
      ),
    );
  }

  void _addNewSeccion() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioSeccion(
          onAdd: (Seccion newSection) {
            setState(() {
              secciones.add(newSection);
            });
            Fluttertoast.showToast(msg: "Sección añadida");
          },
        ),
      ),
    );
  }

  void _saveGarage() async {
    if (!formKey.currentState!.validate() || secciones.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Complete todos los campos y añada al menos una sección.');
      return;
    }

    var garajeData = {
      'direccion': direccionController.text,
      'latitud': latitudController.text,
      'longitud': longitudController.text,
      'secciones': secciones.map((s) => s.toJson()).toList(),
      'imagen_garaje': imagenController.text,
      'ancho': double.parse(anchoController.text),
      'largo': double.parse(largoController.text),
      'notas': notasController.text,
      'referencias': referenciasController.text,
    };

    var response = await http.post(
      Uri.parse('https://api.example.com/garajes'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${GlobalToken.userToken}',
      },
      body: json.encode(garajeData),
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Garaje guardado con éxito!');
    } else {
      Fluttertoast.showToast(
          msg: 'Error al guardar el garaje: ${response.body}');
    }
  }
}
