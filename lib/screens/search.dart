import 'package:flutter/material.dart';
import '../product/producto.dart';
import '../services/api_service.dart';
import 'detProducto.dart';
import '../widgets/producto_card.dart';

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
