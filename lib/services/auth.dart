import 'package:SussexFRCA/components/shared_styles.dart';
import 'package:SussexFRCA/models/user_login.dart';
import 'package:SussexFRCA/services/quiz_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var firebaseUser;

  //Create UserLogin based on user returned from User
  UserLogin _userLoginFromFirebaseUser(User? user) {
    return user != null
        ? UserLogin("", DateTime.now(), "", false, user.uid)
        : UserLogin('', DateTime.now(), '', false, "");
  }

//auth change user stream
  Stream<UserLogin> get user {
    return _auth
        .authStateChanges()
        .map((user) => _userLoginFromFirebaseUser(user));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      dynamic user = result.user ?? null;

      return _userLoginFromFirebaseUser(user);
    } catch (error) {
      print(error);
    }
  }

  // register with email
  Future registerWithEmailAndPassword(
      String firstName, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser = result.user!;
      //created a new document for the user
      await QuizDatabaseService(uid: firebaseUser.uid).updateUserData(
          firstName,
          'not_started',
          'not_started',
          'not_started',
          'not_started',
          'not_started',
          'not_started', {});
      return _userLoginFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e);
      return null;
    }
  }

  //Quiz started so update the status to say QUIZSTARTED

  //Quic complete so update the status to say QUIZCOMPLETE

  //Add a quizAnsweredItem to the User Store after each question

  //Get the individual user score at the end

  //Get the chosen answers for each question

  // Sign in
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user!;
      return _userLoginFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // register without email

  // log out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error);
    }
  }
}
