import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:karbanboard/screens/splash_screen.dart';
import 'firebase_options.dart';

// ...

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // int _currentIndex = 0;
  // final _bottomNavigationColor = Colors.blue;

  // final List<Widget> _examples = [
  //   const MultiBoardListExample(),
  //   const SingleBoardListExample(),
  // ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
