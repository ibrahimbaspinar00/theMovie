import 'package:flutter/material.dart';
import '../../model/film_model.dart';
import '../../../../services/favori_service.dart';

class FilmKart extends StatelessWidget {
  const FilmKart({super.key, required this.film});

  final FilmModel film;

  String tarihDuzenle(String tarih) {
    if (tarih.isEmpty) return 'Tarih yok';

    final parcalar = tarih.split('-');
    if (parcalar.length != 3) return tarih;

    return '${parcalar[2]}.${parcalar[1]}.${parcalar[0]}';
  }

  Color puanRengi(double puan) {
    if (puan >= 7) return Colors.green;
    if (puan >= 4) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, 4),
            color: Color(0x14000000),
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
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: film.posterYolu.isNotEmpty
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w500${film.posterYolu}',
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 180,
                            color: Colors.grey.shade300,
                            alignment: Alignment.center,
                            child: const Icon(Icons.broken_image, size: 40),
                          );
                        },
                      )
                    : Container(
                        height: 180,
                        color: Colors.grey.shade300,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.movie_creation_outlined,
                          size: 40,
                        ),
                      ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: Material(
                  color: Colors.black54,
                  shape: const CircleBorder(),
                  child: PopupMenuButton<String>(
                    tooltip: 'Daha Fazla',
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                      size: 18,
                    ),
                    onSelected: (value) async {
                      if (value == 'favori') {
                        final sonuc = await FavoriService().favoriyeEkle(film);

                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              sonuc
                                  ? 'Favorilere eklendi'
                                  : 'Favoriye eklenemedi',
                            ),
                          ),
                        );
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem<String>(
                        value: 'favori',
                        child: Text('Favoriye Ekle'),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 8,
                bottom: -14,
                child: Container(
                  width: 38,
                  height: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B1F44),
                    shape: BoxShape.circle,
                    border: Border.all(color: puanRengi(film.puan), width: 2),
                  ),
                  child: Text(
                    '${(film.puan * 10).toStringAsFixed(0)}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              film.baslik,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              tarihDuzenle(film.cikisTarihi),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}