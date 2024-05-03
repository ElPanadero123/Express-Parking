import 'package:express_parking/Listas/HistorialParqueadas.dart';
import 'package:express_parking/Listas/ParkingList.dart';
import 'package:express_parking/Listas/VehiculosList.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'FormularioGaraje.dart';
import 'FormularioAuto.dart';
import 'package:flutter/services.dart'; // Importar el paquete services

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({Key? key}) : super(key: key);

  @override
  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor:
          Colors.transparent, // Color de fondo de la barra de estado
      statusBarIconBrightness:
          Brightness.dark, // Iconos de la barra de estado oscuros
    ));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Color.fromARGB(136, 224, 224, 224),
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
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
      drawer: Drawer(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20), // Espacio adicional para bajar el header
              UserAccountsDrawerHeader(
                accountName: Text("JOSE ALEM RODRIGUEZ VALVERDE"),
                accountEmail: Text("josealem03@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.grey[700],
                  child: Align(
                    alignment: Alignment(
                        0, 0.3), // Ajusta la posición vertical del ícono
                    child: Icon(Icons.person, size: 50.0, color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 250, 205, 83), // Color amarillo
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle, color: Colors.grey[600]),
                title: Text('Mi cuenta'),
                onTap: () {}, // Implementar navegación
              ),
              ListTile(
                leading: Icon(Icons.garage, color: Colors.grey[600]),
                title: Text('Registro de Garaje'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => parkingList()));
                },
              ),
              ListTile(
                leading: Icon(Icons.directions_car, color: Colors.grey[600]),
                title: Text('Registro de Vehículo'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VehiculosList()));
                },
              ),
              ListTile(
                leading: Icon(Icons.campaign, color: Colors.grey[600]),
                title: Text('Creación de Oferta'),
                onTap: () {}, // Implementar navegación
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
                }, // Implementar navegación
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.red),
                title: Text('Cerrar sesión'),
                onTap: () {
                  Navigator.of(context)
                      .pop(); // Implementar funcionalidad de cierre de sesión
                },
              ),
            ],
          ),
        ),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(-17.78629, -63.18117),
          zoom: 11.0,
        ),
        mapType: MapType.normal,
      ),
    );
  }
}
