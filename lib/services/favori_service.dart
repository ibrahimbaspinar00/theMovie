import 'dart:convert';
import 'package:http/http.dart' as http;
import '../features/home/model/film_model.dart';

class FavoriService {
  final String baseUrl = "https://api.themoviedb.org/3";

  static const String _varsayilanApiKey = "a2d65402fb6a6838bf7eba3f35a2cbe7";
  static const String _varsayilanSessionId =
      "558179b4e5f93276e49d7095463727e0b38b2819";

  FavoriService({String? apiKey, String? sessionId, int? accountId})
    : _apiKey =
          apiKey ??
          const String.fromEnvironment(
            "TMDB_API_KEY",
            defaultValue: _varsayilanApiKey,
          ),
      _sessionId =
          sessionId ??
          const String.fromEnvironment(
            "TMDB_SESSION_ID",
            defaultValue: _varsayilanSessionId,
          ),
      _sabitAccountId =
          accountId ??
          int.tryParse(const String.fromEnvironment("TMDB_ACCOUNT_ID"));

  final String _apiKey;
  final String _sessionId;
  final int? _sabitAccountId;
  int? _accountIdCache;

  Map<String, String> get _headers => {
    "Content-Type": "application/json;charset=utf-8",
    "accept": "application/json",
  };

  void _kimlikBilgisiKontrolEt() {
    if (_apiKey.isEmpty || _sessionId.isEmpty) {
      throw StateError(
        "TMDB kimlik bilgisi eksik. TMDB_API_KEY ve TMDB_SESSION_ID tanimlayin.",
      );
    }
  }

  Future<int> _accountIdGetir() async {
    if (_sabitAccountId != null) {
      return _sabitAccountId;
    }

    if (_accountIdCache != null) {
      return _accountIdCache!;
    }

    _kimlikBilgisiKontrolEt();
    final url = Uri.parse(
      "$baseUrl/account?api_key=$_apiKey&session_id=$_sessionId",
    );
    final response = await http.get(url, headers: _headers);

    if (response.statusCode != 200) {
      throw Exception(
        "Account bilgisi alinamadi. Kod: ${response.statusCode}. "
        "Session veya API key uyusmuyor olabilir. "
        "TMDB'de ayni API key ile yeni session olusturup TMDB_SESSION_ID guncelleyin. "
        "Cevap: ${response.body}",
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final accountId = data["id"];
    if (accountId is! int) {
      throw Exception("Account id API cevabinda bulunamadi.");
    }

    _accountIdCache = accountId;
    return accountId;
  }

  Future<bool> favoriyeEkle(FilmModel film) async {
    final accountId = await _accountIdGetir();
    final url = Uri.parse(
      "$baseUrl/account/$accountId/favorite?api_key=$_apiKey&session_id=$_sessionId",
    );

    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode({
        "media_type": "movie",
        "media_id": film.id,
        "favorite": true,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(
        "Favoriye ekleme basarisiz. Kod: ${response.statusCode}, Cevap: ${response.body}",
      );
    }

    return true;
  }

  Future<List<FilmModel>> favorileriGetir() async {
    final accountId = await _accountIdGetir();
    final url = Uri.parse(
      "$baseUrl/account/$accountId/favorite/movies?api_key=$_apiKey&session_id=$_sessionId&language=tr-TR",
    );

    final response = await http.get(url, headers: _headers);

    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
      final results = jsonMap["results"] as List<dynamic>? ?? [];
      return results
          .map((e) => FilmModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
        "Favoriler alinamadi. Kod: ${response.statusCode}, Cevap: ${response.body}",
      );
    }
  }

  Future<bool> favoridenSil(int filmId) async {
    final accountId = await _accountIdGetir();
    final url = Uri.parse(
      "$baseUrl/account/$accountId/favorite?api_key=$_apiKey&session_id=$_sessionId",
    );

    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode({
        "media_type": "movie",
        "media_id": filmId,
        "favorite": false,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(
        "Favoriden silme basarisiz. Kod: ${response.statusCode}, Cevap: ${response.body}",
      );
    }

    return true;
  }
}
