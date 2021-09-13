import 'package:city_bank/model/superUser.dart';
import 'package:city_bank/screens/authenticate/authenticated.dart';
import 'package:city_bank/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SuperUser?>(context);
    return user == null
        ? Authenticate()
        : Home(
            user: user,
          );
  }
}
