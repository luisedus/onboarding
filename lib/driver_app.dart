import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


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

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              decoration: InputDecoration(labelText: 'Correo electrónico'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Iniciar Sesión'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              },
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

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
// ------------------------- MODELO Y SERVICIO HTTP -------------------------

class Product {
  final int id;
  final String title;
  final String description;
  final num price;
  final int stock;
  final String thumbnail;
  final List<dynamic> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
    required this.thumbnail,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      stock: json['stock'] ?? 0,
      thumbnail: json['thumbnail'] ?? '',
      images: json['images'] ?? [],
    );
  }
}

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com';

  /// Lab 1: GET /products?limit=XX
  Future<List<Product>> fetchProducts({int limit = 20}) async {
    final uri = Uri.parse('$_baseUrl/products?limit=$limit');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> list = data['products'];
      return list.map((jsonProd) => Product.fromJson(jsonProd)).toList();
    } else {
      throw Exception('Error al cargar productos');
    }
  }

  /// Lab 2: GET /products/:id
  Future<Product> fetchProductById(int id) async {
    final uri = Uri.parse('$_baseUrl/products/$id');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return Product.fromJson(data);
    } else {
      throw Exception('Producto no encontrado');
    }
  }

  /// Lab 3: GET /products/search?q=<query>
  Future<List<Product>> searchProducts(String query) async {
    final uri = Uri.parse('$_baseUrl/products/search?q=$query');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> list = data['products'];
      return list.map((jsonProd) => Product.fromJson(jsonProd)).toList();
    } else {
      throw Exception('Error en búsqueda');
    }
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const WelcomeScreen(),
    const RoutesScreen(),
    PendingTripsScreen(),
    DailySalesScreen(),
    const CatalogScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Rutas'),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Pendientes'),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Ventas'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Catálogo'),
        ],
      ),
    );
  }
}

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

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  bool _mapExpanded = false;
  final List<String> routes = ['Ruta A', 'Ruta B', 'Ruta C'];

  void _addRoute() {
    showDialog(
      context: context,
      builder: (context) {
        final _controller = TextEditingController();

        return AlertDialog(
          title: const Text('Agregar nueva ruta'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Nombre de ruta'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                print('Ruta agregada: \${_controller.text}');
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rutas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addRoute,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: _mapExpanded ? 2 : 1,
                  child: GestureDetector(
                    onTap: () => setState(() => _mapExpanded = !_mapExpanded),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: FlutterMap(
                        options: MapOptions(
                          center: LatLng(21.8853, -102.2916),
                          zoom: 13,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c'],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: routes.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: Icon(Icons.directions),
                      title: Text(routes[index]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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

class DailySalesScreen extends StatelessWidget {
  final double totalSales = 1520.75;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(30),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.monetization_on, size: 60, color: Colors.green),
              SizedBox(height: 20),
              Text('Ventas del Día',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('\$${totalSales.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 28, color: Colors.green)),
            ],
          ),
        ),
      ),
    );
  }
}
// ------------------------- LAB 1: CATÁLOGO DE PRODUCTOS -------------------------

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = _apiService.fetchProducts(limit: 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Productos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final products = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  childAspectRatio: 0.70,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(product: product);
                },
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

/// Tarjeta individual de producto (nombre, imagen, precio).
class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: product.id)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  product.thumbnail,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(Icons.broken_image, size: 60),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                product.title,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '\$${product.price}',
                style: const TextStyle(color: Colors.green, fontSize: 14),
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}

// ------------------------- LAB 2: DETALLE DE PRODUCTO -------------------------

class ProductDetailScreen extends StatefulWidget {
  final int productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ApiService _apiService = ApiService();
  late Future<Product> _futureProduct;

  @override
  void initState() {
    super.initState();
    _futureProduct = _apiService.fetchProductById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Producto'),
      ),
      body: FutureBuilder<Product>(
        future: _futureProduct,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final product = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Carousel sencillo de imágenes
                    SizedBox(
                      height: 250,
                      child: PageView.builder(
                        itemCount: product.images.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product.images[index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product.title,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Precio: \$${product.price}',
                      style: const TextStyle(fontSize: 20, color: Colors.green),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Stock: ${product.stock}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
// ------------------------- LAB 3: BUSCADOR DE PRODUCTOS -------------------------

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  List<Product> _results = [];
  bool _isLoading = false;
  String _errorMsg = '';

  void _onSearch() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;
    setState(() {
      _isLoading = true;
      _errorMsg = '';
      _results = [];
    });
    try {
      final list = await _apiService.searchProducts(query);
      setState(() {
        _results = list;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMsg = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Productos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _onSearch(),
            ),
            const SizedBox(height: 12),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_errorMsg.isNotEmpty)
              Text('Error: $_errorMsg', style: const TextStyle(color: Colors.red))
            else if (_results.isEmpty)
              const Text('Ingresa un término y presiona Enter')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: _results[index]);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
