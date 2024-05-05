import 'package:flutter/material.dart';

class NegociarOfertanteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Negociar Ofertante'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'Precio Ofertado',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '99',
                    style:
                        TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Contra oferta:',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Ingrese el valor',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Acción al presionar el botón Cancelar
                  },
                  child: Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Acción al presionar el botón Enviar
                  },
                  child: Text('Contra ofertar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Acción al presionar el tercer botón
                  },
                  child: Text('Aceptar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
