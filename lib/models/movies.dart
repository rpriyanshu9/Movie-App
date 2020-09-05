class PopularMovies {
  final List<dynamic> result;

  PopularMovies({this.result});

  factory PopularMovies.fromJson(Map<String, dynamic> json) {
    List<dynamic> data = json['results'];
    // print(data);
    return PopularMovies(result: data);
  }
}

class MovieDetails {
  final String posterPath;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String releaseDate;

  MovieDetails(
      {this.posterPath,
      this.originalTitle,
      this.popularity,
      this.overview,
      this.releaseDate});

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      posterPath: json['poster_path'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      releaseDate: json['release_date'],
    );
  }
}

class UpcomingMovies {
  final List<dynamic> result;

  UpcomingMovies({this.result});

  factory UpcomingMovies.fromJson(Map<String, dynamic> json) {
    List<dynamic> data = json['results'];
    // print(data);
    return UpcomingMovies(
        result: data);
  }
}

class TopRatedMovies {
  final List<dynamic> result;

  TopRatedMovies({this.result});

  factory TopRatedMovies.fromJson(Map<String, dynamic> json) {
    List<dynamic> data = json['results'];
    // print(data);
    return TopRatedMovies(
        result: data);
  }
}

