import 'package:express_parking/fakeTaxi/OfertasDataModel.dart';
import 'package:flutter/material.dart';
import '../fakeTaxi/ParqueosDataModel.dart'; // Asegúrate de que la ruta de importación es correcta

class VehiculoInfo extends StatefulWidget {
  

 

  @override
  _VehiculoInfoState createState() => _VehiculoInfoState();
}

class _VehiculoInfoState extends State<VehiculoInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildTopContent(),
          _buildBottomContent(),
        ],
      ),
    );
  }

  Widget _buildTopContent() {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: Color.fromRGBO(130, 131, 134, 0.898),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: Text(
              'Información del Vehiculo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomContent() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
                'Modelo: Sudan'),
            Text(
                'Placa: HFDHS'),
            SizedBox(height: 20), // Añade un espacio entre textos y el botón
            
          ],
        ),
      ),
    );
  }

  
}
