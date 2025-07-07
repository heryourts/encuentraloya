// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  String selectedCategory = 'Todos';
  final TextEditingController _searchController = TextEditingController();

  final List<String> categories = [
    'Todos',
    'Pizzas',
    'Hamburguesas',
    'Ensaladas',
    'Postres',
    'Bebidas',
    'Sopas',
    'Pastas',
  ];

  // Datos de ejemplo para los platos
  final List<Map<String, dynamic>> _foods = [
    {
      'name': 'Pizza Margherita',
      'description': 'Pizza clásica con tomate, mozzarella y albahaca fresca',
      'price': 25.50,
      'category': 'Pizzas',
      'restaurant': 'Pizzería Roma',
      'rating': 4.8,
      'time': '25-30 min',
      'image': null,
    },
    {
      'name': 'Hamburguesa Clásica',
      'description': 'Carne de res, lechuga, tomate, cebolla y salsa especial',
      'price': 18.75,
      'category': 'Hamburguesas',
      'restaurant': 'Burger House',
      'rating': 4.6,
      'time': '15-20 min',
      'image': null,
    },
    {
      'name': 'Ensalada César',
      'description': 'Lechuga romana, crutones, parmesano y aderezo césar',
      'price': 12.00,
      'category': 'Ensaladas',
      'restaurant': 'Green Garden',
      'rating': 4.5,
      'time': '10-15 min',
      'image': null,
    },
    {
      'name': 'Pasta Carbonara',
      'description': 'Pasta con salsa cremosa, tocino y parmesano',
      'price': 22.00,
      'category': 'Pastas',
      'restaurant': 'Italiano Auténtico',
      'rating': 4.9,
      'time': '20-25 min',
      'image': null,
    },
    {
      'name': 'Sopa de Pollo',
      'description': 'Sopa casera con pollo, verduras y fideos',
      'price': 15.50,
      'category': 'Sopas',
      'restaurant': 'Cocina de la Abuela',
      'rating': 4.7,
      'time': '15-20 min',
      'image': null,
    },
  ];

  List<Map<String, dynamic>> get filteredFoods {
    var filtered = _foods;
    
    if (selectedCategory != 'Todos') {
      filtered = filtered.where((food) => food['category'] == selectedCategory).toList();
    }
    
    if (_searchController.text.isNotEmpty) {
      filtered = filtered.where((food) => 
        food['name'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
        food['restaurant'].toLowerCase().contains(_searchController.text.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      // Barra de búsqueda
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) => setState(() {}),
                          decoration: InputDecoration(
                            hintText: 'Buscar comidas o restaurantes...',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: Icon(Icons.clear, color: Colors.grey[500]),
                                    onPressed: () {
                                      _searchController.clear();
                                      setState(() {});
                                    },
                                  )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Categorías
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = selectedCategory == category;
                      
                      return Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: FilterChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                          backgroundColor: Colors.white,
                          selectedColor: Colors.green[600],
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected ? Colors.green[600]! : Colors.grey[300]!,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Lista de comidas
                Expanded(
                  child: filteredFoods.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          itemCount: filteredFoods.length,
                          itemBuilder: (context, index) {
                            return _buildFoodCard(filteredFoods[index]);
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No se encontraron resultados',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Intenta con otros términos de búsqueda',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCard(Map<String, dynamic> food) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(12), // Reducido de 16 a 12
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del plato
          Container(
            width: 70, // Reducido de 80 a 70
            height: 70, // Reducido de 80 a 70
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
              image: food['image'] != null
                  ? DecorationImage(
                      image: FileImage(food['image']),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: food['image'] == null
                ? Icon(
                    Icons.fastfood,
                    color: Colors.grey[400],
                    size: 28, // Reducido de 32 a 28
                  )
                : null,
          ),

          const SizedBox(width: 12), // Reducido de 16 a 12

          // Información del plato - Expandido para tomar el espacio disponible
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre y botón en la misma fila
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        food['name'],
                        style: TextStyle(
                          fontSize: 16, // Reducido de 18 a 16
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Botón agregar más pequeño
                    Container(
                      width: 36, // Tamaño fijo más pequeño
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.green[600],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {
                          _showAddToCartSnackBar(food['name']);
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20, // Reducido de 24 a 20
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 4),
                
                Text(
                  food['restaurant'],
                  style: TextStyle(
                    color: Colors.green[600],
                    fontSize: 13, // Reducido de 14 a 13
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 6), // Reducido de 8 a 6

                Text(
                  food['description'],
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13, // Reducido de 14 a 13
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 8), // Reducido de 12 a 8

                // Fila de información inferior
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber[600],
                      size: 14, // Reducido de 16 a 14
                    ),
                    const SizedBox(width: 2), // Reducido de 4 a 2
                    Text(
                      food['rating'].toString(),
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12, // Reducido de 14 a 12
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8), // Reducido de 16 a 8
                    Icon(
                      Icons.access_time,
                      color: Colors.grey[500],
                      size: 14, // Reducido de 16 a 14
                    ),
                    const SizedBox(width: 2), // Reducido de 4 a 2
                    Expanded(
                      child: Text(
                        food['time'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12, // Reducido de 14 a 12
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'S/ ${food['price'].toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16, // Reducido de 18 a 16
                        fontWeight: FontWeight.bold,
                        color: Colors.green[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  void _showAddToCartSnackBar(String foodName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$foodName agregado al carrito'),
        backgroundColor: Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        action: SnackBarAction(
          label: 'Ver carrito',
          textColor: Colors.white,
          onPressed: () {
            // Navegar al carrito
          },
        ),
      ),
    );
  }
}
