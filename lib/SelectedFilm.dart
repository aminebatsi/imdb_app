import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  final _auth = FirebaseAuth.instance;
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(
              height: size.height * 0.45,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: size.height * 0.45 - 50,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                        ),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w300/${selectedMovie["poster_path"]}"))),
                  ),
                  //ts
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                          height: 80,
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                topLeft: Radius.circular(50),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 5),
                                  blurRadius: 50,
                                  color: const Color(0xFF121530).withOpacity(0.2),
                                )
                              ]),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/background/star-half-fill.png'),
                                    const SizedBox(height: 5),
                                    RichText(
                                        text: TextSpan(
                                            style:
                                            const TextStyle(color: Colors.black),
                                            children: [
                                              TextSpan(
                                                  text:
                                                  '${selectedMovie["vote_average"]}/',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600)),
                                              const TextSpan(text: '10\n'),
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
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF51CF66),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Text(
                                        '--',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
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
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10),
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
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text('${selectedMovie["release_date"]}',
                                style: TextStyle(color: KtextLightColor)),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('${selectedMovie["original_language"]}',
                                style: TextStyle(color: KtextLightColor)),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('${selectedMovie["runtime"]} Min',
                                style: TextStyle(color: KtextLightColor)),
                          ],
                        )
                      ]),
                ),
                Container(
                  height: 50,
                  width: 50,
                  child: FlatButton(
                      onPressed: () {
                        addToFav(selectedMovie['id']);
                      },
                      color: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child:  Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.white,
                        ),
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 36,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: genres.length,
                  itemBuilder: (context, index) => Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 20),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                'Overview',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(widget.overview,
                style: const TextStyle(color: Color(0xFF737599))),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Cast & Credit',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 160,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: actors.length < 8 ? actors.length : 7,
                    itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.only(right: 20),
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
                            const SizedBox(height: 10),
                            Text(
                              actors[index]['original_name'],
                              style: Theme.of(context).textTheme.bodyText2,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 5),
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

  addToFav(int filmId) async {
    try{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    await firebaseFirestore.collection("Users").doc(user?.uid).set(
        {
          "favorites" : FieldValue.arrayUnion([filmId]),
        },SetOptions(merge: true));
    Fluttertoast.showToast(msg: "Added");
  } catch(e){
      Fluttertoast.showToast(msg: 'Try Later');
    }
  }
}
