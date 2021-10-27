import 'package:chat_app/helper/firebase_db.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppFireBaseAuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  /// get current user
  User? getCurrenUser() => auth.currentUser;

  /// login user
  Future<bool> login(String email, String password) async {
    try {
      return await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) => true);
    } catch (e) {
      return false;
    }
  }

  /// sign up
  Future<bool> signUp(String email, String password) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCredential.user!.updateDisplayName(
        email.replaceAll('@gmail.com', ''),
      );
      await AppFirebaseDB().addUserToDB(userCredential.user);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// sign out
  Future<bool> signOut() async {
    try {
      await auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
