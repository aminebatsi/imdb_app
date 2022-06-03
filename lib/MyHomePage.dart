import 'dart:html';

import 'package:flutter/material.dart';

import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'package:fancy_bar/fancy_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //const MyHomePage({Key? key}) : super(key: key);

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var images = [
      'https://images.unsplash.com/photo-1536440136628-849c177e76a1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bW92aWVzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1594909122845-11baa439b7bf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bW92aWVzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1505686994434-e3cc5abf1330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8bW92aWVzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60'
    ];

    var FilmTitle = ['Title 1', 'Title 2', 'Title 3'];

    var category = ['Action', 'Horror', 'Drama', 'History', 'Art'];

    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            /*title: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image(
                  //child: InkWell(onTap: () {}),
                  image: AssetImage('logowtitlepink.png'),
                  fit: BoxFit.cover,
                  height: 60,
                  width: 100,
                ),
              ),
            ),*/
            title: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Center(
                child: TabBar(
                  isScrollable: true,
                  //labelPadding: EdgeInsets.only(left: 20, right: 20),
                  indicatorColor: const Color(0xFF6C53EF),
                  indicatorWeight: 4,
                  //indicator: CircleTabIndicator(color: Colors.black, radius: 2),
                  indicator: DotIndicator(
                    distanceFromCenter: 16,
                    radius: 3,
                    color: const Color(0xFF6C53EF),
                    paintingStyle: PaintingStyle.fill,
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor:
                      const Color.fromARGB(255, 201, 198, 198),
                  tabs: [
                    const Tab(
                      text: 'In Cinema',
                    ),
                    const Tab(
                      text: 'Box office',
                    ),
                    const Tab(
                      text: 'Coming Soon',
                    )
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            /*
            leading: IconButton(
              icon: Image.asset('menu-2-line.png'),
              onPressed: () {},
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 104, 104, 104),
                ),
                onPressed: () {},
              ),
            ],*/
          ),
          body: Column(
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 201, 198, 198)),
                                  color: Colors.transparent),
                              child: Center(child: Text(category[i])),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text("Favorites",
                      style: TextStyle(fontSize: 18, fontFamily: 'Comfortaa')),
                ),
              ),
              SizedBox(height: 5),
              Flexible(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: images.length,
                    itemBuilder: (context, i) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 60,
                            child: Card(
                                margin: const EdgeInsets.all(8.0),
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Stack(
                                    //padding: EdgeInsets.all(80),
                                    alignment: Alignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Image(
                                          //child: InkWell(onTap: () {}),
                                          image: NetworkImage(images[i]),
                                          fit: BoxFit.cover,
                                          height: 240,
                                          width: 150,
                                        ),
                                      )
                                    ])),
                          ),
                          //SizedBox(height: 20),
                          Expanded(
                            flex: 10,
                            child: Text(
                              FilmTitle[i],
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      );
                    }),
              ),
              SizedBox(height: size.height / 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Text("Latest",
                      style: TextStyle(fontSize: 18, fontFamily: 'Comfortaa')),
                ),
              ),
              SizedBox(height: 5),
              Flexible(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: images.length,
                    itemBuilder: (context, i) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 60,
                            child: Card(
                                margin: const EdgeInsets.all(8.0),
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Stack(
                                    //padding: EdgeInsets.all(80),
                                    alignment: Alignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Image(
                                          //child: InkWell(onTap: () {}),
                                          image: NetworkImage(images[i]),
                                          fit: BoxFit.cover,
                                          height: 240,
                                          width: 150,
                                        ),
                                      )
                                    ])),
                          ),
                          //SizedBox(height: 20),
                          Expanded(
                            flex: 10,
                            child: Text(
                              FilmTitle[i],
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      );
                    }),
              ),
            ],
          ),
          bottomNavigationBar: FancyBottomBar(
            type: FancyType.FancyV1,
            items: [
              FancyItem(
                textColor: const Color(0xFF6C53EF),
                title: 'Home',
                icon: const Icon(Icons.home),
              ),
              FancyItem(
                textColor: const Color(0xFF6C53EF),
                title: 'Trending',
                icon: const Icon(Icons.trending_up),
              ),
              FancyItem(
                textColor: const Color(0xFF6C53EF),
                title: 'Search',
                icon: const Icon(Icons.search),
              ),
              FancyItem(
                textColor: const Color(0xFF6C53EF),
                title: 'profile',
                icon: const Icon(Icons.account_circle),
              ),
            ],
            onItemSelected: (index) {
              print(index);
            },
          ),
        ),
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