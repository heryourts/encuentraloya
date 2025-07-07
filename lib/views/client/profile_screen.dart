import 'package:flutter/material.dart';

class ClientProfileScreen extends StatelessWidget {
  const ClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: const Center(
        child: Text(
          'Aquí se mostrará tu perfil como cliente',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
