import 'package:flutter/material.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comidas')),
      body: const Center(
        child: Text(
          'Aquí se mostrarán las comidas disponibles',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
