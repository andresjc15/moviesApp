import 'dart:convert';

import 'package:http/http.dart' as http; 

import 'package:movies/src/models/pelicula_model.dart';

class PeliculasProvider {

  String _apikey    = '9c1d2a30817ff3bf5c6d34ac2a6f89fd';
  String _url       = 'api.themoviedb.org';
  String _language  = 'es-ES';

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;

  }

  Future<List<Pelicula>> getEnCines() async {
    
    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key'   : _apikey,
      'language'  : _language
    });

    return await _procesarRespuesta(url);

  }

  Future<List<Pelicula>> getPopulares() async {
    
    final url = Uri.https(_url, '/3/movie/popular', {
      'api_key'   : _apikey,
      'language'  : _language
    });

    return await _procesarRespuesta(url);

  }


}