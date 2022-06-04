

import 'package:flutter/material.dart';

import 'LoginPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('splashscreen.jpg'), fit: BoxFit.fill)),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(height: size.height / 2.5),
            Container(
              height: size.height / 5,
              width: size.height / 5,
              child: Image(image: AssetImage('logowtitle.png')),
            ),
            SizedBox(
              height: size.height / 3.2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width / 10),
              child: Container(
                //width: size.height / 2,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => LoginPage()),
                    ));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFF6C53EF),
                            Color.fromARGB(159, 108, 83, 239)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.7, 1]),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Container(
                      constraints: const BoxConstraints(
                          minWidth: 88.0,
                          minHeight: 36.0), // min sizes for Material buttons
                      alignment: Alignment.center,
                      child: const Text(
                        "Let's Get Started",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
