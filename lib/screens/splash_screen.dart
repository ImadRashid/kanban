import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karbanboard/screens/kanban_board.dart';
import 'package:karbanboard/screens/no_internet_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/services/auth_services.dart';
import '../core/services/internet_connectivity_service.dart';
import '../locator.dart';
import 'auth/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// A [boolean] that acts as flag to handle onBoarding Screens.
  bool? onBoarding = false;

  final _internetService = locator<InternetConnectivityService>();
  final _authServices = locator<AuthService>();
  @override
  void initState() {
    super.initState();
    // calls load preferences
    loadPrefs();
    // calls delay function
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      delay();
    });
  }

  /// [Function] that navigates [User] to specific page on the basis
  /// of:
  /// - [User] is logged in and [User]'s ID is created navigate to
  /// [KanbanBoard]
  /// - [User] is logged in and [User]'s ID is not created navigate
  /// to [CreateIdScreen]
  /// - [User] has already onboarded than navigate to [LoginScreen]
  /// - [User] has not onboarded than navigate to [OnBoardingScreen]
  delay() async {
    _internetService.init();
    if (await _internetService.checkConnection()) {
      Get.offAll(() => NoInternetScreen());
    } else {
      // / [AuthServices] object that handles [User]'s authentications

      await _authServices.init();
      //await Future.delayed(Duration(seconds: 3));
      // check user is logged in and has created ID screen
      if (_authServices.isLogin) {
        // Navigate to Kanban Board
        Get.offAll(const KanbanBoard());
      } else {
        //check user has onboarding

        Get.offAll(() => LoginScreen());
      }
    }
  }

  /// [Function] that initializes [SharedPreferences] and checks
  /// onboarding in local storage.
  loadPrefs() async {
    // initialize shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // fetch and save onboarding from local
    onBoarding = prefs.getBool("onBoarding");
    print("onBoarding = $onBoarding");
  }

  // splashScreenDelay() async {
  //   await Future.delayed(const Duration(seconds: 3));

  //   Get.offAll(const KanbanBoard());
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   splashScreenDelay();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Center(child: Text("SplashScreen"))],
      ),
    );
  }
}
