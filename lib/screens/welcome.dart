import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  final List<String> trips = const ['Viaje 1 - 8:00 AM', 'Viaje 2 - 10:00 AM', 'Viaje 3 - 1:00 PM'];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          'Bienvenido, conductor',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 20),
        Text('Viajes pendientes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        ...trips.map((trip) => Card(
              child: ListTile(title: Text(trip)),
            )),
      ],
    );
  }
}