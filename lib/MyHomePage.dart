import 'dart:html';

import 'package:tmdb_api/tmdb_api.dart';

import 'package:flutter/material.dart';

import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'package:fancy_bar/fancy_bar.dart';

import 'SelectedFilm.dart';

class MyHomePage extends StatefulWidget {
  final String grandCategorie;
  const MyHomePage({Key? key, required this.grandCategorie}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List trendingMovies = [];
  final String apiKey = 'b14e6584347a3199c72afa43baddcdf8';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMTRlNjU4NDM0N2EzMTk5YzcyYWZhNDNiYWRkY2RmOCIsInN1YiI6IjYyOWY5NTJmYThiMmNhMDA2NjA5MGJhNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IVYqNM7Euk2jX77eh4QiMVX-4q49RctBWLrV7gNDCy4';

  loadMovies() async {
    TMDB tmdbLogs = TMDB(ApiKeys(apiKey, readAccessToken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));
    Map trendingFilm = await tmdbLogs.v3.trending.getTrending();
    print(trendingFilm);
    setState(() {
      trendingMovies = trendingFilm['results'];
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

    int SizeScreen() {
      if (size.width < 667.0) {
        return 2;
      } else {
        return 4;
      }
    }

    var category = ['Action', 'Horror', 'Drama', 'History', 'Art'];

    print(size);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('arrow-left-line.png'),
          onPressed: () {},
        ),
        actions: <Widget>[
          SizedBox(
            width: 10,
          )
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
          MyWidget(),
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
                        images:
                            "https://image.tmdb.org/t/p/w500/${trendingMovies[index]['poster_path']}",
                        FilmTitle: trendingMovies[index]['title'] != null
                            ? trendingMovies[index]['title']
                            : trendingMovies[index]['name'],
                        overview: trendingMovies[index]['overview'] != null
                            ? trendingMovies[index]['overview']
                            : 'unavailable',
                        realeaseDate:
                            trendingMovies[index]['release_date'] != null
                                ? trendingMovies[index]['release_date']
                                : 'undifiened',
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
      required this.overview,
      required this.realeaseDate})
      : super(key: key);

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
                  ),
                ),
              );
            },
            child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(images), fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          )),
          SizedBox(
            height: 38,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                FilmTitle,
                style: TextStyle(fontFamily: 'Comfortaa'),
              ),
            ),
          ),
        ]);
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<String> category = ['Action', 'Horror', 'Drama', 'History', 'Art'];
  int selectedCategory = 0;
  Color KtextColor = Color(0xFF535353);
  Color KtextLightColor = Color(0xFFACACAC);

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
                      selectedCategory = index;
                    });
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
                          margin: EdgeInsets.only(top: 5),
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
