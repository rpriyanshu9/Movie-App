import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/movies.dart';
import 'package:movie_app/shared/api_key.dart';

Future<Movies> fetchPopularMovies() async {
  String _apiKey = apiKey;
  String baseURL = "https://api.themoviedb.org/3";
  final response = await http.get("""
$baseURL/movie/popular?api_key=$_apiKey&language=en-US&page=1""");
  if (response.statusCode == 200) {
    return Movies.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load");
  }
}

Future<MovieDetails> fetchMovieDetail(int movieId) async {
  String _apiKey = apiKey;
  String baseURL = "https://api.themoviedb.org/3";
  final response = await http.get("""
$baseURL/movie/$movieId?api_key=$_apiKey&language=en-US""");
  if (response.statusCode == 200) {
    return MovieDetails.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load");
  }
}
