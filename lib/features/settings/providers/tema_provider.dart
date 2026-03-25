import 'package:flutter/material.dart';

class TemaProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void temayiDegistir(ThemeMode yeniTema) {
    _themeMode = yeniTema;
    notifyListeners();
  }
}