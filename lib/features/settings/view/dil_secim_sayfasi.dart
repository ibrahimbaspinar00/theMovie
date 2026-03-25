import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/features/settings/providers/dil_providers.dart';

class DilSecimSayfasi extends StatelessWidget {
  const DilSecimSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final dilProvider = Provider.of<DilProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dil Seçimi"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          RadioListTile<Locale>(
            title: const Text("Türkçe"),
            value: const Locale('tr'),
            groupValue: dilProvider.locale,
            onChanged: (Locale? value) {
              if (value != null) {
                dilProvider.dilDegistir(value);
              }
            },
          ),
          RadioListTile<Locale>(
            title: const Text("English"),
            value: const Locale('en'),
            groupValue: dilProvider.locale,
            onChanged: (Locale? value) {
              if (value != null) {
                dilProvider.dilDegistir(value);
              }
            },
          ),
        ],
      ),
    );
  }
}