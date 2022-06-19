import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'SelectedFilm.dart';
import 'package:http/http.dart' as http;
import 'GrandCategories.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final myController = TextEditingController();
  List searchedMovies = [];

  loadSearchedMovies() async {
    //print(myController.text);
    var searchedJson = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=b14e6584347a3199c72afa43baddcdf8&language=en-US&query=${myController.text}'));

    var searched = jsonDecode(searchedJson.body);
    setState(() {
      searchedMovies = searched['results'];
    });
    print(searchedMovies.length);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int SizeScreen() {
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
          icon: Image.asset('assets/background/arrow-left-line.png'),
          onPressed: () {
            Navigator.of(context).pop(
                MaterialPageRoute(builder: ((context) => GrandCategories())));
          },
        ),
        actions: const <Widget>[
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Search',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 20, top: 20, left: 20, right: 20),
            child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(50, 228, 228, 228),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: TextFormField(
                        controller: myController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              size: 20,
                            ),
                            prefixIconColor: Color(0xFF6C53EF),
                            border: InputBorder.none,
                            //labelText: 'search',
                            hintText: 'Search')))),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: RaisedButton(
              onPressed: () {
                loadSearchedMovies();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              padding: const EdgeInsets.all(0.0),
              child: Ink(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFF6C53EF),
                        Color.fromARGB(159, 108, 83, 239)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.7, 1]),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Container(
                  constraints: const BoxConstraints(
                      minWidth: 88.0,
                      minHeight: 36.0), // min sizes for Material buttons
                  alignment: Alignment.center,
                  child: const Text(
                    "Search",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, right: 20, left: 20, bottom: 20),
              child: GridView.builder(
                  itemCount:
                      searchedMovies.length < 20 ? searchedMovies.length : 20,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: SizeScreen(),
                      childAspectRatio: 0.75,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20),
                  itemBuilder: (context, index) => FilmItem(
                        size: size,
                        images: searchedMovies[index]['poster_path'] != null
                            ? "https://image.tmdb.org/t/p/w500/${searchedMovies[index]['poster_path']}"
                            : 'https://images.unsplash.com/photo-1542204637-e67bc7d41e48?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fGZpbG1zfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                        FilmTitle: searchedMovies[index]['title'] ??
                            searchedMovies[index]['name'],
                        overview:
                            searchedMovies[index]['overview'] ?? 'unavailable',
                        realeaseDate: searchedMovies[index]['release_date'] ??
                            'undefined',
                        filmId: searchedMovies[index]['id'],
                      )),
            ),
          )
        ],
      ),
    );
  }
}

class FilmItem extends StatelessWidget {
  const FilmItem(
      {Key? key,
      required this.size,
      required this.images,
      required this.FilmTitle,
      required this.filmId,
      required this.overview,
      required this.realeaseDate})
      : super(key: key);

  final int filmId;
  final Size size;
  final String images;
  final String FilmTitle;
  final String overview;
  final String realeaseDate;

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
            child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(images), fit: BoxFit.fill),
                    borderRadius: const BorderRadius.all(Radius.circular(20)))),
          )),
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
}
