import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/features/favorite/view/favoriler_sayfasi.dart';
import 'package:themoviedb/features/home/model/film_model.dart';
import 'package:themoviedb/features/home/view/widgets/film_kart.dart';
import 'package:themoviedb/features/home/view_model/film_view_model.dart';
import 'package:themoviedb/features/profile/profil_sayfasi.dart';
import 'package:themoviedb/features/settings/model/settings_sayfasi.dart';
import 'package:themoviedb/l10n/app_localizations.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int seciliIndex = 0;

  Widget filmBolumu({
    required String baslik,
    required List<FilmModel> filmler,
    required String bosMesaj,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          baslik,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        if (filmler.isEmpty)
          Container(
            height: 90,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(bosMesaj),
          )
        else
          SizedBox(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filmler.length,
              itemBuilder: (context, index) {
                return FilmKart(film: filmler[index]);
              },
            ),
          ),
      ],
    );
  }

  Widget anaIcerik(FilmViewModel vm, AppLocalizations dil) {
    if (vm.yukleniyor) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (vm.hataMesaji.isNotEmpty) {
      return Center(
        child: Text(vm.hataMesaji),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          filmBolumu(
            baslik: dil.popular,
            filmler: vm.popularFilmler,
            bosMesaj: dil.noDataInCategory,
          ),
          const SizedBox(height: 24),
          filmBolumu(
            baslik: dil.upcoming,
            filmler: vm.yakindaGelecekFilmler,
            bosMesaj: dil.noDataInCategory,
          ),
          const SizedBox(height: 24),
          filmBolumu(
            baslik: dil.topRated,
            filmler: vm.enCokIzlenenFilmler,
            bosMesaj: dil.noDataInCategory,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FilmViewModel>();
    final dil = AppLocalizations.of(context)!;

    final List<Widget> sayfalar = [
      anaIcerik(vm, dil),
      const FavorilerSayfasi(),
      const SettingsSayfasi(),
      const ProfilSayfa(),
    ];

    if (seciliIndex >= sayfalar.length) {
      seciliIndex = 0;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(dil.appTitle),
        centerTitle: true,
      ),
      body: sayfalar[seciliIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: seciliIndex,
        onDestinationSelected: (index) {
          setState(() {
            seciliIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: dil.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.favorite_border),
            selectedIcon: const Icon(Icons.favorite),
            label: dil.favorites,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: dil.settings,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: dil.profile,
          ),
        ],
      ),
    );
  }
}