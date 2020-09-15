import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/screens/moviedetails.dart';
import 'package:movie_app/shared/api_key.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  Timer searchOnStoppedTyping;
  Timer timer;
  TextEditingController textController;
  Map searchResults;
  bool searchLoaded = false;

  Future getSearchResults() async {
    if (textController.text == "") {
      searchResults = null;
    } else {
      http.Response response = await http.get(
          "https://api.themoviedb.org/3/search/movie?api_key=${apiKey}&language=en-US&query=${textController.text}&page=1&include_adult=false");
      // if (response.statusCode==200){
      searchResults = json.decode(response.body);
    }
    if (searchResults != null) {
      setState(() {
        searchLoaded = true;
      });
    } else {
      setState(() {
        searchLoaded = false;
      });
    }
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   textController.text = "";
  //   searchResults = {};
  //   textController.dispose();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController = TextEditingController();
    textController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                textController.text = "";
              });
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(
                      fontSize: 16.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)))),
                controller: textController,
                onChanged: (value) {
                  setState(() {
                    getSearchResults();
                  });
                },
              ),
            ),
          ), // ye search bar wala container hai
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: (!searchLoaded || textController.text == "")
                ? Container(
                    child: Center(child: Text("Enter Something to Search")),
                  )
                : Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchResults["results"].length,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(searchResults["results"][index]
                              ['original_title']),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetails(
                                      movieId: searchResults["results"][index]
                                          ['id']),
                                ));
                          },
                        );
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
