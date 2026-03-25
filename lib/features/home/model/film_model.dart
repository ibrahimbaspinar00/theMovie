class FilmModel {
  final int id;
  final String baslik;
  final String posterYolu;
  final String cikisTarihi;
  final double puan;
  final String aciklama;

  FilmModel({
    required this.id,
    required this.baslik,
    required this.posterYolu,
    required this.cikisTarihi,
    required this.puan,
    required this.aciklama,
  });

  factory FilmModel.fromJson(Map<String, dynamic> json) {
    return FilmModel(
      id: json["id"] ?? 0,
      baslik: json["title"] ?? json["original_title"] ?? "İsimsiz Film",
      posterYolu: json["poster_path"] ?? "",
      cikisTarihi: json["release_date"] ?? "",
      puan: (json["vote_average"] ?? 0).toDouble(),
      aciklama: json["overview"] ?? "",
    );
  }
}