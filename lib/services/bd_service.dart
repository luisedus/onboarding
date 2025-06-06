import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3000/api'; // Usa http://10.0.2.2 si estás en emulador Android. y para IOS=Usa http://localhost o tu IP real si estás en iOS o un dispositivo físico

  // Dentro de tu clase ApiService
static Future<bool> crearUsuario(Map<String, dynamic> usuario) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/usuarios'), // Asegúrate de que esta ruta exista en tu backend
      headers: {'Content-Type': 'application/json'},
      body: json.encode(usuario),
    );

    if (response.statusCode == 201 || response.statusCode == 201) {
      return true;
    } else {
      print('Error al registrar: ${response.body}');
      return false;
    }
  } catch (e) {
    print('Excepción al registrar usuario: $e');
    return false;
  }
}


  static Future<List<dynamic>> getUsuarios() async {
    final response = await http.get(Uri.parse('$baseUrl/usuarios'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar usuarios');
    }
  }
    static Future<List<dynamic>> getProductos() async {
    final response = await http.get(Uri.parse('$baseUrl/productos'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar productos');
    }
  }
  static Future<List<dynamic>> getRutas() async {
    final response = await http.get(Uri.parse('$baseUrl/rutas'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar rutas');
    }
  }
  static Future<List<dynamic>> getMensajes() async {
    final response = await http.get(Uri.parse('$baseUrl/mensajes'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar mensajes');
    }
  }
  static Future<List<dynamic>> getConductores() async {
    final response = await http.get(Uri.parse('$baseUrl/conductores'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar conductores');
    }
  }
  static Future<List<dynamic>> getTareas() async {
    final response = await http.get(Uri.parse('$baseUrl/tareas'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar tareas');
    }
  }
}
