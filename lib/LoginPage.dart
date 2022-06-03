

import 'package:flutter/material.dart';

import 'MyHomePage.dart';

class LoginPage extends StatefulWidget {
  //const LoginPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          //alignment: Alignment.center,
          children: [
            Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  "twoelipse.png",
                  //width: size.width * 0.3,
                )),
            Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  "twoelipsebtm.png",
                  //width: size.width * 0.3,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome To Mov.Flix',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.08),
                Image.asset(
                  'backpng.png',
                  height: size.height * 0.40,
                  width: size.width * 0.9,
                ),
                SizedBox(height: size.height * 0.06),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.height / 10, vertical: 5),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(50, 228, 228, 228),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 5),
                            child: TextFormField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      size: 20,
                                    ),
                                    prefixIconColor: Color(0xFF6C53EF),
                                    border: InputBorder.none,
                                    labelText: 'Email',
                                    hintText: 'example@example.com'))))),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.height / 10, vertical: 5),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(50, 228, 228, 228),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 5),
                            child: TextFormField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.password,
                                      size: 20,
                                    ),
                                    prefixIconColor: Color(0xFF6C53EF),
                                    border: InputBorder.none,
                                    labelText: 'Password',
                                    hintText: '**********'))))),
                SizedBox(height: size.width * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.height / 10),
                  child: Container(
                    //width: size.height / 2,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => MyHomePage()),
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
                              minHeight:
                                  36.0), // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: const Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
