import 'package:flutter/material.dart';
import 'FormularioGaraje.dart';
import 'wave_animation.dart';
import 'FormularioAuto.dart';

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla Principal'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20), // Espacio en la parte superior
          Container(
            color: const Color.fromARGB(255, 152, 16, 16), // Color rojo vino
            padding: EdgeInsets.symmetric(vertical: 20), // Añadir un margen arriba
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CarAnimation(
                      duration: Duration(seconds: 2),
                      child: Text(
                        'PARKING EXPRESS',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold), // Hacer las letras más pequeñas
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20), // Espacio entre el texto y los botones
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Navega a la pantalla del formulario del garaje cuando se presiona el botón
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FormularioGaraje()),
                        );
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0), // Ajustar el radio de los bordes
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.purple), // Color morado de los botones
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5), // Ajustar el tamaño del botón
                        child: Text(
                          'Agregar Garaje',
                          style: TextStyle(
                            color: Colors.black, // Establecer el color del texto en negro
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Espacio entre los botones
                    ElevatedButton(
                      onPressed: () {
                        // Navega a la pantalla del formulario para agregar un auto
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FormularioAuto()),
                        );
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0), // Ajustar el radio de los bordes
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Color verde del nuevo botón
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5), // Ajustar el tamaño del botón
                        child: Text(
                          'Agregar Auto',
                          style: TextStyle(
                            color: Colors.black, // Establecer el color del texto en negro
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Bienvenido a la Pantalla Principal',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
