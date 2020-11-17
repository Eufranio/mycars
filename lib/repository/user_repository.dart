import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mycars/models/user.dart' as mycars_user;

class UserState {}

class UnloggedState extends UserState {
  final mycars_user.User user = mycars_user.User.empty;
  static UnloggedState singleton = UnloggedState();
}

class LoggingInState extends UserState {
  static LoggingInState singleton = LoggingInState();
}

class LoggedState extends UserState {
  final mycars_user.User user;
  LoggedState(this.user);
}

class UserRepository {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _signIn = GoogleSignIn.standard();
  UserState _currentState;

  StreamController<UserState> _internalController = StreamController.broadcast();

  Stream<UserState> get user => _internalController.stream;

  UserRepository() {
    _auth.authStateChanges().listen((firebaseUser) {
      if (firebaseUser == null) {
        _currentState = UnloggedState.singleton;
      } else {
        _currentState = LoggedState(firebaseUser.toUser);
      }
      _internalController.add(_currentState);
    });
  }

  Future<void> logInWithGoogle() async {
    _internalController.add(LoggingInState.singleton);

    try {
      final googleUser = await _signIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
    } catch (_) {
      _internalController.add(UnloggedState.singleton);
      throw Error();
    }

    _internalController.add(_auth.currentUser != null ? LoggedState(_auth.currentUser.toUser) : UnloggedState.singleton);
  }

  Future<void> logOut() async {
    await Future.wait([
      _auth.signOut(),
      _signIn.signOut(),
    ]);
  }

}

extension on User {
  mycars_user.User get toUser {
    return mycars_user.User(uid, email, displayName, photoURL);
  }
}