import 'package:flutter/material.dart';
import '/screens/register.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool emailError = false;
  bool passwordError = false;

  void validarYLogin(BuildContext context) {
    final correo = emailController.text.trim();
    final contrasena = passwordController.text.trim();

    setState(() {
      emailError = correo.isEmpty || !correo.contains('@') || correo.length < 5;
      passwordError = contrasena.isEmpty || contrasena.length < 6;
    });

    if (emailError || passwordError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa los campos correctamente')),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                errorText: emailError ? 'Correo inválido' : null,
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                errorText: passwordError ? 'Debe tener al menos 6 caracteres' : null,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Iniciar Sesión'),
              onPressed: () => validarYLogin(context),
            ),
            TextButton(
              child: Text('¿No tienes cuenta? Regístrate'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegisterScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
