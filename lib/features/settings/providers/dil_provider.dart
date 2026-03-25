import 'package:flutter/material.dart';

class DilProvider extends ChangeNotifier {
  Locale _seciliLocale = const Locale('tr');

  Locale get seciliLocale => _seciliLocale;

  void dilDegistir(Locale yeniLocale) {
    if (_seciliLocale == yeniLocale) {
      return;
    }

    _seciliLocale = yeniLocale;
    notifyListeners();
  }
}
