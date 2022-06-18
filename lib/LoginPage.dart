import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:imdb_app/GrandCategories.dart';
import 'package:imdb_app/RegisterPage.dart';

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
  // form Key
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final emailValidator = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  //firebase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Stack(


          //alignment: Alignment.center,
          children: [
          Container(
            height: size.height,
          ),
            Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  "assets/background/twoelipse.png",
                  //width: size.width * 0.3,
                )),
            Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  "assets/background/twoelipsebtm.png",
                  //width: size.width * 0.3,
                )),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome To Mov.Flix',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Comfortaa',
                        fontSize: 20),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Image.asset(
                    'assets/background/backpng.png',
                    height: size.height * 0.40,
                    width: size.width * 0.9,
                  ),
                  SizedBox(height: size.height * 0.03),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.height / 10, vertical: 5),
                      child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(50, 228, 228, 228),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 5),
                              child: TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      size: 20,
                                    ),
                                    prefixIconColor: Color(0xFF6C53EF),
                                    border: InputBorder.none,
                                    labelText: 'Email',
                                    hintText: 'example@example.com'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your email";
                                  }
                                  if (!emailValidator.hasMatch(value)) {
                                    return "Email entered not valid";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (value) {
                                  emailController.text = value!;
                                },
                                textInputAction: TextInputAction.next,
                              )))),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.height / 10, vertical: 5),
                      child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(50, 228, 228, 228),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 5),
                              child: TextFormField(
                                controller: passController,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.password,
                                      size: 20,
                                    ),
                                    prefixIconColor: Color(0xFF6C53EF),
                                    border: InputBorder.none,
                                    labelText: 'Password',
                                    hintText: '**********'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your password";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  passController.text = value!;
                                },
                                textInputAction: TextInputAction.done,
                              )))),
                  SizedBox(height: size.width * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.height / 10),
                    child: ElevatedButton(
                      onPressed: () {
                        signIn(emailController.text.trim(),
                            passController.text.trim());
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(0.0))),
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
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('create an account ? '),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => RegisterPage()));

                        },
                        child: const Text(
                          'SignUp',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                          fontSize: 15),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //Login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: 'Login Successful'),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const GrandCategories()))
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: 'Email or Password not valid');
      });
    }
  }
}
