import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// [Function] that shows a [SnackBar] for internet connection. It accepts:
/// - [isOnline] - [boolean] flag to lets us know if we have stable connection
///
/// and returns the corresponding snackbar.
void showInternetConnectionSnackBar({required bool isOnline}) {
  Get.closeAllSnackbars();
  Get.showSnackbar(
    GetSnackBar(
      icon: Icon(
        isOnline ? Icons.wifi : Icons.wifi_off_rounded,
        // color: isOnline ? successColor30 : dangerColor10,
      ),
      message: isOnline ? "internet_restored".tr : "no_internet_connection".tr,
      // backgroundColor: isOnline ? successColor30 : greyColor100,
      duration: Duration(seconds: 2),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      borderRadius: 8,
      snackPosition: SnackPosition.TOP,
    ),
  );
}

/// [Function] that shows custom [SnackBar] for any kind of message. This function aceepts:
/// - [title] of type [String]
/// - [textColor] of type [Color]
/// - [duration] of type [Duration]
void showCustomSnackBar(
  String title,
  String message, {
  Duration duration = const Duration(seconds: 3),
  Color textColor = Colors.white,
}) {
  Get.closeAllSnackbars();
  Get.snackbar(
    title.tr,
    message.tr,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.black,
    colorText: textColor,
    borderRadius: 0,
    margin: EdgeInsets.zero,
    duration: duration, //default is 3 secs
  );
}
