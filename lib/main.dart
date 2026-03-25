import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/core/theme/app_theme.dart';
import 'package:themoviedb/features/home/view/ana_sayfa.dart';
import 'package:themoviedb/features/home/view_model/film_view_model.dart';
import 'package:themoviedb/features/settings/providers/dil_providers.dart';
import 'package:themoviedb/features/settings/providers/tema_provider.dart';
import 'package:themoviedb/l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DilProvider()),
        ChangeNotifierProvider(create: (_) => TemaProvider()),
        ChangeNotifierProvider(
          create: (_) => FilmViewModel()..tumVerileriGetir(),
        ),
      ],
      child: Consumer2<DilProvider, TemaProvider>(
        builder: (context, dilProvider, temaProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: temaProvider.themeMode,
            locale: dilProvider.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            onGenerateTitle: (context) =>
                AppLocalizations.of(context)?.appTitle ?? 'The Movie DB',
            home: const AnaSayfa(),
          );
        },
      ),
    );
  }
}