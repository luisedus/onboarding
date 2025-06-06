/*
import 'package:flutter/material.dart';
import 'driver_app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bienvenida',
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.directions_bus, size: 100, color: Colors.green),
              SizedBox(height: 20),
              Text('App de Conductores', style: TextStyle(fontSize: 24)),
              SizedBox(height: 40),
              ElevatedButton(
                child: Text('Entrar'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DriverApp()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'screens/login.dart';

void main() {
  runApp(DriverApp());
}

class DriverApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Conductores',
      theme: ThemeData(primarySwatch: Colors.green),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
