import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
