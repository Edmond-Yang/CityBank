import 'package:city_bank/model/superUser.dart';
import 'package:city_bank/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;

  SuperUser? _superUserFromUser(User? user) =>
      user != null ? SuperUser(uid: user.uid) : null;

  Stream<SuperUser?> get superUser =>
      _auth.authStateChanges().map(_superUserFromUser);

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential receiver = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = receiver.user!;
      return _superUserFromUser(user);
    } catch (e) {
      print(e);
      print('auth error');
      return null;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential receiver = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = receiver.user!;
      SuperUser? superUser = _superUserFromUser(user);
      print(await DataBaseServices(uid: user.uid)
          .updateData('setting', superUser!.getSettingMap()));
      return superUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future logOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
