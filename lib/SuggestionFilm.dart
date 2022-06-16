import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:imdb_app/LoginPage.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:http/http.dart' as http;
import 'GrandCategories.dart';
import 'MyHomePage.dart';

class SuggestionFilm extends StatefulWidget {
  const SuggestionFilm({Key? key}) : super(key: key);

  @override
  State<SuggestionFilm> createState() => _SuggestionFilmState();
}

class _SuggestionFilmState extends State<SuggestionFilm> {
  List idMovies = [];
  List favMovies = [];

  final String apiKey = 'b14e6584347a3199c72afa43baddcdf8';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMTRlNjU4NDM0N2EzMTk5YzcyYWZhNDNiYWRkY2RmOCIsInN1YiI6IjYyOWY5NTJmYThiMmNhMDA2NjA5MGJhNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IVYqNM7Euk2jX77eh4QiMVX-4q49RctBWLrV7gNDCy4';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int sizeScreen() {
      if (size.width < 667.0) {
        return 2;
      } else {
        return 4;
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Image.asset('arrow-left-line.png'),
            onPressed: () {
              Navigator.of(context).pop(MaterialPageRoute(
                  builder: ((context) => const GrandCategories())));
            },
          ),
          actions: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                  padding: const EdgeInsetsDirectional.only(start: 40),
                  child: IconButton(
                    icon: const Icon(
                      Icons.login_outlined,
                      color: Colors.black45,
                    ),
                    onPressed: () {
                      logout(context);
                    },
                  ))
            ])
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Text(
                'Favorites',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            isLoading == false
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, right: 20, left: 20, bottom: 20),
                      child: GridView.builder(
                          itemCount: favMovies.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: sizeScreen(),
                                  childAspectRatio: 0.75,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20),
                          itemBuilder: (context, index) => FilmItem(
                                size: size,
                                images: favMovies[index]['poster_path'] != ''
                                    ? "https://image.tmdb.org/t/p/w500/${favMovies[index]['poster_path']}"
                                    : 'https://media.istockphoto.com/photos/vintage-film-projector-and-film-screening-picture-id1179771730?k=20&m=1179771730&s=612x612&w=0&h=aTdFgxUzICqvhvpMJuYlMzumqtDkyg4fmbzULIqQwzc=',
                                FilmTitle: favMovies[index]['title'] ??
                                    favMovies[index]['name'],
                                overview: favMovies[index]['overview'] ??
                                    'unavailable',
                                realeaseDate: favMovies[index]
                                        ['release_date'] ??
                                    'undefined',
                                filmId: favMovies[index]['id'],
                              )),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: size.height * 0.45),
                    child: Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(color: Colors.pink)),
                  ),
          ],
        ));
  }

  var isLoading = true;
  loadData() async {
    //getMovies from firebase
    var movieId = [];
    var fireStore = FirebaseFirestore.instance;
    var currentUser = FirebaseAuth.instance.currentUser;
    final doc = await fireStore.collection("Users").doc(currentUser?.uid).get();
    movieId.add(doc.data()!['favorites']);
    /*
    // filter movie
    TMDB tmdbLogs = TMDB(ApiKeys(apiKey, readAccessToken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));
    Map trendingFilmPage1 = await tmdbLogs.v3.trending.getTrending(page: 1);
    Map trendingFilmPage2 = await tmdbLogs.v3.trending.getTrending(page: 2);
    Map trendingFilmPage3 = await tmdbLogs.v3.trending.getTrending(page: 3);
    Map trendingFilmPage4 = await tmdbLogs.v3.trending.getTrending(page: 4);
    Map trendingFilmPage5 = await tmdbLogs.v3.trending.getTrending(page: 5);
    Map trendingFilmPage6 = await tmdbLogs.v3.trending.getTrending(page: 6);
    Map trendingFilmPage7 = await tmdbLogs.v3.trending.getTrending(page: 7);

    var allFIlms = [
      ...trendingFilmPage1['results'],
      ...trendingFilmPage2['results'],
      ...trendingFilmPage3['results'],
      ...trendingFilmPage4['results'],
      ...trendingFilmPage5['results'],
      ...trendingFilmPage6['results'],
      ...trendingFilmPage7['results'],
    ];*/
    List arrayFavs = movieId[0];
    //print(movieId);
    /*
    for (var i = 0; i < allFIlms.length; i++) {
      for (var j = 0; j < movieId[0].length; j++) {
        if (movieId[0][j] == allFIlms[i]['id']) {
          setState(() {
            favMovies.add(allFIlms[i]);
          });

          break;
        }
      }
    }*/
    var SuggestionFilm = [];
    var lenghtSuggestion = arrayFavs.length > 10 ? arrayFavs.length - 5 : 0;
    for (var i = lenghtSuggestion; i < arrayFavs.length; i++) {
      var FilmInformationsJson = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/${arrayFavs[i]}/similar?api_key=b14e6584347a3199c72afa43baddcdf8&language=en-US&page=1'));
      var film = jsonDecode(FilmInformationsJson.body);
      for (var j = 0;
          j < (film['results'].length < 20 ? film['results'].length : 5);
          j++) {
        setState(() {
          SuggestionFilm.add(film['results'][j]);
        });
      }
    }
    setState(() {
      favMovies = SuggestionFilm;
    });
    if (favMovies != null) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
    Fluttertoast.showToast(msg: 'See You Soon');
  }
}
