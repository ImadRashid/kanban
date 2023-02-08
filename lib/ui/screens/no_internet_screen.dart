import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/restart_app.dart';

/// A [Screen] or [View] made of [StatelessWidget] that is only shown when there is
/// an [error] in [API] request.
class NoInternetScreen extends StatelessWidget {
  /// A [constructor] which accepts two parameters:
  /// - [error] - a value of type [integer]
  /// - [msg] - a value of type [String]
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Error Image
            // Image.asset("assets/svg_icons/no_internet.png"),
            //Error Message
            Text(
              "no_internet_connection".tr,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: MaterialButton(
          onPressed: () async {
            // reset current app state
            await Get.deleteAll(force: true);
            // restart app
            RestartApp.restartApp(Get.context!);
            // reset get state
            Get.reset();
          },
          // color: primaryColor70,
          child: Text("retry"),
          textColor: Colors.white,
        ),
      ),
    );
  }
}
