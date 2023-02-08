import 'package:flutter/material.dart';
import 'package:karbanboard/core/others/base_view_model.dart';
import '../../core/enums/view_state.dart';
import '../../core/services/auth_services.dart';
import '../../core/services/database_services.dart';
import '../../locator.dart';

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
    try {
      setState(ViewState.busy);
      if (formKey.currentState!.validate()) {
        await _authService.loginUser(
          emailController.text,
          passwordController.text,
        );
      }
    } catch (e) {
      print("$e, login error");
    }
    setState(ViewState.idle);
  }

  ///
  /// Register user
  ///
  registerUser() async {
    try {
      if (formKey.currentState!.validate()) {
        setState(ViewState.busy);
        await _authService.registerUser(
          emailController.text,
          passwordController.text,
          nameController.text,
        );

        // setState(ViewState.idle);
      }
    } catch (e) {
      print("register Error: $e");
    }
    setState(ViewState.idle);
  }

  termsAndConditions(value) {
    isAgreeTermsAndConditions = value;
    print("Terms and conditions $isAgreeTermsAndConditions");
    notifyListeners();
  }
}
