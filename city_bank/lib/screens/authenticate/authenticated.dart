import 'package:city_bank/screens/authenticate/register.dart';
import 'package:city_bank/screens/authenticate/signIn.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void switchAnotherSurFaces() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? SignIn(changeSurFaces: switchAnotherSurFaces)
        : Register(changeSurFaces: switchAnotherSurFaces);
  }
}
