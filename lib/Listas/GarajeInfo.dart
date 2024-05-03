import 'package:flutter/material.dart';
import '../fakeTaxi/ParqueosDataModel.dart';

class GarajeInfo extends StatefulWidget {
  final ParqueosDataModel data;

  GarajeInfo({required this.data});

  @override
  State<StatefulWidget> createState() {
    return new GarajeInfoState();
  }
}

class GarajeInfoState extends State<GarajeInfo> {
  @override
  Widget build(BuildContext context) {
    final topContent = Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: new BoxDecoration(
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
              'Informacion del Garaje',
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
        )
      ],
    );

    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
                'Dirección: ${widget.data.direccion ?? 'Dirección no disponible'}'),
            Text(
                'Referencias: ${widget.data.referencias ?? 'Referencias no disponibles'}'),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes definir la lógica para guardar los datos del auto
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
