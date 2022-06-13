import 'dart:html';

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
    Color KtextColor = const Color(0xFF535353);
    Color KtextLightColor = const Color(0xFFACACAC);
    List<String> category = ['Action', 'Horror', 'Romance'];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
            height: size.height * 0.3,
            child: Stack(
              children: <Widget>[
                Container(
                  height: size.height * 0.3 - 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                      ),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(widget.images))),
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
                                          style: TextStyle(color: Colors.black),
                                          children: [
                                        TextSpan(
                                            text: '10/',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)),
                                        TextSpan(text: '10\n'),
                                        TextSpan(
                                            text: "15000",
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
                                  Text('123.23',
                                      style: TextStyle(color: KtextLightColor))
                                ],
                              )
                            ])))
              ],
            )),
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
                          Text('year',
                              style: TextStyle(color: KtextLightColor)),
                          SizedBox(
                            width: 10,
                          ),
                          Text('langu',
                              style: TextStyle(color: KtextLightColor)),
                          SizedBox(
                            width: 10,
                          ),
                          Text('langu',
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
                itemCount: category.length,
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
                        category[index],
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
          child:
              Text(widget.overview, style: TextStyle(color: Color(0xFF737599))),
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
            //SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
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
                                    image: AssetImage('boxOfiice.jpg'))),
                          )
                        ],
                      ))),
            )
          ]),
        )
      ]),
    );
  }
}
