import 'package:flutter/material.dart';
import 'package:themoviedb/features/settings/view/dil_secim_sayfasi.dart';
import 'package:themoviedb/features/settings/view/tema_secim_sayfasi.dart';
import 'package:themoviedb/l10n/app_localizations.dart';

class SettingsSayfasi extends StatelessWidget {
  const SettingsSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final dil = AppLocalizations.of(context)!;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.palette),
            title: Text(dil.theme),
            subtitle: Text(dil.themeDescription),
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
            title: Text(dil.language),
            subtitle: Text(dil.languageDescription),
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
            title: Text(dil.about),
            subtitle: Text(dil.appInfo),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}