import 'package:flutter/material.dart';

class ProfilSayfa extends StatelessWidget {
  const ProfilSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        CircleAvatar(radius: 100, child: Icon(Icons.person, size: 100)),
        SizedBox(height: 16),
        Center(
          child: Text(
            'Kullanici Profili',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
