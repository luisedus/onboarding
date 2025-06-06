import 'package:flutter/material.dart';

class PendingTripsScreen extends StatelessWidget {
  final List<String> trips = ['Viaje 1 - 8:00 AM', 'Viaje 2 - 10:00 AM', 'Viaje 3 - 1:00 PM'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trips.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            title: Text(trips[index]),
            trailing: ElevatedButton(
              child: Text('Iniciar'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Iniciando \${trips[index]}'),
                ));
              },
            ),
          ),
        );
      },
    );
  }
}