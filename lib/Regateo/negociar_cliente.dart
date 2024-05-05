import 'package:flutter/material.dart';

class NegociarClienteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Negociar Cliente'),
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
                    'Precio estimado',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '100',
                    style:
                        TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Oferta:',
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
            SizedBox(height: 30), // Espacio agregado
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
                  child: Text('Enviar'),
                ),
              ],
            ),
            SizedBox(height: 20), // Espacio agregado
          ],
        ),
      ),
    );
  }
}
