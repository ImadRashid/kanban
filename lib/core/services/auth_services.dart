import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:karbanboard/ui/screens/splash_screen.dart';
import '../model/app_user.dart';
import 'database_services.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _databaseServices = DatabaseService();
  User? firebaseUser;

  bool isLogin = false;

  AppUser appUser = AppUser();

  AuthService() {
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

  Future<bool> loginUser(String email, String password) async {
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      appUser.userId = credentials.user!.uid;
      isLogin = true;

      /// Get user
      appUser = await _databaseServices.getUser(credentials.user!.uid);
      return true;
    } catch (e) {
      throw "Could not login:\nError: $e";
    }
  }

  Future<bool> registerUser(String email, String password, String name) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      appUser.email = email;
      appUser.createdAt = DateTime.now();
      appUser.userName = name;
      appUser.userId = credential.user!.uid;
      isLogin = true;
      await _databaseServices.registerUser(appUser);
      appUser = await _databaseServices.getUser(credential.user!.uid);
      return true;
    } catch (e) {
      print('Exception@signUpUser $e');
      throw "Error Could not Register $e";
    }
  }

  void logout() async {
    try {
      await _auth.signOut();
      appUser = AppUser();
      isLogin = false;
      Get.offAll(SplashScreen());
    } catch (e) {}
  }
}
