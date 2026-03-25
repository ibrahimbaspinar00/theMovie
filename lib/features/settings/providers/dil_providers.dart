import 'package:flutter/material.dart';

class DilProvider extends ChangeNotifier {
  Locale _locale = const Locale('tr');

  Locale get locale => _locale;

  void dilDegistir(Locale yeniLocale) {
    _locale = yeniLocale;
    notifyListeners();
  }
}