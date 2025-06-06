import 'package:flutter/material.dart';
import 'welcome.dart';
import 'routes.dart';
import 'rutaPen.dart';
import 'sale.dart';
import 'catalogo.dart';
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