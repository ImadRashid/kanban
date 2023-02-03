import 'package:flutter/material.dart';
import 'package:karbanboard/screen/home_screen.dart';
import 'package:karbanboard/screen/multi_board_list.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  splashScreenDelay() async {
    await Future.delayed(Duration(seconds: 3));

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>

                // BoardViewExample()

                MultiBoardListExample()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreenDelay();
  }

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
