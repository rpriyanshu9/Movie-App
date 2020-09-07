import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/movies.dart';
import 'package:movie_app/shared/api_key.dart';

Future<PopularMovies> fetchPopularMovies() async {
  String _apiKey = apiKey;
  String baseURL = "https://api.themoviedb.org/3";
  final response = await http.get("""
$baseURL/movie/popular?api_key=$_apiKey&language=en-US&page=1""");
  if (response.statusCode == 200) {
    return PopularMovies.fromJson(json.decode(response.body));
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


Future<UpcomingMovies> fetchUpcomingMovies() async {
  String _apiKey = apiKey;
  String baseURL = "https://api.themoviedb.org/3";
  final response = await http.get("""
$baseURL/movie/upcoming?api_key=$_apiKey&language=en-US&page=1""");
  if (response.statusCode == 200) {
    print("connection successful");
    return UpcomingMovies.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load");
  }
}

Future<TopRatedMovies> fetchTopRatedMovies() async {
  String _apiKey = apiKey;
  String baseURL = "https://api.themoviedb.org/3";
  final response = await http.get("""
$baseURL/movie/top_rated?api_key=$_apiKey&language=en-US&page=1""");
  if (response.statusCode == 200) {
    return TopRatedMovies.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load");
  }
}

Future<MovieTrailer> fetchMovieTrailer(int movieId) async {
  String _apiKey = apiKey;
  String baseURL = "https://api.themoviedb.org/3";
  final response = await http.get("""
$baseURL/movie/$movieId/videos?api_key=$_apiKey&language=en-US""");
  if (response.statusCode == 200) {
    return MovieTrailer.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load");
  }
}