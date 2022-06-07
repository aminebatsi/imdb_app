import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'dart:convert';

class SelectedFilm extends StatefulWidget {
  //const ({Key? key}) : super(key: key);
  late final String name;

  SelectedFilm(this.name);

  String getName() {
    return name;
  }

  @override
  State<SelectedFilm> createState() => _SelectedFilmState(name);
}

class _SelectedFilmState extends State<SelectedFilm> {
  String name = "";

  _SelectedFilmState(this.name);

  Map trendingMovies = {};
  final String apiKey = '88dc8a75006828a15eabe1b1d0b35352';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4OGRjOGE3NTAwNjgyOGExNWVhYmUxYjFkMGIzNTM1MiIsInN1YiI6IjYyOWYzMGEyNjVlMGEyMTYxMTc3NGZmOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.t7mlLBji9QgXlZutT03uv5P-NzDz2DZx_0GRoZB4htU';

  loadMovies() async {
    TMDB tmdbLogs = TMDB(ApiKeys(apiKey, readAccessToken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));
    Map trendingFilm = await tmdbLogs.v3.trending.getTrending();
    setState(() {
      for (int i = 0; i < trendingFilm.length; i++) {
        if (trendingFilm['results'][i]['original_title'] == name) {
          trendingMovies = trendingFilm['results'][i];
        }
      }
      print(trendingMovies['original_title']);
    });
  }

  void initState() {
    // TODO: implement initState
    loadMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var react = MediaQuery.of(context).size.width - 50;
    var images = [
      'https://images.unsplash.com/photo-1536440136628-849c177e76a1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bW92aWVzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1594909122845-11baa439b7bf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bW92aWVzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1505686994434-e3cc5abf1330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8bW92aWVzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60'
    ];
    List<String> category = ['Action', 'Horror', 'Romance'];
    return ListView(children: <Widget>[
      Stack(children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://image.tmdb.org/t/p/w500${trendingMovies['poster_path']}"
                  ),
                  alignment: const Alignment(-.2, 0),
                  fit: BoxFit.cover),
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(80))),
        ),
        Positioned(
            right: 0,
            top: 200,
            child: Container(
              height: 50,
              width: react,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    //background color of box
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 40.0, // soften the shadow
                      spreadRadius: 2.0, //extend the shadow
                      offset: Offset(
                        15.0, // Move to right 10  horizontally
                        15.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0))),
            )),
      ]),
      const SizedBox(
        height: 25,
      ),
      Row(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(trendingMovies['original_title'],
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        decoration: TextDecoration.none)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(trendingMovies['release_date'],
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        decoration: TextDecoration.none)),
              ),
            ],
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.all(5),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                child: const Icon(Icons.add)),
          ),
        ],
      ),
      SizedBox(
          height: 50,
          width: 50,
          child: Scaffold(
              body: Row(children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                color: Colors.white,
                height: 50,
                child: Center(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, i) {
                        return Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 201, 198, 198)),
                                    color: Colors.transparent),
                                child: Center(child: Text(category[i])),
                              ),
                            ));
                      }),
                ),
              ),
            )
          ]))),
      Column(children: [
        const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Overview',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.left,
                ))),
        Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  trendingMovies['overview'],
                  style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      decoration: TextDecoration.none),
                )))
      ])
    ]);
  }
}
