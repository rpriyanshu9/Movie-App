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
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 8.0),
            //   child: Text('Popular', style: TextStyle(fontSize: 15.0),),
            // ),
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

      // SizedBox(
      //   height: 10.0,
      // ),
      // FutureBuilder<TopRatedMovies>(
      //   future: futureTopRatedMovies,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return Container(
      //         width: MediaQuery.of(context).size.width,
      //         padding: const EdgeInsets.only(left: 16),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: <Widget>[
      //             Text("Top Rated",
      //                 style: headerStyle.copyWith(
      //                     color: MyTheme.isDark
      //                         ? Colors.white
      //                         : Colors.black)),
      //             UIHelper.verticalSpace(16),
      //             Container(
      //               height: 250,
      //               child: ListView.builder(
      //                 itemCount: snapshot.data.result.length,
      //                 physics: BouncingScrollPhysics(),
      //                 scrollDirection: Axis.horizontal,
      //                 itemBuilder: (context, index) {
      //                   final event = snapshot.data.result[index];
      //                   return TopRatedMoviesCard(event);
      //                 },
      //               ),
      //             ),
      //           ],
      //         ),
      //       );
      //     } else if (snapshot.hasError) {
      //       return Container(
      //           child: Center(child: Text("${snapshot.error}")));
      //     } else {
      //       return Text("Loading..");
      //     }
      //   },
      // ),

      // ),
    );
  }
}

// class PopularMoviesCard extends StatelessWidget {
//   final dynamic event;

//   PopularMoviesCard(this.event);

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     return Container(
//       width: width,
//       margin: const EdgeInsets.only(right: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Expanded(
//               child: InkWell(
//             onTap: () {
//               var movieID = event['id'];
//               print(movieID);
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => PopularMovie(movieId: movieID)));
//             },
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Container(
//                 color: Colors.transparent,
//                 width: double.infinity,
//                 child: Hero(
//                   tag: event['backdrop_path'],
//                   child: Image.network(
//                     "https://image.tmdb.org/t/p/w300" + event['backdrop_path'],
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//           )),
//           UIHelper.verticalSpace(1),
//           buildEventInfo(),
//           // buildEventInfo(context),
//         ],
//       ),
//     );
//   }

//   Widget buildEventInfo() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         event['original_title'],
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(
//             color: MyTheme.isDark ? Colors.white : Colors.black,
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }

// class TopRatedMoviesCard extends StatelessWidget {
//   final dynamic event;

//   TopRatedMoviesCard(this.event);

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width * 0.8;
//     return Container(
//       width: width,
//       margin: const EdgeInsets.only(right: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Expanded(
//               child: InkWell(
//             onTap: () {
//               var movieID = event['id'];
//               print(movieID);
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => PopularMovie(movieId: movieID)));
//             },
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Container(
//                 color: Colors.transparent,
//                 width: double.infinity,
//                 child: Hero(
//                   tag: event['backdrop_path'],
//                   child: Image.network(
//                     "https://image.tmdb.org/t/p/w300" + event['backdrop_path'],
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//           )),
//           UIHelper.verticalSpace(1),
//           buildEventInfo()
//           // buildEventInfo(context),
//         ],
//       ),
//     );
//   }

//   Widget buildEventInfo() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         event['original_title'],
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(
//             color: MyTheme.isDark ? Colors.white : Colors.black,
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
