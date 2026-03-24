class FilmModel {
  final int id;
  final String baslik;
  final String posterYolu;
  final String tarih;
  final double puan;

  FilmModel({
    required this.id,
    required this.baslik,
    required this.posterYolu,
    required this.tarih,
    required this.puan,
  });

  factory FilmModel.fromJson(Map<String, dynamic> json) {
    return FilmModel(
      id: json["id"] ?? 0,
      baslik: json["title"] ?? "",
      posterYolu: json["poster_path"] ?? "",
      tarih: json["release_date"] ?? "",
      puan: (json["vote_average"] ?? 0).toDouble() * 10,
    );
  }
}
