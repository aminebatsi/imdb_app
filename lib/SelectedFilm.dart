import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'dart:convert';

class SelectedFilm extends StatefulWidget {
  const SelectedFilm(
      {Key? key,
      required this.images,
      required this.FilmTitle,
      required this.overview,
      required this.realeaseDate})
      : super(key: key);

  final String images;
  final String FilmTitle;
  final String overview;
  final String realeaseDate;

  @override
  State<SelectedFilm> createState() => _SelectedFilmState();
}

class _SelectedFilmState extends State<SelectedFilm> {
  Map trendingMovies = {};
  final String apiKey = 'b14e6584347a3199c72afa43baddcdf8';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMTRlNjU4NDM0N2EzMTk5YzcyYWZhNDNiYWRkY2RmOCIsInN1YiI6IjYyOWY5NTJmYThiMmNhMDA2NjA5MGJhNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IVYqNM7Euk2jX77eh4QiMVX-4q49RctBWLrV7gNDCy4';
  /*
  loadMovies() async {
    TMDB tmdbLogs = TMDB(ApiKeys(apiKey, readAccessToken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));
    Map trendingFilm = await tmdbLogs.v3.trending.getTrending();

    setState(() {
      for (int i = 0; i < trendingFilm.length; i++) {
        if (trendingFilm['results'][i]['original_title'] == widget.name) {
          trendingMovies = trendingFilm['results'][i];
        }
      }
      print(trendingMovies['original_title']);
    });
  }*/

  void initState() {
    // TODO: implement initState
    //loadMovies();
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
                  image: NetworkImage(widget.images),
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
                child: Text(widget.FilmTitle,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        decoration: TextDecoration.none)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(widget.realeaseDate,
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
                  widget.overview,
                  style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      decoration: TextDecoration.none),
                )))
      ])
    ]);
  }
}
