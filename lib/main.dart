import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/api_key.dart';
import 'package:movie_app/models/movies.dart';

void main() {
  runApp(MyApp());
}

Future<Movies> fetchInfo() async {
  String _apiKey = apiKey;
  String baseURL = "https://api.themoviedb.org/3";
  final response = await http.get("""
$baseURL/movie/popular?api_key=$_apiKey&language=en-US&page=1""");
  if (response.statusCode == 200) {
    return Movies.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load");
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

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
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  reverse: false,
                ),
                items: [0,1,2,3,4,5,6,7,8,9,10].map((i) {
                  // print(MediaQuery.of(context).size.width);
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 0.0),
                        decoration:
                        BoxDecoration(color: Colors.transparent),
                        child: Card(
                          margin: EdgeInsets.symmetric(horizontal: 0.0),
                          child: InkWell(
                            onTap: (){
                              var movieName= snapshot.data.posterPath[i]['original_title'];
                              print(movieName);
                            },
                            child: Image.network("https://image.tmdb.org/t/p/w300" +
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
