import 'dart:convert';
//import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'package:flutter/material.dart';

import 'LoginPage.dart';
import 'SelectedFilm.dart';

import 'package:http/http.dart' as http;

import 'GrandCategories.dart';

class MyHomePage extends StatefulWidget {
  final String grandCategorie;
  final String category;
  const MyHomePage({
    Key? key,
    required this.grandCategorie,
    this.category = 'All',
    //this.selectedCategory = 0,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedCategory = 0;
  String textCategory = 'All';
  List<String> category = [
    'All',
    'Action',
    'Animation',
    'Comedy',
    'Crime',
    'Drama',
    'Family',
  ];

  var categoryGenres = [
    {"id": 28, "index": 1},
    {"id": 16, "index": 2},
    {"id": 35, "index": 3},
    {"id": 80, "index": 4},
    {"id": 18, "index": 5},
    {"id": 10751, "index": 6},
  ];
  var Allgenres = {
    {"id": 28, "name": "Action"},
    {"id": 12, "name": "Adventure"},
    {"id": 16, "name": "Animation"},
    {"id": 35, "name": "Comedy"},
    {"id": 80, "name": "Crime"},
    {"id": 99, "name": "Documentary"},
    {"id": 18, "name": "Drama"},
    {"id": 10751, "name": "Family"},
    {"id": 14, "name": "Fantasy"},
    {"id": 36, "name": "History"},
    {"id": 27, "name": "Horror"},
    {"id": 10402, "name": "Music"},
    {"id": 9648, "name": "Mystery"},
    {"id": 10749, "name": "Romance"},
    {"id": 878, "name": "Science Fiction"},
    {"id": 10770, "name": "TV Movie"},
    {"id": 53, "name": "Thriller"},
    {"id": 10752, "name": "War"},
    {"id": 37, "name": "Western"},
    {"id": 10759, "name": "Action & Adventure"},
    {"id": 18, "name": "Drama"},
    {"id": 10762, "name": "Kids"},
    {"id": 10763, "name": "News"},
    {"id": 10764, "name": "Reality"},
    {"id": 10765, "name": "Sci-Fi & Fantasy"},
    {"id": 10766, "name": "Soap"},
    {"id": 10767, "name": "Talk"},
    {"id": 10768, "name": "War & Politics"},
    {"id": 37, "name": "Western"}
  };
  var allFIlms = [];
  List trendingMovies = [];
  var filtredMovies = [];
  final String apiKey = 'b14e6584347a3199c72afa43baddcdf8';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMTRlNjU4NDM0N2EzMTk5YzcyYWZhNDNiYWRkY2RmOCIsInN1YiI6IjYyOWY5NTJmYThiMmNhMDA2NjA5MGJhNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IVYqNM7Euk2jX77eh4QiMVX-4q49RctBWLrV7gNDCy4';

  loadMovies() async {
    TMDB tmdbLogs = TMDB(ApiKeys(apiKey, readAccessToken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));
    if (widget.grandCategorie == 'Trending') {
      Map trendingFilmPage1 = await tmdbLogs.v3.trending.getTrending(page: 1);
      Map trendingFilmPage2 = await tmdbLogs.v3.trending.getTrending(page: 2);
      Map trendingFilmPage3 = await tmdbLogs.v3.trending.getTrending(page: 3);
      Map trendingFilmPage4 = await tmdbLogs.v3.trending.getTrending(page: 4);
      Map trendingFilmPage5 = await tmdbLogs.v3.trending.getTrending(page: 5);
      Map trendingFilmPage6 = await tmdbLogs.v3.trending.getTrending(page: 6);
      Map trendingFilmPage7 = await tmdbLogs.v3.trending.getTrending(page: 7);

      allFIlms = [
        ...trendingFilmPage1['results'],
        ...trendingFilmPage2['results'],
        ...trendingFilmPage3['results'],
        ...trendingFilmPage4['results'],
        ...trendingFilmPage5['results'],
        ...trendingFilmPage6['results'],
        ...trendingFilmPage7['results'],
      ];
    } else {
      //print(myController.text);
      var topJson1 = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=b14e6584347a3199c72afa43baddcdf8&language=en-US'));

      var topRated1 = jsonDecode(topJson1.body);

      var topJson2 = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=b14e6584347a3199c72afa43baddcdf8&language=en-US&page=2'));

      var topRated2 = jsonDecode(topJson2.body);

      var topJson3 = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=b14e6584347a3199c72afa43baddcdf8&language=en-US&page=3'));

      var topRated3 = jsonDecode(topJson3.body);

      var topJson4 = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=b14e6584347a3199c72afa43baddcdf8&language=en-US&page=4'));

      var topRated4 = jsonDecode(topJson4.body);

      allFIlms = [
        ...topRated1['results'],
        ...topRated2['results'],
        ...topRated3['results'],
        ...topRated4['results']
      ];

      print(allFIlms);
    }

    //var tempMovies = allFIlms;
    //int tempSelectedCategory = widget.selectedCategory;
    if (selectedCategory != 0) {
      var tempMovies = allFIlms;
      filtredMovies = [];
      for (int i = 0; i < tempMovies.length; i++) {
        for (int j = 0; j < tempMovies[i]['genre_ids'].length; j++) {
          if (tempMovies[i]['genre_ids'][j] ==
              categoryGenres[selectedCategory - 1]['id']) {
            //print(selectedCategory);
            filtredMovies.add(tempMovies[i]);
          }
        }
      }
    }
    print(selectedCategory);
    print(textCategory);
    //print(allFIlms[0]['poster_path']);
    setState(() {
      if (selectedCategory == 0) {
        trendingMovies = allFIlms;
      } else {
        trendingMovies = filtredMovies;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //int tempSelectedCategory = selectedCategory;
    Color KtextColor = const Color(0xFF535353);
    Color KtextLightColor = const Color(0xFFACACAC);
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
          icon: Image.asset('arrow-left-line.png'),
          onPressed: () {
            Navigator.of(context).pop(
                MaterialPageRoute(builder: ((context) => GrandCategories())));
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
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.grandCategorie,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          //MyWidget(selectedCategory: widget.selectedCategory),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              height: 25,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.length,
                  itemBuilder: ((context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = index;
                        textCategory = category[index];
                      });

                      loadMovies();
                      /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                grandCategorie: 'In Cinema',
                                //category: category[index],
                              ),
                            ),
                          );*/
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category[index],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: selectedCategory == index
                                    ? KtextColor
                                    : KtextLightColor),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            height: 2,
                            width: 30,
                            color: selectedCategory == index
                                ? Colors.black
                                : Colors.transparent,
                          )
                        ],
                      ),
                    ),
                  ))),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, right: 20, left: 20, bottom: 20),
              child: GridView.builder(
                  itemCount: trendingMovies.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: SizeScreen(),
                      childAspectRatio: 0.75,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20),
                  itemBuilder: (context, index) => FilmItem(
                    size: size,
                    images: trendingMovies[index]['poster_path'] != ''
                        ? "https://image.tmdb.org/t/p/w500/${trendingMovies[index]['poster_path']}"
                        : 'https://media.istockphoto.com/photos/vintage-film-projector-and-film-screening-picture-id1179771730?k=20&m=1179771730&s=612x612&w=0&h=aTdFgxUzICqvhvpMJuYlMzumqtDkyg4fmbzULIqQwzc=',
                    FilmTitle: trendingMovies[index]['title'] ??
                        trendingMovies[index]['name'],
                    overview:
                    trendingMovies[index]['overview'] ?? 'unavailable',
                    realeaseDate: trendingMovies[index]['release_date'] ??
                        'undefined',
                    filmId: trendingMovies[index]['id'],
                  )),
            ),
          )
        ],
      ),
    );
  }
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
    Fluttertoast.showToast(msg: 'See You Soon');
  }
}

class FilmItem extends StatelessWidget {
  const FilmItem(
      {Key? key,
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

class MyWidget extends StatefulWidget {
  int selectedCategory;
  MyWidget({Key? key, this.selectedCategory = 0}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<String> category = [
    'All',
    'Action',
    'Animation',
    'Comedy',
    'Crime',
    'Drama',
    'Family',
  ];
  //int selectedCategory ;
  Color KtextColor = const Color(0xFF535353);
  Color KtextLightColor = const Color(0xFFACACAC);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: category.length,
            itemBuilder: ((context, index) => GestureDetector(
              onTap: () {
                setState(() {
                  widget.selectedCategory = index;
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(
                      grandCategorie: 'In Cinema',
                      category: category[index],
                      //selectedCategory: index
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category[index],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget.selectedCategory == index
                              ? KtextColor
                              : KtextLightColor),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 2,
                      width: 30,
                      color: widget.selectedCategory == index
                          ? Colors.black
                          : Colors.transparent,
                    )
                  ],
                ),
              ),
            ))),
      ),
    );
  }

}

/*
class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;
  CircleTabIndicator({required Color color, required double radius})
      : _painter = _CirclePainter(color, radius);
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}
class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;
  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius - 5);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
*/