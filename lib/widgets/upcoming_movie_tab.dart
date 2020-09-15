import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/screens/moviedetails.dart';
import 'package:movie_app/shared/api_key.dart';
import 'package:movie_app/shared/dark_theme.dart';
import 'package:movie_app/shared/text_style.dart';
import 'package:movie_app/shared/ui_helper.dart';

class UpcomingMovieTab extends StatefulWidget {
  @override
  _UpcomingMovieTabState createState() => _UpcomingMovieTabState();
}

class _UpcomingMovieTabState extends State<UpcomingMovieTab> {
  Map futureUpcomingMovies;
  bool _isCarouselLoaded = false;

  Future getUpcomingMovies() async {
    String _apiKey = apiKey;
    String baseURL = "https://api.themoviedb.org/3";
    http.Response response = await http
        .get("$baseURL/movie/upcoming?api_key=$_apiKey&language=en-US&page=1");
    if (response.statusCode == 200) {
      futureUpcomingMovies = json.decode(response.body);
      if (futureUpcomingMovies != null) {
        setState(() {
          _isCarouselLoaded = true;
        });
      }
    } else {
      setState(() {
        _isCarouselLoaded = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (!_isCarouselLoaded)
          ? Container(
              child: Center(
              child: CircularProgressIndicator(),
            ))
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Upcoming Movies",
                        style: headerStyle.copyWith(
                            color:
                                MyTheme.isDark ? Colors.white : Colors.black)),
                    UIHelper.verticalSpace(16),
                    Container(
                      height: 250,
                      child: ListView.builder(
                        itemCount: futureUpcomingMovies['results'].length,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final event = futureUpcomingMovies['results'][index];
                          return UpComingMoviesCard(event);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class UpComingMoviesCard extends StatelessWidget {
  final dynamic event;

  UpComingMoviesCard(this.event);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: InkWell(
            onTap: () {
              var movieID = event['id'];
              print(movieID);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MovieDetails(movieId: movieID)));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                child: Hero(
                  tag: event['backdrop_path'],
                  child: Image.network(
                    "https://image.tmdb.org/t/p/w1280" + event['backdrop_path'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )),
          UIHelper.verticalSpace(1),
          buildEventInfo()
          // buildEventInfo(context),
        ],
      ),
    );
  }

  Widget buildEventInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        event['original_title'],
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: MyTheme.isDark ? Colors.white : Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
