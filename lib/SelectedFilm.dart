import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class SelectedFilm extends StatefulWidget {
  const SelectedFilm(
      {Key? key,
      required this.images,
      required this.FilmTitle,
      required this.overview,
      required this.realeaseDate,
      required this.filmId})
      : super(key: key);
  final int filmId;
  final String images;
  final String FilmTitle;
  final String overview;
  final String realeaseDate;

  @override
  State<SelectedFilm> createState() => _SelectedFilmState();
}

class _SelectedFilmState extends State<SelectedFilm> {
  var selectedMovie = {};
  var genres = [];
  var actors = [];
  final String apiKey = 'b14e6584347a3199c72afa43baddcdf8';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMTRlNjU4NDM0N2EzMTk5YzcyYWZhNDNiYWRkY2RmOCIsInN1YiI6IjYyOWY5NTJmYThiMmNhMDA2NjA5MGJhNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IVYqNM7Euk2jX77eh4QiMVX-4q49RctBWLrV7gNDCy4';

  loadMovies() async {
    var FilmInformationsJson = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/${widget.filmId}?api_key=b14e6584347a3199c72afa43baddcdf8&language=en-US'));

    var filmCreditJson = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/${widget.filmId}/credits?api_key=b14e6584347a3199c72afa43baddcdf8&language=en-US'));

    //var filmInformations = jsonDecode(FilmInformationsJson.body);
    //print(filmInformations);
    var filmCredit = jsonDecode(filmCreditJson.body);
    setState(() {
      selectedMovie = jsonDecode(FilmInformationsJson.body);
      actors = filmCredit['cast'];
      genres = selectedMovie['genres'];
    });
    print(actors);
    //print(genres[1]["name"]);
  }

  void initState() {
    // TODO: implement initState
    loadMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color KtextColor = const Color(0xFF535353);
    Color KtextLightColor = const Color(0xFFACACAC);
    List<String> category = ['Action', 'Horror', 'Romance'];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
              height: size.height * 0.45,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: size.height * 0.45 - 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                        ),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w300/${selectedMovie["backdrop_path"]}"))),
                  ),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                          height: 80,
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                topLeft: Radius.circular(50),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 5),
                                  blurRadius: 50,
                                  color: Color(0xFF121530).withOpacity(0.2),
                                )
                              ]),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('star-half-fill.png'),
                                    SizedBox(height: 5),
                                    RichText(
                                        text: TextSpan(
                                            style:
                                                TextStyle(color: Colors.black),
                                            children: [
                                          TextSpan(
                                              text:
                                                  '${selectedMovie["vote_average"]}/',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600)),
                                          TextSpan(text: '10\n'),
                                          TextSpan(
                                              text:
                                                  "${selectedMovie["vote_count"]}",
                                              style: TextStyle(
                                                  color: KtextLightColor))
                                        ]))
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF51CF66),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        '--',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Popularity',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    Text('${selectedMovie["popularity"]}',
                                        style:
                                            TextStyle(color: KtextLightColor))
                                  ],
                                )
                              ])))
                ],
              )),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.FilmTitle,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text('${selectedMovie["release_date"]}',
                                style: TextStyle(color: KtextLightColor)),
                            SizedBox(
                              width: 10,
                            ),
                            Text('${selectedMovie["original_language"]}',
                                style: TextStyle(color: KtextLightColor)),
                            SizedBox(
                              width: 10,
                            ),
                            Text('${selectedMovie["runtime"]} Min',
                                style: TextStyle(color: KtextLightColor)),
                          ],
                        )
                      ]),
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: FlatButton(
                      onPressed: () {},
                      color: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 28,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 36,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: genres.length,
                  itemBuilder: (context, index) => Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          genres[index]["name"],
                          style: TextStyle(
                              color: KtextColor.withOpacity(0.8), fontSize: 16),
                        ),
                      )),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                'Overview',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(widget.overview,
                style: TextStyle(color: Color(0xFF737599))),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Cast & Credit',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 160,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: actors.length < 8 ? actors.length : 7,
                    itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.only(right: 20),
                        width: 80,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://image.tmdb.org/t/p/w300/${"https://image.tmdb.org/t/p/w300/${actors[index]['profile_path']}"}"))),
                            ),
                            SizedBox(height: 10),
                            Text(
                              actors[index]['original_name'],
                              style: Theme.of(context).textTheme.bodyText2,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            SizedBox(height: 5),
                            Text(
                              actors[index]['character'],
                              style: TextStyle(color: KtextLightColor),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            ),
                          ],
                        ))),
              )
            ]),
          )
        ]),
      ),
    );
  }
}
