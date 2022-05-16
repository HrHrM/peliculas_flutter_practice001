import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:componentes/src/models/movie_model.dart';

class PeliculasProvider {
  String _apiKey = '751e1d5030830bb1a0cabd6127c08bcb';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    // print(decodedData['results']);
    final peliculas = Peliculas.fromJsonList(decodedData['results']);

    // print(peliculas.items[0].title);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }
}
