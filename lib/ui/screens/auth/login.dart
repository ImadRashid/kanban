import 'package:flutter/material.dart';
import 'package:karbanboard/ui/screens/auth/auth_provider.dart';
import 'package:karbanboard/ui/screens/auth/register.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../core/enums/view_state.dart';
import '../../custom_widgets/custom_page_route.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../custom_widgets/password_textfield.dart';
import '../../custom_widgets/rectangular_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Scaffold(
        body: Consumer<AuthProvider>(
          builder: (context, model, child) {
            return ModalProgressHUD(
              progressIndicator: const CircularProgressIndicator(),
              inAsyncCall: model.state == ViewState.busy,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 43.0,
                      vertical: 20,
                    ),
                    child: Center(
                      child: Form(
                        key: model.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///
                            /// Logo
                            ///

                            const SizedBox(
                              height: 40,
                            ),

                            Text(
                              "Welcome",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                              // TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Continue to sign in!",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.normal),
                            ),

                            ///
                            /// email text field
                            ///
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Email",
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              controller: model.emailController,
                              hintText: "Email Address",
                              textInputAction: TextInputAction.next,
                              keyBoardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your email';
                                }
                                if (!value.contains("@")) {
                                  return "Enter valid email";
                                }
                              },
                              preFixIcon: Icons.email,
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            ///
                            /// password text field
                            ///
                            const Text(
                              "Password",
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            PasswordTextField(
                              controller: model.passwordController,
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  model.visiblePassword();
                                },
                                icon: model.isVisiblePassword
                                    ? const Icon(
                                        Icons.visibility_off,
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                      ),
                              ),
                              obscureText: model.isVisiblePassword,
                              textInputAction: TextInputAction.done,
                              keyBoardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password can't be empty";
                                }
                                if (value.length < 6) {
                                  return "Password length must be 6 characters";
                                }
                              },
                            ),
                            const SizedBox(
                              height: 11,
                            ),

                            ///
                            /// Sign in button
                            ///
                            RectangularButton(
                              title: 'Sign In',
                              onPressed: () => model.loginUser(),
                            ),
                            const SizedBox(
                              height: 28,
                            ),

                            ///
                            /// Don't have an account?  sign up option
                            ///
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(context,
                                    CustomPageRoute(child: SignUpScreen()));
                              },
                              // onTap: () => Get.offAll(() => SignUpScreen()),
                              child: RichText(
                                text: TextSpan(
                                    text: "Don't have an account?  ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(fontSize: 14),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Sign Up",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      )
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
