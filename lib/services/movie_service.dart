import 'dart:convert';

import 'package:http/http.dart' as http;

import '../features/home/model/film_model.dart';

class MovieService {
  final String apiKey = 'a2d65402fb6a6838bf7eba3f35a2cbe7';

  Future<List<FilmModel>> filmGetir(String endpoint) async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/$endpoint?api_key=$apiKey&language=tr-TR&page=1',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(
        'Veri cekilemedi. Kod: ${response.statusCode}\nCevap: ${response.body}',
      );
    }

    final jsonVeri = jsonDecode(response.body);
    final results = jsonVeri['results'];

    if (results == null || results is! List) {
      throw Exception('API cevap verdi ama results alani bos.');
    }

    return results
        .map((filmJson) => FilmModel.fromJson(filmJson as Map<String, dynamic>))
        .toList();
  }
}
