import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/helpers/debouncer.dart';
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  //definimos las variables para los parametros de url de la API
  String _apikey = 'efab40920c5216e31f1d02b7811896c0';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'en-Es';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> movieCast = {};
  //el id es el movie id que apuntara al listado de actores

  int _popularPage = 0;

  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggerstionsStreamController =
      new StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      this._suggerstionsStreamController.stream;

  MoviesProvider() {
    print('MoviesProvider Inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJasonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apikey, 'language': _language, 'page': '$page'});

    //await the http get response, then decode the json-formatted response
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await this._getJasonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await this._getJasonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];
    print(popularMovies[0]);
    notifyListeners();
  }

  Future<List<Cast>> getMoviesCast(int movieId) async {
    //TODO: Revisar el mapa, para saber si ya tenemos el contenido
    if (movieCast.containsKey(movieId)) return movieCast[movieId]!;
    print('pidiendo info al servidor - cast');
    final jsonData = await this._getJasonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    movieCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apikey, 'language': _language, 'query': query});

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {}
}
