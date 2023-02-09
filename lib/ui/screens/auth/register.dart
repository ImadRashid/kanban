import 'package:flutter/material.dart';
import 'package:karbanboard/ui/screens/auth/auth_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../core/enums/view_state.dart';
import '../../custom_widgets/custom_page_route.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../custom_widgets/password_textfield.dart';
import '../../custom_widgets/rectangular_button.dart';
import 'login.dart';

class SignUpScreen extends StatelessWidget {
  final fullNameNode = FocusNode();
  final emailNode = FocusNode();
  final passwordNode = FocusNode();
  final confirmPasswordNode = FocusNode();
  final checkBoxNode = FocusNode();

  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder: (context, model, child) {
          return Scaffold(
            body: ModalProgressHUD(
              progressIndicator: const CircularProgressIndicator(
                color: Color(0xFF568C48),
              ),
              inAsyncCall: model.state == ViewState.busy,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
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
                              height: 20,
                            ),

                            ///
                            /// Full name
                            ///
                            const SizedBox(
                              height: 40,
                            ),
                            const Text("Full Name"),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              controller: model.nameController,
                              hintText: "Full Name",
                              textInputAction: TextInputAction.next,
                              keyBoardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Name can't be empty";
                                }
                              },
                              preFixIcon: Icons.person,
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            ///
                            /// user email address
                            ///
                            const Text("Email"),
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
                                  return "Email can't be empty";
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
                            const Text("Password"),
                            const SizedBox(
                              height: 5,
                            ),
                            PasswordTextField(
                              controller: model.passwordController,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(confirmPasswordNode);
                              },
                              focusNode: passwordNode,
                              hintText: 'Password',
                              obscureText: model.isVisiblePassword,
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
                              textInputAction: TextInputAction.next,
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
                              height: 20,
                            ),

                            ///
                            /// confirm password text field
                            ///
                            const Text("Confirm Password"),
                            const SizedBox(
                              height: 5,
                            ),
                            PasswordTextField(
                              controller: confirmPasswordController,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(checkBoxNode);
                              },
                              focusNode: confirmPasswordNode,
                              hintText: "Confirm Password",
                              obscureText: model.isVisiblePassword,
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
                              textInputAction: TextInputAction.done,
                              keyBoardType: TextInputType.visiblePassword,
                              validator: (v) {
                                if (model.passwordController.text !=
                                    confirmPasswordController.text) {
                                  return "Passwords do not match";
                                }
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),

                            ///
                            /// Radio button
                            ///
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: ListTile(
                                    horizontalTitleGap: 0.0,
                                    contentPadding: EdgeInsets.zero,
                                    leading: Checkbox(
                                      focusNode: checkBoxNode,
                                      value: model.isAgreeTermsAndConditions,
                                      onChanged: (newValue) {
                                        print(newValue);
                                        model.termsAndConditions(newValue);
                                      },
                                      // activeColor: primaryColor,
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "By signing up you must agree to our"),
                                        InkWell(
                                          splashColor: Colors.grey,
                                          onTap: () {},
                                          child: Text(
                                            "Terms and Conditions",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Text('By signing up you must agree to our Terms and Conditions',),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),

                            ///
                            /// Sign in button
                            ///
                            RectangularButton(
                              title: 'Sign Up',
                              onPressed: () => model.registerUser(),
                            ),
                            const SizedBox(
                              height: 28,
                            ),

                            ///
                            /// have an account?  sign in option
                            ///
                            GestureDetector(
                              onTap: () => Navigator.pushReplacement(
                                context,
                                CustomPageRoute(
                                  child: LoginScreen(),
                                ),
                              ),
                              // onTap: ()=>Get.offAll(()=>LoginScreen()),
                              child: RichText(
                                text: TextSpan(
                                  text: "Have an account? ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 13,
                                      ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Sign In",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
