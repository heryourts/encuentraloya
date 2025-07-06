// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void login(String email, String password, bool isClient) {
    _user = UserModel(email: email, password: password, isClient: isClient);
    print('Usuario logeado: ${_user!.email} (${_user!.isClient ? "Cliente" : "Restaurante"})');
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
