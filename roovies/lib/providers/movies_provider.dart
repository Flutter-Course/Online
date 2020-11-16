import 'package:flutter/material.dart';
import 'package:roovies/models/movie.dart';
import 'package:roovies/models/tmdb_handler.dart';

class MoviesProvider with ChangeNotifier {
  List<Movie> nowPlaying;

  Future<bool> fetchNowPlaying() async {
    try {
      nowPlaying = await TMDBHandler.instance.getNowPlaying();

      return true;
    } catch (error) {
      return false;
    }
  }
}
