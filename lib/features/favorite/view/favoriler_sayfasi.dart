import 'package:flutter/material.dart';
import '../../home/model/film_model.dart';
import '../../../services/favori_service.dart';

class FavorilerSayfasi extends StatefulWidget {
  const FavorilerSayfasi({super.key});

  @override
  State<FavorilerSayfasi> createState() => _FavorilerSayfasiState();
}

class _FavorilerSayfasiState extends State<FavorilerSayfasi> {
  final FavoriService favoriService = FavoriService();

  List<FilmModel> favoriler = [];
  bool yukleniyor = true;
  String hataMesaji = "";

  @override
  void initState() {
    super.initState();
    favorileriYukle();
  }

  Future<void> favorileriYukle() async {
    setState(() {
      yukleniyor = true;
      hataMesaji = "";
    });

    try {
      final gelenFavoriler = await favoriService.favorileriGetir();

      setState(() {
        favoriler = gelenFavoriler;
      });
    } catch (e) {
      setState(() {
        hataMesaji = e.toString();
      });
    } finally {
      setState(() {
        yukleniyor = false;
      });
    }
  }

  Future<void> favoriSil(FilmModel film) async {
    final silindi = await favoriService.favoridenSil(film.id);

    if (silindi) {
      setState(() {
        favoriler.removeWhere((item) => item.id == film.id);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${film.baslik} favorilerden kaldırıldı")),
      );
    }
  }

  String tarihDuzenle(String tarih) {
    if (tarih.isEmpty) return "Tarih yok";

    final parcalar = tarih.split("-");
    if (parcalar.length != 3) return tarih;

    return "${parcalar[2]}.${parcalar[1]}.${parcalar[0]}";
  }

  Color puanRengi(double puan) {
    if (puan >= 7) return Colors.green;
    if (puan >= 5) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoriler", style: TextStyle(fontSize: 17)),
        //centerTitle: true
      ),
      body: RefreshIndicator(
        onRefresh: favorileriYukle,
        child: yukleniyor
            ? const Center(child: CircularProgressIndicator())
            : hataMesaji.isNotEmpty
            ? Center(child: Text(hataMesaji))
            : favoriler.isEmpty
            ? const Center(
                child: Text(
                  "Henüz favori film yok",
                  style: TextStyle(fontSize: 16),
                ),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: favoriler.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.58,
                ),
                itemBuilder: (context, index) {
                  final film = favoriler[index];

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: film.posterYolu.isEmpty
                                      ? Container(
                                          color: Colors.grey.shade300,
                                          child: const Center(
                                            child: Icon(Icons.image, size: 45),
                                          ),
                                        )
                                      : Image.network(
                                          "https://image.tmdb.org/t/p/w500${film.posterYolu}",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () => favoriSil(film),
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.55),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                film.baslik,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                tarihDuzenle(film.cikisTarihi),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: puanRengi(film.puan).withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "⭐ ${film.puan.toStringAsFixed(1)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: puanRengi(film.puan),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
