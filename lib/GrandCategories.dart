import 'package:flutter/material.dart';
import 'package:imdb_app/FavMovies.dart';
import 'package:imdb_app/SuggestionFilm.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'ColorFilters.dart';
import 'MyHomePage.dart';
import 'SearchScreen.dart';
import 'Profile.dart';

class GrandCategories extends StatefulWidget {
  const GrandCategories({Key? key}) : super(key: key);

  @override
  State<GrandCategories> createState() => _GrandCategoriesState();
}

class _GrandCategoriesState extends State<GrandCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 40),
              child: IconButton(
                  icon: Icon(Icons.search, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => SearchScreen())));
                  }),
              /*onPressed: () {
                  logout(context);
                },*/
            )
          ])
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                child: Text(
                  'Categories',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(42)),
                  child: Stack(alignment: Alignment.center, children: <Widget>[
                    Ink.image(
                      image: const NetworkImage(
                          'https://media.istockphoto.com/photos/vintage-film-projector-and-film-screening-picture-id1179771730?k=20&m=1179771730&s=612x612&w=0&h=aTdFgxUzICqvhvpMJuYlMzumqtDkyg4fmbzULIqQwzc='),
                      colorFilter: ColorFilters.greyscale,
                      height: 150,
                      fit: BoxFit.cover,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const MyHomePage(
                                  grandCategorie: 'Trending',
                                )),
                          ));
                        },
                      ),
                    ),
                    const Text(
                      'Trending',
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          color: Colors.white,
                          fontSize: 24),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(42)),
                  child: Stack(alignment: Alignment.center, children: <Widget>[
                    Ink.image(
                      image: const NetworkImage(
                          'https://media.istockphoto.com/photos/girl-enjoying-watching-a-nice-movie-at-the-cinema-picture-id1340577488?k=20&m=1340577488&s=612x612&w=0&h=CmkT8ZjztgBlasHdWXtU6kuHHJU9f4FMlFSOtIeAes8='),
                      colorFilter: ColorFilters.greyscale,
                      height: 150,
                      fit: BoxFit.cover,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const MyHomePage(
                                  grandCategorie: 'Top Rated',
                                )),
                          ));
                        },
                      ),
                    ),
                    const Text(
                      'Top Rated',
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          color: Colors.white,
                          fontSize: 24),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(42)),
                  child: Stack(alignment: Alignment.center, children: <Widget>[
                    Ink.image(
                      image: const AssetImage('cinema.jpg'),
                      colorFilter: ColorFilters.greyscale,
                      height: 150,
                      fit: BoxFit.cover,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const FavMovies()),
                          ));
                        },
                      ),
                    ),
                    const Text(
                      'Your Favorites',
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          color: Colors.white,
                          fontSize: 24),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(42)),
                  child: Stack(alignment: Alignment.center, children: <Widget>[
                    Ink.image(
                      image: const NetworkImage(
                          'https://media.istockphoto.com/photos/girl-enjoying-watching-a-nice-movie-at-the-cinema-picture-id1340577488?k=20&m=1340577488&s=612x612&w=0&h=CmkT8ZjztgBlasHdWXtU6kuHHJU9f4FMlFSOtIeAes8='),
                      colorFilter: ColorFilters.greyscale,
                      height: 150,
                      fit: BoxFit.cover,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const SuggestionFilm()),
                          ));
                        },
                      ),
                    ),
                    const Text(
                      'Suggestion',
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          color: Colors.white,
                          fontSize: 24),
                    ),
                  ]),
                ),
              ),
            ]),
      ),
    );
  }
}
