import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'FormularioGaraje.dart';
import 'FormularioAuto.dart';

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
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("JOSE ALEM RODRIGUEZ VALVERDE"),
              accountEmail: Text("josealem03@gmail.com"),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person, size: 50.0, color: Colors.white),
                backgroundColor: Colors.grey[700],
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 250, 205, 83),
              ),
            ),
            ListTile(
              leading: Icon(Icons.garage, color: Colors.grey[600]),
              title: Text('Agregar Garaje'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FormularioGaraje()));
              },
            ),
            ListTile(
              leading: Icon(Icons.directions_car, color: Colors.grey[600]),
              title: Text('Agregar Auto'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FormularioAuto()));
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(-17.78629, -63.18117),
                zoom: 11.0,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: kToolbarHeight + MediaQuery.of(context).padding.top,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
