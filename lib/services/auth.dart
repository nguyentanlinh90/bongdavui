import 'package:bongdavui/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants/app_strings.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static UserModel _userFromFirebase(User user) {
    return UserModel(uid: user.uid, email: user.email!);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      return _userFromFirebase(user!);
    } catch (e) {
      print('signInAnon' + e.toString());
      return null;
    }
  }

  //sign in with email and pass
  static Future signInWithEmailAndPassword(String email, String password,
      Function(bool isSuccess, String data) callback) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      callback(true, result.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        callback(false, AppString.userNotFound);
      } else if (e.code == 'wrong-password') {
        callback(false, AppString.wrongPassword);
      }
    } catch (e) {
      callback(false, e.toString());
    }
  }

  //Registration with email and pass
  static Future createUserWithEmailAndPassword(String email, String pass,
      Function(bool isSuccess, String data) callback) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      callback(true, result.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        callback(false, AppString.passTooWeak);
      } else if (e.code == 'email-already-in-use') {
        callback(false, AppString.emailExists);
      }
    } catch (e) {
      print('signIn error: ' + e.toString());
      callback(false, e.toString());
    }
  }

  // get user
  static User? getUser() {
    return _auth.currentUser;
  }

//sign out
  static Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
