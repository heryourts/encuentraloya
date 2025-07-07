import 'package:flutter/foundation.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isClient = true;
  String? _userEmail;
  String? _userName;

  bool get isLoggedIn => _isLoggedIn;
  bool get isClient => _isClient;
  String? get userEmail => _userEmail;
  String? get userName => _userName;

  Future<bool> login(String email, String password, bool isClient) async {
    try {
      // Aquí harías la llamada real a tu API
      // Por ahora simularemos un login exitoso
      
      // Simular delay de red
      await Future.delayed(const Duration(seconds: 1));
      
      // Validación básica (reemplaza con tu lógica real)
      if (email.isNotEmpty && password.length >= 6) {
        _isLoggedIn = true;
        _isClient = isClient;
        _userEmail = email;
        _userName = isClient ? 'Cliente Usuario' : 'Restaurante Demo';
        
        notifyListeners();
        return true;
      }
      
      return false;
    } catch (e) {
      debugPrint('Error en login: $e');
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required bool isClient,
    String? nombres,
    String? apellidos,
    String? telefono,
    String? nombreComercial,
    String? categoria,
  }) async {
    try {
      // Aquí harías la llamada real a tu API de registro
      await Future.delayed(const Duration(seconds: 2));
      
      // Simular registro exitoso
      if (email.isNotEmpty && password.length >= 6) {
        // No logueamos automáticamente después del registro
        // El usuario debe verificar su email primero
        return true;
      }
      
      return false;
    } catch (e) {
      debugPrint('Error en registro: $e');
      return false;
    }
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _isClient = true;
    _userEmail = null;
    _userName = null;
    notifyListeners();
  }

  Future<bool> verifyEmail(String code) async {
    try {
      // Aquí harías la verificación real del código
      await Future.delayed(const Duration(seconds: 1));
      
      // Simular verificación exitosa
      if (code.length == 6) {
        return true;
      }
      
      return false;
    } catch (e) {
      debugPrint('Error en verificación: $e');
      return false;
    }
  }
}
