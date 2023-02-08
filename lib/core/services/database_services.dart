import '../model/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final _ref = FirebaseFirestore.instance;
  registerUser(AppUser appUser) async {
    try {
      await _ref.collection("users").doc(appUser.userId).set(appUser.toJson());
    } catch (e) {
      print('Exception@registerUser ===> $e');
    }
  }

  Future<AppUser> getUser(String id) async {
    try {
      final snapshot = await _ref.collection("users").doc(id).get();
      return AppUser.fromJson(snapshot.data(), snapshot.id);
    } catch (e) {
      print('Exception@getUser ===> $e');
      print(
          "Seems like a new user is registering, We are auto trying to register new user");
      return AppUser();
    }
  }

  ///
  /// add JIRA Card Issue Function - to be done
  ///
  // addUserProblem(UserProblem userProblem) async {
  //   try {
  //     await _ref
  //         .collection("UserProblem")
  //         // .doc(userProblem.helpeeId)
  //         .doc(userProblem.problemId)
  //         .set(userProblem.toJson());
  //     return true;
  //   } catch (e) {
  //     print('Exception@userProblem ===> $e');
  //     return false;
  //   }
  // }
}
