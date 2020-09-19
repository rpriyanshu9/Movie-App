import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/shared/api_key.dart';
import 'package:movie_app/shared/config.dart';
import 'package:movie_app/shared/dark_theme.dart';
import 'package:movie_app/shared/loading.dart';
import 'package:url_launcher/url_launcher.dart';

const String baseUrl = 'https://api.themoviedb.org/3';

class MovieDetails extends StatefulWidget {
  final int movieId;

  MovieDetails({this.movieId});

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Map movieDetails, movieTrailer;
  bool _isDetailsLoaded = false;
  bool _isTrailerLoaded = false;

  Future getMovieDetails() async {
    print(widget.movieId);
    String _apiKey = apiKey;
    String baseURL = "https://api.themoviedb.org/3";
    http.Response response = await http.get("""
$baseURL/movie/${widget.movieId}?api_key=$_apiKey&language=en-US""");
    if (response.statusCode == 200) {
      movieDetails = json.decode(response.body);
    }
    if (movieDetails != null) {
      setState(() {
        _isDetailsLoaded = true;
      });
    } else {
      setState(() {
        _isDetailsLoaded = false;
      });
    }
  }

  Future getTrailerDetails() async {
    String _apiKey = apiKey;
    String baseURL = "https://api.themoviedb.org/3";
    http.Response response = await http.get(
        "$baseURL/movie/${widget.movieId}/videos?api_key=$_apiKey&language=en-US");
    if (response.statusCode == 200) {
      movieTrailer = json.decode(response.body);
    } else {
      throw Exception("Failed to laod");
    }
    print(movieTrailer['results'].length);
    if (movieTrailer != null) {
      setState(() {
        _isTrailerLoaded = true;
      });
    } else {
      setState(() {
        _isTrailerLoaded = false;
      });
    }
  }

  String _launchUrl = "https://www.youtube.com/watch?v=";

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{'header_key': 'header_value'});
    } else {
      throw 'could not throw $url';
    }
  }

  @override
  void initState() {
    super.initState();
    getMovieDetails();
    getTrailerDetails();
  }

  @override
  Widget build(BuildContext context) {
    bool loaded = _isDetailsLoaded && _isTrailerLoaded;
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
      body: (!loaded)
          ? Loading()
          : ListView(
              children: [
                (movieDetails['backdrop_path'] == null)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(
                          child: Text(
                            "Poster not available",
                            style:
                                TextStyle(fontSize: 18.0, fontFamily: 'Roboto'),
                          ),
                        ),
                      )
                    : ClipRRect(
                        child: Hero(
                          tag: movieDetails['backdrop_path'],
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w1280" +
                                movieDetails['backdrop_path'],
                            fit: BoxFit.cover,
                            height: 360,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                SizedBox(
                  height: 8.0,
                ),
                ListTile(
                  title: Text(
                    movieDetails['original_title'],
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    spacing: 10.0,
                    children: [
                      for (var item in movieDetails['genres'])
                        _chipBuilder(item['name'])
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: (movieDetails['overview'] == null ||
                          movieDetails['overview'] == "")
                      ? Text("Overview not available",
                          style:
                              TextStyle(fontSize: 18.0, fontFamily: 'Roboto'))
                      : Text(
                          movieDetails['overview'],
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 18.0, fontFamily: 'Roboto'),
                        ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 0.0, 20.0, 10.0),
                            child: (movieTrailer['results'].length == 0)
                                ? Container()
                                : RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    color: Colors.blue,
                                    onPressed: () {
                                      print(movieTrailer['results']);
                                      _launchInBrowser(_launchUrl +
                                          movieTrailer['results'][0]['key']);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.live_tv),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.0)),
                                        Text(
                                          "Watch Trailer",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }

  Widget _chipBuilder(String genreName) {
    return Chip(
      elevation: 15.0,
      label: Text(
        genreName,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
