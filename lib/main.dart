import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/viewmodels/film_view_model.dart';
import 'package:themoviedb/views/ana_sayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FilmViewModel()..tumVerileriGetir(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Movie DB',
        theme: ThemeData(useMaterial3: true),
        home: const AnaSayfa(),
      ),
    );
  }
}
