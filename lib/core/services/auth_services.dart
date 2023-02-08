import 'package:firebase_auth/firebase_auth.dart';

import '../model/app_user.dart';
import 'database_services.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _databaseServices = DatabaseService();

  User? firebaseUser;
  // Stream get userStream => _auth.authStateChanges();

  bool? isLogin;

  AppUser appUser = AppUser();
  AuthServices() {
    init();
  }

  init() async {
    firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      isLogin = true;
      appUser = await _databaseServices.getUser(firebaseUser!.uid);
    } else {
      isLogin = false;
    }
  }
}
