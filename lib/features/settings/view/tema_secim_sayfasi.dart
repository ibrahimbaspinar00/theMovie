import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/features/settings/providers/tema_provider.dart';

class TemaSecimSayfasi extends StatelessWidget {
  const TemaSecimSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final temaProvider = Provider.of<TemaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tema Seçimi"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          RadioListTile<ThemeMode>(
            title: const Text("Açık Tema"),
            value: ThemeMode.light,
            groupValue: temaProvider.themeMode,
            onChanged: (value) {
              if (value != null) {
                temaProvider.temayiDegistir(value);
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text("Koyu Tema"),
            value: ThemeMode.dark,
            groupValue: temaProvider.themeMode,
            onChanged: (value) {
              if (value != null) {
                temaProvider.temayiDegistir(value);
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text("Sistem Varsayılanı"),
            value: ThemeMode.system,
            groupValue: temaProvider.themeMode,
            onChanged: (value) {
              if (value != null) {
                temaProvider.temayiDegistir(value);
              }
            },
          ),
        ],
      ),
    );
  }
}