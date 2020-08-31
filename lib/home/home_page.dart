import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/fetch_data/fetch_info.dart';
import 'package:movie_app/models/movies.dart';
import 'package:movie_app/screens/popular_movies.dart';
import 'package:movie_app/shared/config.dart';
import 'package:movie_app/shared/dark_theme.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Movies> futureMovies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureMovies = fetchInfo();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Movies>(
      future: futureMovies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // print(snapshot.data.posterPath[0]['poster_path']);
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
            body: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  reverse: false,
                ),
                items: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((i) {
                  // print(MediaQuery.of(context).size.width);
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 0.0),
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: Card(
                          margin: EdgeInsets.symmetric(horizontal: 0.0),
                          child: InkWell(
                            onTap: () {
                              var movieID = snapshot.data.posterPath[i]['id'];
                              print(movieID);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PopularMovie(movieId: movieID)));
                            },
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w300" +
                                  snapshot.data.posterPath[i]['backdrop_path'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text("${snapshot.error}")));
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
