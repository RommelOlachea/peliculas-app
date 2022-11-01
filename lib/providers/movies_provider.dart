import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  //definimos las variables para los parametros de url de la API
  String _apikey = 'efab40920c5216e31f1d02b7811896c0';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'en-Es';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    print('MoviesProvider Inicializado');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language, 'page': '1'});
    var response = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': _apikey, 'language': _language, 'page': '1'});
    var response = await http.get(url);

    final popularResponse = PopularResponse.fromJson(response.body);

    popularMovies = [...popularResponse.results];
    notifyListeners();
  }
}
