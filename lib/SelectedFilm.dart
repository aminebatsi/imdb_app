import 'package:flutter/material.dart';


class SelectedFilm extends StatefulWidget {
  //const ({Key? key}) : super(key: key);

  @override
  State<SelectedFilm> createState() => _SelectedFilmState();
}

class _SelectedFilmState extends State<SelectedFilm> {
  @override
  Widget build(BuildContext context) {
    var react = MediaQuery.of(context).size.width - 50;
    var images = [
      'https://images.unsplash.com/photo-1536440136628-849c177e76a1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bW92aWVzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1594909122845-11baa439b7bf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bW92aWVzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1505686994434-e3cc5abf1330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8bW92aWVzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60'
    ];
    List<String> category = ['Action', 'Horror', 'Romance'];
    return ListView(children: <Widget>[
      Stack(children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(images[0]),
                  alignment: const Alignment(-.2, 0),
                  fit: BoxFit.cover),
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(80))),
        ),
        Positioned(
            right: 0,
            top: 200,
            child: Container(
              height: 50,
              width: react,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    //background color of box
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 40.0, // soften the shadow
                      spreadRadius: 2.0, //extend the shadow
                      offset: Offset(
                        15.0, // Move to right 10  horizontally
                        15.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0))),
            )),
      ]),
      const SizedBox(
        height: 25,
      ),
      Row(
        children: [
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text("Film Title",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        decoration: TextDecoration.none)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text("mini description",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        decoration: TextDecoration.none)),
              ),
            ],
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.all(5),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(primary: Colors.redAccent),
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
                            padding: const EdgeInsets.only(top: 20, left: 20),
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
      Column(children: const [
        Padding(
            padding: EdgeInsets.only(left: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Plot',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.left,
                ))),
        Padding(
            padding: EdgeInsets.only(left: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet lacus eros. Pellentesque eu urna in augue efficitur elementum vel vel felis. Fusce sit amet turpis eget dolor feugiat dignissim. Ut id odio malesuada turpis interdum gravida varius id lorem. Duis semper rutrum elit sed mattis. Aliquam orci urna, tincidunt ac dapibus non, tempus nec risus. Nunc feugiat ligula id semper volutpat. Aliquam eu aliquam enim, eget egestas quam. Vestibulum nec mi massa. Praesent sapien metus, efficitur eget euismod nec, euismod et libero. Cras elit lectus, faucibus et nibh suscipit, ullamcorper blandit lorem. Pellentesque hendrerit hendrerit placerat. Nam pretium purus at turpis dictum,'
                  ' vel venenatis dui elementum. Fusce vitae urna nisi. Quisque ornare quis nulla ut elementum. Nam eget dapibus mauris, sed rhoncus nibh.',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      decoration: TextDecoration.none),
                )))
      ])
    ]);
  }
}
