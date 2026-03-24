import 'package:flutter/material.dart';

class FavorilerSayfa extends StatelessWidget {
  const FavorilerSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Henuz favori film yok',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}