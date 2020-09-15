import 'package:flutter/material.dart';
import 'package:movie_app/home/search.dart';
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
          IconButton(
              icon: !MyTheme.isDark
                  ? Icon(Icons.brightness_low)
                  : Icon(Icons.brightness_high),
              onPressed: () {
                setState(() {
                  currentTheme.switchTheme();
                });
              }),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchBar();
              }));
            },
          )
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

// class MovieSearch extends SearchDelegate {
//   Map searchResults;
//   bool searchLoaded = false;
//
//   Future getSearchResults() async {
//     if (query == "") {
//       searchResults = null;
//     } else {
//       http.Response response = await http.get(
//           "https://api.themoviedb.org/3/search/movie?api_key=${apiKey}&language=en-US&query=$query&page=1&include_adult=false");
//       // if (response.statusCode==200){
//       searchResults = json.decode(response.body);
//     }
//     print(searchResults);
//     if (searchResults != null) {
//       searchLoaded = true;
//     } else {
//       searchLoaded = false;
//     }
//   }
//
//   @override
//   ThemeData appBarTheme(BuildContext context) {
//     return Theme.of(context);
//   }
//
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//           icon: Icon(Icons.close),
//           onPressed: () {
//             query = "";
//           })
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     return Container(
//         child: ListView.builder(
//       itemCount: searchResults["results"].length ?? 0,
//       physics: BouncingScrollPhysics(),
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(searchResults["results"][index]['original_title']),
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => PopularMovie(
//                       movieId: searchResults["results"][index]['id']),
//                 ));
//           },
//         );
//       },
//     ));
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     getSearchResults();
//     return Container(
//       child: (!searchLoaded)
//           ? Container()
//           : ListView.builder(
//               itemCount: (searchResults["results"] == null)
//                   ? 0
//                   : searchResults["results"].length,
//               physics: BouncingScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title:
//                       Text(searchResults["results"][index]['original_title']),
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => PopularMovie(
//                               movieId: searchResults["results"][index]['id']),
//                         ));
//                   },
//                 );
//               },
//             ),
//     );
//   }
// }
