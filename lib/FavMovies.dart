import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:imdb_app/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'GrandCategories.dart';
import 'SelectedFilm.dart';

class FavMovies extends StatefulWidget {
  const FavMovies({Key? key}) : super(key: key);

  @override
  State<FavMovies> createState() => _FavMovies();
}

class _FavMovies extends State<FavMovies> {
  List idMovies = [];
  List favMovies = [];
  var movieId = [];
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
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, right: 20, left: 20, bottom: 20),
              child: GridView.builder(
                itemCount: favMovies.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: sizeScreen(),
                    childAspectRatio: 0.75,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20),
                itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectedFilm(
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
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          favMovies[index]['poster_path'] != ''
                                              ? "https://image.tmdb.org/t/p/w500/${favMovies[index]['poster_path']}"
                                              : 'https://media.istockphoto.com/photos/vintage-film-projector-and-film-screening-picture-id1179771730?k=20&m=1179771730&s=612x612&w=0&h=aTdFgxUzICqvhvpMJuYlMzumqtDkyg4fmbzULIqQwzc=',
                                        ),
                                        fit: BoxFit.fill),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 20,
                                right: 15,
                                child: IconButton(
                                    onPressed: () {
                                      deleteFav(favMovies[index]['id']);
                                      refreshAfterdelete();

                                      /*
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const FavMovies()));*/
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.deepOrangeAccent,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 38,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 8, left: 0, right: 10),
                          child: Text(
                            favMovies[index]['title'] ??
                                favMovies[index]['name'],
                            style: const TextStyle(fontFamily: 'Comfortaa'),
                          ),
                        ),
                      ),
                    ]),
              ),
            ))
          ],
        ));
  }

  refreshAfterdelete() async {
    setState(() {
      favMovies.clear();
      movieId.clear();
    });
    List arrayFavs = [];
    //var movieIds = [];
    var fireStore = FirebaseFirestore.instance;
    var currentUser = FirebaseAuth.instance.currentUser;
    final doc = await fireStore.collection("Users").doc(currentUser?.uid).get();
    movieId.insertAll(0, doc.data()!['favorites']);
    arrayFavs = movieId;
    print(arrayFavs.length);
    for (var i = 0; i < arrayFavs.length; i++) {
      var FilmInformationsJson = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/${arrayFavs[i]}?api_key=b14e6584347a3199c72afa43baddcdf8&language=en-US'));
      var film = jsonDecode(FilmInformationsJson.body);
      //print(film);
      print(arrayFavs[i]);
      setState(() {
        favMovies.add(film);
      });
    }
    print(favMovies);
  }

  loadData() async {
    //getMovies from firebase
    setState(() {
      favMovies.clear();
      movieId.clear();
    });

    var fireStore = FirebaseFirestore.instance;
    var currentUser = FirebaseAuth.instance.currentUser;
    final doc = await fireStore.collection("Users").doc(currentUser?.uid).get();
    movieId.add(doc.data()!['favorites']);
    List arrayFavs = movieId[0];

    for (var i = 0; i < arrayFavs.length; i++) {
      var FilmInformationsJson = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/${arrayFavs[i]}?api_key=b14e6584347a3199c72afa43baddcdf8&language=en-US'));
      var film = jsonDecode(FilmInformationsJson.body);
      //print(film);
      print(arrayFavs[i]);
      setState(() {
        favMovies.add(film);
      });
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
    Fluttertoast.showToast(msg: 'See You Soon');
  }

  void deleteFav(int filmId) async {
    //var movieId = [];
    User? user = FirebaseAuth.instance.currentUser;
    var fireStore = FirebaseFirestore.instance;
    await fireStore.collection("Users").doc(user?.uid).update({
      'favorites': FieldValue.arrayRemove([filmId])
    });
  }
}

class FilmItem extends StatelessWidget {
  const FilmItem(
      {Key? key,
      required this.favMovies,
      required this.filmId,
      required this.size,
      required this.images,
      required this.FilmTitle,
      required this.overview,
      required this.realeaseDate})
      : super(key: key);
  final int filmId;
  final Size size;
  final String images;
  final String FilmTitle;
  final String overview;
  final String realeaseDate;
  final List favMovies;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectedFilm(
                      images: images,
                      FilmTitle: FilmTitle,
                      overview: overview,
                      realeaseDate: realeaseDate,
                      filmId: filmId,
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(images), fit: BoxFit.fill),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 15,
                    child: IconButton(
                        onPressed: () {
                          deleteFav(filmId);

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const FavMovies()));
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.deepOrangeAccent,
                        )),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 38,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 0, right: 10),
              child: Text(
                FilmTitle,
                style: const TextStyle(fontFamily: 'Comfortaa'),
              ),
            ),
          ),
        ]);
  }

  void deleteFav(int filmId) async {
    var movieId = [];
    User? user = FirebaseAuth.instance.currentUser;
    var fireStore = FirebaseFirestore.instance;
    var currentUser = FirebaseAuth.instance.currentUser;
    await fireStore.collection("Users").doc(user?.uid).update({
      'favorites': FieldValue.arrayRemove([filmId])
    });
    final doc = await fireStore.collection("Users").doc(currentUser?.uid).get();
    movieId.add(doc.data()!['favorites']);
    List arrayFavs = movieId[0];

    for (var i = 0; i < arrayFavs.length; i++) {
      var FilmInformationsJson = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/${arrayFavs[i]}?api_key=b14e6584347a3199c72afa43baddcdf8&language=en-US'));
      var film = jsonDecode(FilmInformationsJson.body);
      //print(film);
      print(arrayFavs[i]);

      favMovies.add(film);
    }
  }
}
