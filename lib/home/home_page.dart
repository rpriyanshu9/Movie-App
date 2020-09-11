import 'package:flutter/material.dart';
import 'package:movie_app/shared/config.dart';
import 'package:movie_app/shared/dark_theme.dart';
import 'package:movie_app/widgets/popular_movie_tab.dart';
import 'package:movie_app/widgets/top_rated_movie_tab.dart';
import 'package:movie_app/widgets/upcoming_movie_tab.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Movie App'),
        bottom: TabBar(
          tabs: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Popular',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Upcoming',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Top Rated',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
        ),
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
      body: Container(
          child: TabBarView(
        children: <Widget>[
          PopularMovieTab(),
          UpcomingMovieTab(),
          TopRatedMovieTab(),
          // PopularMovieTab(),
        ],
        controller: _tabController,
      )),
    );
  }
}