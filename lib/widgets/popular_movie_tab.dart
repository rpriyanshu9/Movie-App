import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/screens/moviedetails.dart';
import 'package:movie_app/shared/api_key.dart';
import 'package:movie_app/shared/dark_theme.dart';
import 'package:movie_app/shared/text_style.dart';
import 'package:movie_app/shared/ui_helper.dart';

class PopularMovieTab extends StatefulWidget {
  @override
  _PopularMovieTabState createState() => _PopularMovieTabState();
}

class _PopularMovieTabState extends State<PopularMovieTab> {
  Map futurePopularMovies,
      futureActionGenre,
      futureComedyGenre,
      futureHorrorGenre,
      futureDramaGenre;
  bool _isCarouselLoaded = false, _isGenreLoaded = false;
  bool actionSelect = false,
      comedySelect = false,
      dramaSelect = false,
      horrorSelect = true;

  Future getPopularMovies() async {
    String _apiKey = apiKey;
    String baseURL = "https://api.themoviedb.org/3";
    http.Response response = await http
        .get("$baseURL/movie/popular?api_key=$_apiKey&language=en-US&page=1");
    if (response.statusCode == 200) {
      futurePopularMovies = json.decode(response.body);
      if (futurePopularMovies != null) {
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

  Future getGenreMovies(int genre) async {
    String _apiKey = apiKey;
    http.Response response = await http.get(
        "https://api.themoviedb.org/3/discover/movie?api_key=$_apiKey&language=en-US&region=US&sort_by=popularity.asc&include_adult=false&include_video=false&page=2&with_genres=$genre");
    if (response.statusCode == 200) {
      if (genre == 28) {
        futureActionGenre = json.decode(response.body);
        if (futureActionGenre != null) {
          setState(() {
            _isGenreLoaded = true;
          });
        }
      }
      else if (genre == 35) {
        futureComedyGenre = json.decode(response.body);
        if (futureComedyGenre != null) {
          setState(() {
            _isGenreLoaded = true;
          });
        }
      }
      else if (genre == 18) {
        futureDramaGenre = json.decode(response.body);
        if (futureDramaGenre != null) {
          setState(() {
            _isGenreLoaded = true;
          });
        }
      }
      else{
        futureHorrorGenre = json.decode(response.body);
        if (futureHorrorGenre != null) {
          setState(() {
            _isGenreLoaded = true;
          });
        }
      }
    } else {
      setState(() {
        _isGenreLoaded = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPopularMovies();
    getGenreMovies(28);
    getGenreMovies(35);
    getGenreMovies(18);
    getGenreMovies(36);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: (!_isCarouselLoaded && !_isGenreLoaded)
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Popular Movies",
                                style: headerStyle.copyWith(
                                    color: MyTheme.isDark
                                        ? Colors.white
                                        : Colors.black)),
                            UIHelper.verticalSpace(16),
                            Container(
                              height: 250,
                              child: ListView.builder(
                                itemCount:
                                    futurePopularMovies['results'].length,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final event =
                                      futurePopularMovies['results'][index];
                                  return PopularMoviesCard(event);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Wrap(
                        spacing: 10.0,
                        children: [
                          ChoiceChip(
                            label: Text("Action"),
                            labelStyle: TextStyle(
                              color: MyTheme.isDark ? Colors.white : Colors.black,
                            ),
                            avatar: CircleAvatar(
                              backgroundColor: Colors.deepPurpleAccent,
                              child: Text('A',style: TextStyle(color: MyTheme.isDark ? Colors.white : Colors.black,),),
                            ),
                            elevation: 15.0,
                            selected: actionSelect,
                            selectedColor: Colors.deepPurple,
                            onSelected: (bool selected) {
                              setState(() {
                                actionSelect = !actionSelect;
                                dramaSelect = false;
                                comedySelect = false;
                                horrorSelect = false;
                              });
                            },
                          ),
                          ChoiceChip(
                            label: Text("Comedy"),
                            labelStyle: TextStyle(
                              color: MyTheme.isDark ? Colors.white : Colors.black,
                            ),
                            avatar: CircleAvatar(
                              backgroundColor: Colors.deepPurpleAccent,
                              child: Text('C',style: TextStyle(color: MyTheme.isDark ? Colors.white : Colors.black,),),
                            ),
                            elevation: 15.0,
                            selected: comedySelect,
                            selectedColor: Colors.deepPurple,
                            onSelected: (bool selected) {
                              setState(() {
                                actionSelect = false;
                                dramaSelect = false;
                                comedySelect = !comedySelect;
                                horrorSelect = false;
                              });
                            },
                          ),
                          ChoiceChip(
                            label: Text("Drama"),
                            labelStyle: TextStyle(
                              color: MyTheme.isDark ? Colors.white : Colors.black,
                            ),
                            avatar: CircleAvatar(
                              backgroundColor: Colors.deepPurpleAccent,
                              child: Text('D',style: TextStyle(color: MyTheme.isDark ? Colors.white : Colors.black,),),
                            ),
                            elevation: 15.0,
                            selected: dramaSelect,
                            selectedColor: Colors.deepPurple,
                            onSelected: (bool selected) {
                              setState(() {
                                actionSelect = false;
                                dramaSelect = !dramaSelect;
                                comedySelect = false;
                                horrorSelect = false;
                              });
                            },
                          ),
                          ChoiceChip(
                            label: Text("Horror"),
                            labelStyle: TextStyle(
                              color: MyTheme.isDark ? Colors.white : Colors.black,
                            ),
                            avatar: CircleAvatar(
                              backgroundColor: Colors.deepPurpleAccent,
                              child: Text('H',style: TextStyle(color: MyTheme.isDark ? Colors.white : Colors.black,),),
                            ),
                            elevation: 15.0,
                            selected: horrorSelect,
                            selectedColor: Colors.deepPurple,
                            onSelected: (bool selected) {
                              setState(() {
                                actionSelect = false;
                                dramaSelect = false;
                                comedySelect = false;
                                horrorSelect = !horrorSelect;
                              });
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: actionSelect ? 
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: futureActionGenre['results'].length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  "${futureActionGenre['results'][index]['original_title']}"),
                            );
                          },
                        ): dramaSelect ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: futureDramaGenre['results'].length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  "${futureDramaGenre['results'][index]['original_title']}"),
                            );
                          },
                        ): comedySelect?ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: futureComedyGenre['results'].length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  "${futureComedyGenre['results'][index]['original_title']}"),
                            );
                          },
                        ): ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: futureHorrorGenre['results'].length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  "${futureHorrorGenre['results'][index]['original_title']}"),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )),
      ),
    );
  }
}

class PopularMoviesCard extends StatelessWidget {
  final dynamic event;

  PopularMoviesCard(this.event);

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PopularMovie(movieId: movieID)));
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
          buildEventInfo(),
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
