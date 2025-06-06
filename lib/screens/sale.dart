import 'package:flutter/material.dart';

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