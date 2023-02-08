import 'package:flutter/material.dart';

class RestartApp extends StatefulWidget {
  RestartApp({Key? key, required this.child}) : super(key: key);
  final Widget child;

  static void restartApp(BuildContext ctx) {
    ctx.findAncestorStateOfType<_RestartAppState>()!.restartApp();
  }

  @override
  State<RestartApp> createState() => _RestartAppState();
}

class _RestartAppState extends State<RestartApp> {
  Key _key = UniqueKey();

  void restartApp() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: _key, child: widget.child);
  }
}
