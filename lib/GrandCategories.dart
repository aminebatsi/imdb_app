import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'ColorFilters.dart';
import 'MyHomePage.dart';
import 'SearchScreen.dart';

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
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Color(0xFF535353),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(42)),
            child: Stack(alignment: Alignment.center, children: <Widget>[
              Ink.image(
                image: const AssetImage('boxOfiice.jpg'),
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
                    fontFamily: 'Comfortaa', color: Colors.white, fontSize: 24),
              ),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(42)),
            child: Stack(alignment: Alignment.center, children: <Widget>[
              Ink.image(
                image: const AssetImage('comingsoon.jpg'),
                colorFilter: ColorFilters.greyscale,
                height: 150,
                fit: BoxFit.cover,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const MyHomePage(
                            grandCategorie: 'All Movies',
                          )),
                    ));
                  },
                ),
              ),
              const Text(
                'All Movies',
                style: TextStyle(
                    fontFamily: 'Comfortaa', color: Colors.white, fontSize: 24),
              ),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(42)),
            child: Stack(alignment: Alignment.center, children: <Widget>[
              Ink.image(
                image: const AssetImage('cinema.jpg'),
                colorFilter: ColorFilters.greyscale,
                height: 150,
                fit: BoxFit.cover,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const MyHomePage(
                            grandCategorie: 'In Cinema',
                          )),
                    ));
                  },
                ),
              ),
              const Text(
                'In Cinema',
                style: TextStyle(
                    fontFamily: 'Comfortaa', color: Colors.white, fontSize: 24),
              ),
            ]),
          ),
        )
      ]),
    );
  }
}
