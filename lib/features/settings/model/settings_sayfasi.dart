import 'package:flutter/material.dart';
import 'package:themoviedb/features/settings/view/dil_secim_sayfasi.dart';
import 'package:themoviedb/features/settings/view/tema_secim_sayfasi.dart';

class SettingsSayfasi extends StatelessWidget {
  const SettingsSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar", style: TextStyle(fontSize: 17)),
        //centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text("Tema"),
            subtitle: const Text("Açık / Koyu tema seçimi"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TemaSecimSayfasi(),
                ),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Dil"),
            subtitle: const Text("Dil Ayarlarınızı Düzenleme"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DilSecimSayfasi(),
                ),
              );
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("Hakkında"),
            subtitle: const Text("Uygulama bilgileri"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
