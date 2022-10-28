import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  MoviesProvider() {
    print('MoviesProvider Inicializado');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    //definimos las variables para los parametros de url de la API
    String _apikey = 'efab40920c5216e31f1d02b7811896c0';
    String _baseUrl = 'api.themoviedb.org';
    String _language = 'en-Es';

    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language, 'page': '1'});
    var response = await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(response.body);

    print(decodeData['results']);
  }
}
