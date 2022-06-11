import 'package:tmdb_api/tmdb_api.dart';

import 'package:flutter/material.dart';

import 'SelectedFilm.dart';

class MyHomePage extends StatefulWidget {
  final String grandCategorie;
  final String category;
  final int selectedCategory;
  const MyHomePage({
    Key? key,
    required this.grandCategorie,
    this.category = 'All',
    this.selectedCategory = 0,
  }) : super(key: key);

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
  List<String> category = [
    'All',
    'Action',
    'Animation',
    'Drama',
    'Comedy',
    'Family',
    'Crime'
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
    Map trendingFilmPage1 = await tmdbLogs.v3.trending.getTrending(page: 1);
    Map trendingFilmPage2 = await tmdbLogs.v3.trending.getTrending(page: 2);
    Map trendingFilmPage3 = await tmdbLogs.v3.trending.getTrending(page: 3);
    Map trendingFilmPage4 = await tmdbLogs.v3.trending.getTrending(page: 4);
    //print(trendingFilm);
    print(trendingFilmPage2);
    var tempMovies = trendingFilmPage2['results'];

    setState(() {
      trendingMovies = trendingFilmPage2['results'];
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

    print(size);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('arrow-left-line.png'),
          onPressed: () {},
        ),
        actions: const <Widget>[
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
          MyWidget(selectedCategory: widget.selectedCategory),
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
                        FilmTitle: trendingMovies[index]['title'] ??
                            trendingMovies[index]['name'],
                        overview:
                            trendingMovies[index]['overview'] ?? 'unavailable',
                        realeaseDate: trendingMovies[index]['release_date'] ??
                            'undefined',
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
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(images), fit: BoxFit.fill),
                    borderRadius: const BorderRadius.all(Radius.circular(20)))),
          )),
          SizedBox(
            height: 38,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 25, right: 10),
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
    'Horror',
    'Drama',
    'History',
    'Art'
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
                            selectedCategory: index),
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
