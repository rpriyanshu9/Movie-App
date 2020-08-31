class Movies{
  final String originalTitle;
  final String releaseDate;
  final List<dynamic> posterPath;
  final int id;

  Movies({this.id,this.originalTitle,this.posterPath,this.releaseDate});

  factory Movies.fromJson(Map<String,dynamic> json){
    List<dynamic> data=json['results'];
    // print(data);
    return Movies(
      id: data[0]['id'],
      originalTitle: data[0]['original_title'],
      posterPath: data,
      releaseDate: data[0]['release_date']
    );
  }
}