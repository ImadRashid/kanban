import 'package:flutter/material.dart';
import 'package:karbanboard/screen/splash_screen.dart';

void main() {
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

      // MultiBoardListExample(),

      //  Scaffold(
      //     appBar: AppBar(
      //       title: const Text('AppFlowy Board'),
      //     ),
      //     body: Container(color: Colors.white, child: _examples[_currentIndex]),
      //     bottomNavigationBar: BottomNavigationBar(
      //       fixedColor: _bottomNavigationColor,
      //       showSelectedLabels: true,
      //       showUnselectedLabels: false,
      //       currentIndex: _currentIndex,
      //       items: [
      //         BottomNavigationBarItem(
      //             icon: Icon(Icons.grid_on, color: _bottomNavigationColor),
      //             label: "MultiColumn"),
      //         BottomNavigationBarItem(
      //             icon: Icon(Icons.grid_on, color: _bottomNavigationColor),
      //             label: "SingleColumn"),
      //       ],
      //       onTap: (int index) {
      //         setState(() {
      //           _currentIndex = index;
      //         });
      //       },
      //     )),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: SplashScreen(),
//     );
//   }
// }
