import 'package:city_bank/screens/loading.dart';
import 'package:city_bank/services/auth.dart';
import 'package:city_bank/shared/constants.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  VoidCallback changeSurFaces;
  Register({Key? key, required this.changeSurFaces}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: Text(
                'Register For City Bank',
                style: appBarTextStyle.copyWith(fontSize: 20.0),
              ),
              elevation: 0.0,
              actions: [
                TextButton.icon(
                    onPressed: widget.changeSurFaces,
                    icon: Icon(Icons.person),
                    label: Text(
                      'Login',
                      style: appBarTextStyle,
                    ),
                    style: appBarButtonStyle)
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/coffee_bg.png'),
                      fit: BoxFit.cover)),
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30.0),
                      TextFormField(
                        decoration: inputDecoration.copyWith(hintText: 'Email'),
                        validator: (value) =>
                            value!.isEmpty ? 'Please Enter an Email' : null,
                        onChanged: (value) => email = value,
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: true,
                        decoration:
                            inputDecoration.copyWith(hintText: 'PassWord'),
                        validator: (value) => value!.length < 6
                            ? 'Please Enter 6+ PassWord'
                            : null,
                        onChanged: (value) => password = value,
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        error,
                        style: appBarTextStyle.copyWith(color: Colors.red),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => isLoading = true);
                            dynamic user = await _auth
                                .signUpWithEmailAndPassword(email, password);
                            if (user == null) {
                              setState(() {
                                isLoading = false;
                                error =
                                    'Could Not Register With Those Credential';
                              });
                            }
                          }
                        },
                        icon: Icon(Icons.login),
                        label: Text('Reigister'),
                        style: elevatedButtonStyle,
                      )
                    ],
                  )),
            ),
          );
  }
}
