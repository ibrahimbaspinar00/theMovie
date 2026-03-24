import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/film_model.dart';
import '../viewmodels/film_view_model.dart';
import '../widgets/film_kart.dart';
import 'favoriler_sayfasi.dart';
import 'profil_sayfasi.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int seciliIndex = 0;

  Widget filmBolumu(String baslik, List<FilmModel> filmler) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          baslik,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            child: const Text('Bu kategoride veri yok'),
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

  Widget anaIcerik(FilmViewModel vm) {
    if (vm.yukleniyor) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.hataMesaji.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 56),
              const SizedBox(height: 12),
              const Text(
                'Veri Alinamadi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(vm.hataMesaji, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: vm.tumVerileriGetir,
                child: const Text('Tekrar Dene'),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: vm.tumVerileriGetir,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            filmBolumu('Populer', vm.popularFilmler),
            const SizedBox(height: 24),
            filmBolumu('Upcoming', vm.yakindaGelecekFilmler),
            const SizedBox(height: 24),
            filmBolumu('Top Rated', vm.enCokIzlenenFilmler),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FilmViewModel>();

    final sayfalar = [
      anaIcerik(vm),
      const FavorilerSayfa(),
      const ProfilSayfa(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("The Movie DB",style: TextStyle(fontSize: 17),),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
        ],
      ),
      body: sayfalar[seciliIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: seciliIndex,
        onDestinationSelected: (index) {
          setState(() {
            seciliIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoriler',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
