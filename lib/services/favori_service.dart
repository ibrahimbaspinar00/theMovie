import 'dart:convert';
import 'package:http/http.dart' as http;
import '../features/home/model/film_model.dart';

class FavoriService {
  final String baseUrl = "https://api.themoviedb.org/3";
  final String accountId = "22888997";

  final String bearerToken =
      "BURAYA_TOKEN";

  Map<String, String> get headers => {
        "Content-Type": "application/json;charset=utf-8",
        "accept": "application/json",
        "Authorization": "Bearer $bearerToken",
      };

  Future<bool> favoriyeEkle(FilmModel film) async {
    final url = Uri.parse("$baseUrl/account/$accountId/favorite");

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        "media_type": "movie",
        "media_id": film.id,
        "favorite": true,
      }),
    );

    print("EKLE URL: $url");
    print("EKLE STATUS: ${response.statusCode}");
    print("EKLE BODY: ${response.body}");

    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<List<FilmModel>> favorileriGetir() async {
    final url = Uri.parse("$baseUrl/account/$accountId/favorite/movies");

    final response = await http.get(url, headers: headers);

    print("GETIR URL: $url");
    print("GETIR STATUS: ${response.statusCode}");
    print("GETIR BODY: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      final List results = jsonMap["results"] ?? [];

      return results.map((e) => FilmModel.fromJson(e)).toList();
    } else {
      throw Exception("Favoriler alınamadı: ${response.body}");
    }
  }

  Future<bool> favoridenSil(int filmId) async {
    final url = Uri.parse("$baseUrl/account/$accountId/favorite");

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        "media_type": "movie",
        "media_id": filmId,
        "favorite": false,
      }),
    );

    print("SIL URL: $url");
    print("SIL STATUS: ${response.statusCode}");
    print("SIL BODY: ${response.body}");

    return response.statusCode == 200 || response.statusCode == 201;
  }
}