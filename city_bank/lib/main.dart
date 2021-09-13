import 'package:city_bank/model/superUser.dart';
import 'package:city_bank/screens/wrapper.dart';
import 'package:city_bank/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<SuperUser?>.value(
        value: _auth.superUser,
        initialData: null,
        child: MaterialApp(
          home: Wrapper(),
        ));
  }
}
