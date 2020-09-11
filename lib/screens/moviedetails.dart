import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movie_app/fetch_data/fetch_info.dart';
import 'package:movie_app/models/movies.dart';
import 'package:movie_app/shared/api_key.dart';
import 'package:movie_app/shared/config.dart';
import 'package:movie_app/shared/dark_theme.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

const String baseUrl = 'https://api.themoviedb.org/3';

class PopularMovie extends StatefulWidget {
  final int movieId;

  PopularMovie({this.movieId});

  @override
  _PopularMovieState createState() => _PopularMovieState();
}

class _PopularMovieState extends State<PopularMovie> {
  Map movieDetails, movieTrailer;
  bool _isDetailsLoaded = false;
  bool _isTrailerLoaded = false;

  Future getMovieDetails() async {
    String _apiKey = apiKey;
    String baseURL = "https://api.themoviedb.org/3";
    http.Response response = await http.get("""
$baseURL/movie/${widget.movieId}?api_key=$_apiKey&language=en-US""");
    if (response.statusCode == 200) {
      movieDetails = json.decode(response.body);
      if (movieDetails != null) {
        setState(() {
          _isDetailsLoaded = true;
        });
      }
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

  Future<void> _launched;
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
    // TODO: implement initState
    super.initState();
    getMovieDetails();
    getTrailerDetails();
  }

  @override
  Widget build(BuildContext context) {
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
      body: (!_isDetailsLoaded && !_isTrailerLoaded)
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: ListView(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w300" +
                                  movieDetails['poster_path'],
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
                                    movieDetails['original_title'],
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Chip(
                                  label: Text(movieDetails['release_date'],
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.0)),
                                Text('${movieDetails['popularity']}',
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
                              movieDetails['overview'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18.0, fontFamily: 'Roboto'),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 0.0, 20.0, 10.0),
                              child: RaisedButton(
                                color: Colors.blue,
                                onPressed: () {
                                  _launchInBrowser(
                                      _launchUrl + movieTrailer['key']);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.live_tv),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.0)),
                                    Text("Watch Trailer"),
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
            ),
    );
  }
}
