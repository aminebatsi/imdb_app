import 'package:flutter/material.dart';

//Indicator widget package
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

//List package

void main() {
  runApp(const MyApp());
}

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

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
              title: Center(
                  child: Text(
                'Movies App',
                style: TextStyle(color: Color.fromARGB(255, 97, 97, 97)),
              )),
              bottom: TabBar(
                isScrollable: true,
                //labelPadding: EdgeInsets.only(left: 20, right: 20),
                indicatorColor: Colors.pink,
                indicatorWeight: 4,
                //indicator: CircleTabIndicator(color: Colors.black, radius: 2),
                indicator: MaterialIndicator(
                  color: Colors.pink,
                  height: 6,
                  topLeftRadius: 5,
                  topRightRadius: 5,
                  bottomLeftRadius: 5,
                  bottomRightRadius: 5,
                  horizontalPadding: 30,
                  tabPosition: TabPosition.bottom,
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Color.fromARGB(255, 201, 198, 198),
                tabs: [
                  Tab(
                    text: 'In Cinema',
                  ),
                  Tab(
                    text: 'Box office',
                  ),
                  Tab(
                    text: 'Coming Soon',
                  )
                ],
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
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
              ],
            ),
            body: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 20, left: 20),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.only(left: 20, right: 20),
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
                  Flexible(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: images.length,
                        itemBuilder: (context, i) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 60,
                                child: Card(
                                    margin: EdgeInsets.all(8.0),
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
                                              width: 240,
                                            ),
                                          )
                                        ])),
                              ),
                              //SizedBox(height: 20),
                              Expanded(
                                flex: 10,
                                child: Text(
                                  FilmTitle[i],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          );
                        }),
                  ),
                ],
              ),
            )),
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