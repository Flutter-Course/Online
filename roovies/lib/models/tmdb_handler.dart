import 'package:dio/dio.dart';
import 'package:roovies/helpers/api_keys.dart';
import 'package:roovies/models/movie.dart';

class TMDBHandler {
  static TMDBHandler _instance = TMDBHandler._private();
  TMDBHandler._private();

  static TMDBHandler get instance => _instance;
  String mainUrl = 'https://api.themoviedb.org/3';
  Dio _dio = Dio();

  Future<List<Movie>> getNowPlaying() async {
    String url = '$mainUrl/movie/now_playing';
    Map<String, dynamic> params = {
      'api_key': ApiKeys.tmdbKey,
    };
    Response response = await _dio.get(url, queryParameters: params);
    List<Movie> movies = (response.data['results'] as List).map((e) {
      return Movie.fromJson(e);
    }).toList();
    return movies;
  }
}
