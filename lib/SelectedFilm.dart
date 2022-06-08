import 'package:flutter/material.dart';

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

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> category = ['Action', 'Horror', 'Romance'];
    return ListView(children: <Widget>[
      Container(
        height: 350,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.images),
            alignment: Alignment.center,
            fit: BoxFit.fill,
          ),
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(80)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 10,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 350,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.FilmTitle,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              decoration: TextDecoration.none)),
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 11.0),
                      child: Text(widget.realeaseDate,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              decoration: TextDecoration.none)),
                    )),
              ],
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.all(5),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                shape : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Colors.red)
                ),),

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
                            padding: const EdgeInsets.only(top: 20, left: 10),
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
            padding: const EdgeInsets.all(10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.overview,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey,
                      decoration: TextDecoration.none),
                )))
      ])
    ]);
  }
}
