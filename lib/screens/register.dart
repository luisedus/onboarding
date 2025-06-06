import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'login.dart'; 

// Servicio para API
class ApiService {
  static Future<bool> crearUsuario(Map<String, String> data) async {
  final url = Uri.parse('http://10.0.2.2:3000/api/usuarios');//si usas emulador es esta, si no es localhost

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
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isNameValid = true;

  void registrarUsuario(BuildContext context) async {
    final nombre = nameController.text.trim();
    final correo = emailController.text.trim();
    final contrasena = passwordController.text.trim();

    setState(() {
      isNameValid = nombre.isNotEmpty;
      isEmailValid = correo.contains('@') && correo.length >= 5;
      isPasswordValid = contrasena.length >= 6;
    });

    if (!isNameValid || !isEmailValid || !isPasswordValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, corrige los campos marcados')),
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
              decoration: InputDecoration(
                labelText: 'Nombre',
                errorText: isNameValid ? null : 'El nombre no puede estar vacío',
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                errorText: isEmailValid ? null : 'Correo inválido',
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                errorText: isPasswordValid ? null : 'Mínimo 6 caracteres',
              ),
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
