import 'package:flutter/material.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurantes')),
      body: const Center(
        child: Text(
          'Aquí se mostrarán los restaurantes',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
