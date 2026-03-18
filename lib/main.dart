import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int seciliIndex = 0;

  // Popüler Listesi
  final List<FilmModel> popular = [
    FilmModel(baslik: "Film 1", tarih: "20 Şub 2026"),
    FilmModel(baslik: "Film 2", tarih: "25 Şub 2026"),
    FilmModel(baslik: "Film 3", tarih: "1 Mar 2026"),
  ];

  // Up Coming Listesi
  final List<FilmModel> upComing = [
    FilmModel(baslik: "Film 4", tarih: "20 Şub 2026"),
    FilmModel(baslik: "Film 5", tarih: "25 Şub 2026"),
    FilmModel(baslik: "Film 6", tarih: "1 Mar 2026"),
  ];

  final List<FilmModel> mostWatched = [
    FilmModel(baslik: "Film 7", tarih: "20 Şub 2026"),
    FilmModel(baslik: "Film 8", tarih: "25 Şub 2026"),
    FilmModel(baslik: "Film 9", tarih: "1 Mar 2026"),
  ];

  // anaSayfaIcerik
  Widget anaSayfaIcerik() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Popüler",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                // Popüler
                children: popular.map((film) => FilmKart(film: film)).toList(),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Up Coming",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                // Up Coming
                children: upComing.map((film) => FilmKart(film: film)).toList(),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Most Watched ",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: mostWatched
                    .map((film) => FilmKart(film: film))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("The Movie", style: TextStyle(fontSize: 18)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(6),
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.filter_list),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: seciliIndex,
        onTap: (index) {
          setState(() {
            seciliIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ana Sayfa"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favoriler",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
      body: seciliIndex == 0
          ? anaSayfaIcerik()
          : seciliIndex == 1
          ? const Center(child: Text("Favoriler"))
          : const Center(child: Text("Profil")),
    );
  }
}

class FilmModel {
  final String baslik;
  final String tarih;

  FilmModel({required this.baslik, required this.tarih});
}

class FilmKart extends StatelessWidget {
  final FilmModel film;

  const FilmKart({super.key, required this.film});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Icon More_Horiz
              Positioned(
                top: 10,
                right: 10,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.blueGrey.shade100,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: const SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Placeholder(),
                ),
              ),
              Positioned(
                left: 10,
                bottom: -18,
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xff0b1f44),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.yellow, width: 3),
                  ),
                  child: const Center(
                    child: Text(
                      "66%",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              film.baslik,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 4),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              film.tarih,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          SizedBox(height: 14),
        ],
      ),
    );
  }
}
