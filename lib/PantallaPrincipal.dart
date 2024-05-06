import 'dart:convert';

import 'package:express_parking/Listas/OfertasList.dart';
import 'package:express_parking/Listas/historial.dart';
import 'package:express_parking/LoginPage.dart';
import 'package:express_parking/token/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'marcador/marker_manager.dart';
import 'Listas/VehiculosList.dart';
import 'Listas/ParkingList.dart';
import 'Usuario/user.dart';
import 'package:http/http.dart' as http;

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({Key? key}) : super(key: key);

  @override
  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal>
    with WidgetsBindingObserver {
  late GoogleMapController mapController;
  late MarkerManager markerManager;
  Set<Marker> markers = {};
  var nombreCompleto;
  var correo;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    markerManager = MarkerManager(context);
    _loadMarkers();
    _determinePosition();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');
    final response = await http.get(
      Uri.parse(
          'https://laravelapiparking-production.up.railway.app/api/showUser'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['status'] == 200) {
        setState(() {
          nombreCompleto =
              "${data['usuario']['nombre']} ${data['usuario']['apellido']}";
          correo = data['usuario']['correo'];
        });
      }
    } else {
      // Manejar errores adecuadamente
      print('Error al obtener los datos del usuario: ${response.body}');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    mapController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      mapController.setMapStyle("[]"); // Refrescar el mapa
      _loadMarkers(); // Recargar marcadores para asegurar que están actualizados
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _loadMarkers() async {
    try {
      var markersData = await markerManager.loadMarkers();
      setState(() {
        markers = markersData;
      });
    } catch (e) {
      print('Error al cargar marcadores: $e');
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Solo obtener la posición y actualizar la cámara sin añadir un marcador adicional.
    Position position = await Geolocator.getCurrentPosition();
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14,
        bearing: 0,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 100,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(150, 255, 255, 255),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: "¿A dónde quieres ir?",
              border: InputBorder.none,
              icon: Icon(Icons.search, color: Colors.black),
              hintStyle: TextStyle(color: Colors.black),
            ),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      drawer: buildDrawer(context),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(-17.78629, -63.18117),
          zoom: 14.0,
        ),
        markers: markers,
        mapType: MapType.normal,
        myLocationEnabled: true,
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[800],
                        child: const Icon(Icons.person,
                            size: 50.0, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(nombreCompleto ?? "Cargando...",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Text(correo ?? "Cargando...",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
              buildListTile(Icons.account_circle, 'Mi cuenta',
                  () => navigateTo(context, UserProfileScreen())),
              buildListTile(Icons.garage, 'Lista de Garaje',
                  () => navigateTo(context, ParkingList())),
              buildListTile(Icons.directions_car, 'Lista de Vehículo',
                  () => navigateTo(context, VehiculosList())),
              buildListTile(Icons.campaign, 'Creación de Oferta',
                  () => navigateTo(context, OfertasList())),
              buildListTile(Icons.history, 'Historial',
                  () => navigateTo(context, HistorialAccionesExitosas())),
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.red),
                title: const Text('Cerrar sesión'),
                onTap: () {
                  GlobalToken.userToken = null;
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildListTile(IconData icon, String title, Function onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  void navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
