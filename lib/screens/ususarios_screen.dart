import 'package:flutter/material.dart';
import '../services/bd_service.dart';

class UsuariosScreen extends StatefulWidget {
  @override
  _UsuariosScreenState createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  List<dynamic> usuarios = [];

  @override
  void initState() {
    super.initState();
    cargarUsuarios();
  }

  Future<void> cargarUsuarios() async {
    final data = await ApiService.getUsuarios();//
    setState(() {
      usuarios = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Usuarios')),
      body: ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          final usuario = usuarios[index];
          return ListTile(
            title: Text(usuario['nombre'] ?? 'Sin nombre'),
            subtitle: Text('Correo: ${usuario['correo'] ?? ''}'),
          );
        },
      ),
    );
  }
}
