import 'package:flutter/material.dart';
import 'package:movie_app/fetch_data/fetch_info.dart';
import 'package:movie_app/models/movies.dart';
import 'package:movie_app/screens/moviedetails.dart';
import 'package:movie_app/shared/dark_theme.dart';
import 'package:movie_app/shared/text_style.dart';
import 'package:movie_app/shared/ui_helper.dart';

class TopRatedMovieTab extends StatefulWidget {
  @override
  _TopRatedMovieTabState createState() => _TopRatedMovieTabState();
}

class _TopRatedMovieTabState extends State<TopRatedMovieTab> {
  Future<TopRatedMovies> futureTopRatedMovies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureTopRatedMovies = fetchTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        child: FutureBuilder<TopRatedMovies>(
            future: futureTopRatedMovies,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              else {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Top Rated Movies",
                          style: headerStyle.copyWith(
                              color: MyTheme.isDark
                                  ? Colors.white
                                  : Colors.black)),
                      UIHelper.verticalSpace(16),
                      Container(
                        height: 250,
                        child: ListView.builder(
                          itemCount: snapshot.data.result.length,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final event = snapshot.data.result[index];
                            return TopRatedMoviesCard(event);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
      ),
      ),
    );
  }
}

class TopRatedMoviesCard extends StatelessWidget {
  final dynamic event;

  TopRatedMoviesCard(this.event);

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
                    "https://image.tmdb.org/t/p/w300" + event['backdrop_path'],
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