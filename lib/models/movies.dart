class Movies{
  final String originalTitle;
  final String releaseDate;
  final List<dynamic> posterPath;
  final int id;

  Movies({this.id, this.originalTitle, this.posterPath, this.releaseDate});

  factory Movies.fromJson(Map<String, dynamic> json) {
    List<dynamic> data = json['results'];
    // print(data);
    return Movies(
        id: data[0]['id'],
        originalTitle: data[0]['original_title'],
        posterPath: data,
        releaseDate: data[0]['release_date']);
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

// class MovieDetails {
//   final String posterPath;
//   final String originalTitle;
//   final String overview;
//   final double popularity;
//   final String releaseDate;
//
//   MovieDetails(
//       {this.posterPath,
//         this.originalTitle,
//         this.popularity,
//         this.overview,
//         this.releaseDate});
//
//   factory MovieDetails.fromJson(Map<String, dynamic> json) {
//     return MovieDetails(
//       posterPath: json['poster_path'],
//       originalTitle: json['original_title'],
//       overview: json['overview'],
//       popularity: json['popularity'],
//       releaseDate: json['release_date'],
//     );
//   }
// }