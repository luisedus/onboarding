import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'login.dart'; 

// Servicio para API
class ApiService {
  static Future<bool> crearUsuario(Map<String, String> data) async {
    final url = Uri.parse('http://localhost:3000/api/usuarios'); // Cambia la URL si es necesario

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        print('Error en registro: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Excepción en crearUsuario: $e');
      return false;
    }
  }
}

// Pantalla de registro
class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void registrarUsuario(BuildContext context) async {
    final nombre = nameController.text.trim();
    final correo = emailController.text.trim();
    final contrasena = passwordController.text.trim();

    if (nombre.isEmpty || correo.isEmpty || contrasena.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    if (!correo.contains('@') || correo.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Correo inválido')),
    );
  return;
}

    final success = await ApiService.crearUsuario({
      'nombre': nombre,
      'correo': correo,
      'contrasena': contrasena,
    });

    print("Resultado del registro: $success");

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registro exitoso. Inicia sesión.')),
      );

      // Volver al login reemplazando la pantalla actual
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro de Conductor')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Correo electrónico'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Registrarse'),
              onPressed: () => registrarUsuario(context),
            ),
          ],
        ),
      ),
    );
  }
}
