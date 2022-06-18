import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:imdb_app/LoginPage.dart';
import 'package:imdb_app/model/UserModel.dart';

class RegisterPage extends StatefulWidget {
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
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  // form Key
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final emailValidator = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final passValidator =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final cPassController = TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: double.infinity,
        child: Stack(
          //alignment: Alignment.center,
          children: [
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
                    'SignUp',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Comfortaa',
                        fontSize: 20),
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
                                controller: nameController,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      size: 20,
                                    ),
                                    prefixIconColor: Color(0xFF6C53EF),
                                    border: InputBorder.none,
                                    labelText: 'Name',
                                    hintText: 'Enter your Name'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your email";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                onSaved: (value) {
                                  nameController.text = value!;
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
                                controller: lastNameController,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      size: 20,
                                    ),
                                    prefixIconColor: Color(0xFF6C53EF),
                                    border: InputBorder.none,
                                    labelText: 'Last Name',
                                    hintText: 'Enter Last Name'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your email";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                onSaved: (value) {
                                  lastNameController.text = value!;
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
                                  if (!passValidator.hasMatch(value)) {
                                    return 'Your Password must contain at least one upper case,'
                                        'one lower case,one digit,one Special character and'
                                        '8 characters in length  ';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  passController.text = value!;
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
                                controller: cPassController,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.password,
                                      size: 20,
                                    ),
                                    prefixIconColor: Color(0xFF6C53EF),
                                    border: InputBorder.none,
                                    labelText: 'Confirm Password',
                                    hintText: '**********'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your password";
                                  }
                                  if (!passValidator.hasMatch(value)) {
                                    return 'Your Password must contain at least one upper case,'
                                        'one lower case,one digit,one Special character and '
                                        '8 characters in length  ';
                                  }
                                  if (passController.text != value) {
                                    return "Passwords don't Match";
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
                        signUp(emailController.text.trim(),
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
                            "SignUp",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.width * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account ? '),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: const Text(
                          'SignIn',
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
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFireStore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: 'Error While Signing Up');
      });
    }
  }

  postDetailsToFireStore() async {
    // call FireStore, and user model, save them after
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    //copying values to the model

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = nameController.text.trim();
    userModel.lastName = lastNameController.text.trim();

    await firebaseFirestore
        .collection("Users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: 'Account created Successfully');
    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }
}
