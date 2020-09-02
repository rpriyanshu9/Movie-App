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
  Future<Movies> futurePopularMovies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futurePopularMovies = fetchPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Movies>(
      future: futurePopularMovies,
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Popular Movies',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23.0,
                                color: MyTheme.isDark
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                        CarouselSlider(
                          options: CarouselOptions(
                            reverse: false,
                          ),
                          items: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((i) {
                            // print(MediaQuery.of(context).size.width);
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 0.0),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 0.0),
                                  child: InkWell(
                                    onTap: () {
                                      var movieID =
                                          snapshot.data.posterPath[i]['id'];
                                      print(movieID);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PopularMovie(
                                                      movieId: movieID)));
                                    },
                                    child: Card(
                                      elevation: 5.0,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AspectRatio(
                                            child: Image.network(
                                              "https://image.tmdb.org/t/p/w300" +
                                                  snapshot.data.posterPath[i]
                                                      ['backdrop_path'],
                                              fit: BoxFit.cover,
                                            ),
                                            aspectRatio: 2 / 1,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              snapshot.data.posterPath[i]
                                                  ['original_title'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: MyTheme.isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0.0, left: 8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                Text(
                                                  '${snapshot.data.posterPath[i]['popularity']}',
                                                  style: TextStyle(
                                                      color: MyTheme.isDark
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Upcoming Movies',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23.0,
                                color: MyTheme.isDark
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                        CarouselSlider(
                          options: CarouselOptions(
                            reverse: false,
                          ),
                          items: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((i) {
                            // print(MediaQuery.of(context).size.width);
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 0.0),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 0.0),
                                  child: InkWell(
                                    onTap: () {
                                      var movieID =
                                          snapshot.data.posterPath[i]['id'];
                                      print(movieID);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PopularMovie(
                                                      movieId: movieID)));
                                    },
                                    child: Card(
                                      elevation: 5.0,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AspectRatio(
                                            child: Image.network(
                                              "https://image.tmdb.org/t/p/w300" +
                                                  snapshot.data.posterPath[i]
                                                      ['backdrop_path'],
                                              fit: BoxFit.cover,
                                            ),
                                            aspectRatio: 2 / 1,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              snapshot.data.posterPath[i]
                                                  ['original_title'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: MyTheme.isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0.0, left: 8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                Text(
                                                  '${snapshot.data.posterPath[i]['popularity']}',
                                                  style: TextStyle(
                                                      color: MyTheme.isDark
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Top Rated',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23.0,
                                color: MyTheme.isDark
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                        CarouselSlider(
                          options: CarouselOptions(
                            reverse: false,
                          ),
                          items: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((i) {
                            // print(MediaQuery.of(context).size.width);
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 0.0),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 0.0),
                                  child: InkWell(
                                    onTap: () {
                                      var movieID =
                                          snapshot.data.posterPath[i]['id'];
                                      print(movieID);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PopularMovie(
                                                      movieId: movieID)));
                                    },
                                    child: Card(
                                      elevation: 5.0,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AspectRatio(
                                            child: Image.network(
                                              "https://image.tmdb.org/t/p/w300" +
                                                  snapshot.data.posterPath[i]
                                                      ['backdrop_path'],
                                              fit: BoxFit.cover,
                                            ),
                                            aspectRatio: 2 / 1,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              snapshot.data.posterPath[i]
                                                  ['original_title'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: MyTheme.isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0.0, left: 8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                Text(
                                                  '${snapshot.data.posterPath[i]['popularity']}',
                                                  style: TextStyle(
                                                      color: MyTheme.isDark
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
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
