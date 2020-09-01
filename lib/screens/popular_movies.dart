import 'package:flutter/material.dart';
import 'package:movie_app/fetch_data/fetch_info.dart';
import 'package:movie_app/models/movies.dart';
import 'package:movie_app/shared/config.dart';
import 'package:movie_app/shared/dark_theme.dart';

const String baseUrl = 'https://api.themoviedb.org/3';

class PopularMovie extends StatefulWidget {
  final int movieId;

  PopularMovie({this.movieId});

  @override
  _PopularMovieState createState() => _PopularMovieState();
}

class _PopularMovieState extends State<PopularMovie> {
  Future<MovieDetails> futureMovieDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureMovieDetails = fetchMovieDetail(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieDetails>(
      future: futureMovieDetails,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              title: Text('Movie App'),
              actions: [
                FlatButton.icon(
                    onPressed: () {
                      setState(() {
                        currentTheme.switchTheme();
                      });
                    },
                    icon: !MyTheme.isDark
                        ? Icon(Icons.brightness_low)
                        : Icon(Icons.brightness_high),
                    label: Text(""))
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w300" +
                            snapshot.data.posterPath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Wrap(
                        spacing: 12.0,
                        children: [
                          Chip(
                            label: Text(
                              snapshot.data.originalTitle,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Chip(
                            label: Text(snapshot.data.releaseDate,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0)),
                          Text('${snapshot.data.popularity}',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        snapshot.data.overview,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.0, fontFamily: 'Roboto'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                '${snapshot.error}',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
        } else
          return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
