import 'package:flutter/material.dart';

class PopularMovie extends StatefulWidget {
  final int movieId;

  PopularMovie({this.movieId});

  @override
  _PopularMovieState createState() => _PopularMovieState();
}

class _PopularMovieState extends State<PopularMovie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'),
      ),
      body: Center(
        child: Text('${widget.movieId}', style: TextStyle(fontSize: 18.0),),
      ),
    );
  }
}
