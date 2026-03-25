import 'dart:convert';
import 'package:http/http.dart' as http;

class TmdbAuthService {
  final String baseUrl = "https://api.themoviedb.org/3";

  final String bearerToken = "BURAYA_BEARER_TOKEN";

  Map<String, String> get headers => {
        "accept": "application/json",
        "content-type": "application/json;charset=utf-8",
        "Authorization": "Bearer $bearerToken",
      };

  Future<String> requestTokenOlustur() async {
    final url = Uri.parse("$baseUrl/authentication/token/new");

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["request_token"];
    } else {
      throw Exception("Request token alınamadı: ${response.body}");
    }
  }

  Future<String> sessionOlustur(String requestToken) async {
    final url = Uri.parse("$baseUrl/authentication/session/new");

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        "request_token": requestToken,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["session_id"];
    } else {
      throw Exception("Session oluşturulamadı: ${response.body}");
    }
  }

  Future<int> accountIdGetir(String sessionId) async {
    final url = Uri.parse("$baseUrl/account?session_id=$sessionId");

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["id"];
    } else {
      throw Exception("Account alınamadı: ${response.body}");
    }
  }
}