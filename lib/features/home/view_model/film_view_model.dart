import 'package:flutter/material.dart';
import '../model/film_model.dart';
import '../../../services/movie_service.dart';

class FilmViewModel extends ChangeNotifier {
  FilmViewModel({MovieService? movieService})
      : _movieService = movieService ?? MovieService();

  final MovieService _movieService;

  bool yukleniyor = false;
  String hataMesaji = '';

  List<FilmModel> popularFilmler = [];
  List<FilmModel> yakindaGelecekFilmler = [];
  List<FilmModel> enCokIzlenenFilmler = [];

  Future<void> tumVerileriGetir() async {
    yukleniyor = true;
    hataMesaji = '';
    notifyListeners();

    try {
      final populer = await _movieService.filmGetir('popular');
      final yakinda = await _movieService.filmGetir('upcoming');
      final topRated = await _movieService.filmGetir('top_rated');

      popularFilmler = populer;
      yakindaGelecekFilmler = yakinda;
      enCokIzlenenFilmler = topRated;
    } catch (e) {
      hataMesaji = e.toString();
    } finally {
      yukleniyor = false;
      notifyListeners();
    }
  }
}