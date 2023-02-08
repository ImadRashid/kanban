import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karbanboard/core/others/base_view_model.dart';
import 'package:karbanboard/ui/screens/board/kanban_board.dart';
import '../../../core/enums/view_state.dart';
import '../../../core/services/auth_services.dart';
import '../../../core/services/database_services.dart';
import '../../../locator.dart';
import '../../others/snackbars.dart';

class AuthProvider extends BaseViewModel {
  final _authService = locator<AuthService>();
  final databaseServices = DatabaseService();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isVisiblePassword = true;
  bool isRememberMe = false;
  bool isAgreeTermsAndConditions = false;

  rememberMe(value) {
    isRememberMe = value;
    notifyListeners();
  }

  ///
  /// Visible Password
  ///
  visiblePassword() {
    print("Password state : $isVisiblePassword");
    isVisiblePassword = !isVisiblePassword!;
    notifyListeners();
    print("Password final state : $isVisiblePassword");
  }

  ///
  /// Login user
  ///
  loginUser() async {
    if (formKey.currentState!.validate()) {
      try {
        setState(ViewState.busy);

        bool login = await _authService.loginUser(
          emailController.text,
          passwordController.text,
        );
        if (login) {
          Get.offAll(() => const KanbanBoard());
        }
      } catch (e) {
        print("$e, login error");
        showCustomSnackBar(
          "Error",
          "$e",
        );
      }
      setState(ViewState.idle);
    }
  }

  ///
  /// Register user
  ///
  registerUser() async {
    if (formKey.currentState!.validate()) {
      try {
        setState(ViewState.busy);
        bool login = await _authService.registerUser(
          emailController.text,
          passwordController.text,
          nameController.text,
        );
        if (login) {
          Get.offAll(() => const KanbanBoard());
        }

        // setState(ViewState.idle);
      } catch (e) {
        print("register Error: $e");
        showCustomSnackBar(
          "Error",
          "$e",
        );
      }
      setState(ViewState.idle);
    }
  }

  termsAndConditions(value) {
    isAgreeTermsAndConditions = value;
    print("Terms and conditions $isAgreeTermsAndConditions");
    notifyListeners();
  }
}
