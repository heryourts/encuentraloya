import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carrito de compra')),
      body: const Center(
        child: Text(
          'Aquí verás los platos que agregaste al carrito',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
