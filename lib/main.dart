import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

/// Uygulamanın başlangıç noktası
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Uygulamanın genel tema ayarları
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xfff5f7fb),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),

      home: const AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  // Alt Menüde Seçili Olan Sekme
  int seciliIndex = 0;

  // Sayfa Yükleniyormu ?
  bool yukleniyor = true;

  // Hata Olursa Burda Tutulacak
  String hataMesaji = "";

  // Film Listeleri
  List<FilmModel> popularFilmler = [];
  List<FilmModel> yakindaGelecekFilmler = [];
  List<FilmModel> enCokIzlenenFilmler = [];

  // APİ anahtarı
  final String apiKey = "a2d65402fb6a6838bf7eba3f35a2cbe7";

  @override
  void initState() {
    super.initState();

    // Sayfa Açılır Açılmaz verileri çek
    tumVerileriGetir();
  }

  /// API'den tek bir kategori için film verisi çeker
  Future<List<FilmModel>> filmGetir(String endpoint) async {
    final url = Uri.parse(
      "https://api.themoviedb.org/3/movie/$endpoint?api_key=$apiKey&language=tr-TR&page=1",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonVeri = jsonDecode(response.body);

      if (jsonVeri["results"] == null) {
        throw Exception("API cevap verdi ama results alanı boş.");
      }

      final List results = jsonVeri["results"];

      return results.map((filmJson) {
        return FilmModel(
          id: filmJson["id"] ?? 0,
          baslik: filmJson["title"] ?? "Başlık yok",
          tarih: filmJson["release_date"] ?? "Tarih yok",
          puan: ((filmJson["vote_average"] ?? 0) * 10).round(),
          posterYolu: filmJson["poster_path"] ?? "",
        );
      }).toList();
    } else {
      throw Exception(
        "Veri çekilemedi. Kod: ${response.statusCode}\nCevap: ${response.body}",
      );
    }
  }

  // Tüm katagorileri sırayla çeker
  Future<void> tumVerileriGetir() async {
    setState(() {
      yukleniyor = true;
      hataMesaji = "";
    });

    try {
      final populer = await filmGetir("popular");
      final yakinda = await filmGetir("upcoming");
      final topRated = await filmGetir("top_rated");

      setState(() {
        popularFilmler = populer;
        yakindaGelecekFilmler = yakinda;
        enCokIzlenenFilmler = topRated;
        yukleniyor = false;
      });
    } catch (e) {
      setState(() {
        yukleniyor = false;
        hataMesaji = e.toString();
      });
    }
  }

  // Ekranda film kategorisi gösteren alan
  Widget filmBolumu(String baslik, List<FilmModel> filmler) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          baslik,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        filmler.isEmpty
            ? Container(
                height: 80,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text("Bu kategoride veri yok"),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: filmler.map((film) {
                    return FilmKart(film: film);
                  }).toList(),
                ),
              ),
      ],
    );
  }

  // Ana sayfa içeriği

  Widget anaSayfaIcerik() {
    return RefreshIndicator(
      onRefresh: tumVerileriGetir,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              filmBolumu("Popüler", popularFilmler),
              const SizedBox(height: 30),
              filmBolumu("Yakında Gelecek", yakindaGelecekFilmler),
              const SizedBox(height: 30),
              filmBolumu("En Çok İzlenenler", enCokIzlenenFilmler),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // HATA EKRANI

  Widget hataWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              "Veri Alınamadı",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              hataMesaji,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: tumVerileriGetir,
              child: const Text("Tekrar Dene"),
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
        ],
      ),

      body: yukleniyor
          ? const Center(child: CircularProgressIndicator())
          : hataMesaji.isNotEmpty
          ? hataWidget()
          : seciliIndex == 0
          ? anaSayfaIcerik()
          : seciliIndex == 1
          ? const Center(child: Text("Favoriler"))
          : const Center(child: Text("Profil")),

      // button navigationbar
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
    );
  }
}

// Film verisini tutan model sınıf
class FilmModel {
  final int id;
  final String baslik;
  final String tarih;
  final int puan;
  final String posterYolu;

  FilmModel({
    required this.id,
    required this.baslik,
    required this.tarih,
    required this.puan,
    required this.posterYolu,
  });
}

class FilmKart extends StatelessWidget {
  final FilmModel film;

  const FilmKart({super.key, required this.film});

  // Tarihi 2026-03-23 -> 23.03.2026 formatına çevirir
  String tarihDuzenle(String tarih) {
    if (tarih.isEmpty || tarih == "Tarih Yok") {
      return "tarih yok";
    }
    final parcalar = tarih.split("-");
    if (parcalar.length != 3) {
      return tarih;
    }
    return "${parcalar[2]}.${parcalar[1]}.${parcalar[0]}";
  }

  // Puan Rengi
  Color puanRengi(int puan) {
    if (puan >= 70) return Colors.green;
    if (puan >= 40) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 4),
            color: Colors.white,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),

                child: film.posterYolu.isNotEmpty
                    ? Image.network(
                        "https://image.tmdb.org/t/p/w500${film.posterYolu}",
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 300,
                            width: double.infinity,
                            color: Colors.grey.shade300,
                            child: const Center(
                              child: Icon(
                                Icons.broken_image,
                                size: 50,
                                color: Colors.black54,
                              ),
                            ),
                          );
                        },
                      )
                    : Container(
                        height: 300,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: Icon(
                            Icons.movie_creation_outlined,
                            size: 50,
                            color: Colors.black54,
                          ),
                        ),
                      ),
              ),
              SizedBox(height: 12),
              Positioned(
                top: 10,
                right: 10,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
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
              SizedBox(height: 12),
              Positioned(
                top: 10,
                right: 10,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
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
              SizedBox(height: 12),
              Positioned(
                left: 10,
                bottom: -18,
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xff0b1f44),
                    shape: BoxShape.circle,
                    border: Border.all(color: puanRengi(film.puan), width: 3),
                  ),
                  child: Center(
                    child: Text(
                      "${film.puan}%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              film.baslik,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 6),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              tarihDuzenle(film.tarih),
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),

          const SizedBox(height: 14),
        ],
      ),
    );
  }
}