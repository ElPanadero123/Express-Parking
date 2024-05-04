import 'package:express_parking/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'marcador/marker_manager.dart';
import 'Listas/VehiculosList.dart';
import 'Listas/ParkingList.dart';
import 'formularios/CrearOferta.dart';
import 'Listas/HistorialParqueadas.dart';
import 'Usuario/user.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    markerManager = MarkerManager(context);
    _loadMarkers();
    _determinePosition();
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

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            UserAccountsDrawerHeader(
              accountName: const Text("JOSE ALEM RODRIGUEZ VALVERDE"),
              accountEmail: const Text("josealem03@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey[700],
                child: const Align(
                  alignment: Alignment(0, 0.3),
                  child: Icon(Icons.person, size: 50.0, color: Colors.white),
                ),
              ),
              decoration: const BoxDecoration(
                color:  Color.fromARGB(255, 147, 83, 250),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color: Colors.grey[600]),
              title: const Text('Mi cuenta'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfileScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.garage, color: Colors.grey[600]),
              title: const Text('Registro de Garaje'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => parkingList()));
              },
            ),
            ListTile(
              leading: Icon(Icons.directions_car, color: Colors.grey[600]),
              title: const Text('Registro de Vehículo'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VehiculosList()));
              },
            ),
            ListTile(
              leading: Icon(Icons.campaign, color: Colors.grey[600]),
              title: Text('Creación de Oferta'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CrearOfertaPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: Colors.grey[600]),
              title: Text('Historial'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HistorialParqueadas()));
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Cerrar sesión'),
              onTap: () {
                // Aquí debes implementar la lógica de cierre de sesión
                // Por ejemplo, borrar datos de usuario, etc.
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        const LoginPage())); 
              },
            ),
          ],
        ),
      ),
    );
  }
}
