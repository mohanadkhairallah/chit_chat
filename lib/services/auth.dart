import 'package:chit_chat/modules/myUser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  User loggedInUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser _userFromFirebaseUser(User user) {
    return user != null ? MyUser(email: user.email) : null;
  }

  Stream<MyUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print('error in reg');
      print(error.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
