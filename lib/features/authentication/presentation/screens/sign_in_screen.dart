import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/features/authentication/presentation/widgets/common_text_field.dart';
import 'package:flutter_todo/routes/routes.dart';
import 'package:flutter_todo/utils/app_styles.dart';
import 'package:flutter_todo/utils/size_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  bool isChecked = false;
  // Controllers for the text fields
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            SizeConfig.getProportionateWidth(10),
            SizeConfig.getProportionateHeight(50),
            SizeConfig.getProportionateWidth(10),
            SizeConfig.getProportionateHeight(10),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Sign In To Your Account 👋",
                  style: AppStyles.titleTextStyle,
                ),
                SizedBox(
                  height: SizeConfig.getProportionateHeight(25),
                ),
                CommonTextField(
                    hintText: "Enter Your Email Address",
                    textInputType: TextInputType.emailAddress,
                    controller: _emailEditingController),
                SizedBox(
                  height: SizeConfig.getProportionateHeight(20),
                ),
                CommonTextField(
                  hintText: "Enter Your Password",
                  textInputType: TextInputType.visiblePassword,
                  controller: _passwordEditingController,
                  obscureText: true,
                ),
                Row(
                  children: [
                    Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        }),
                    Text("I agree to the terms and privacy policy",
                        style: AppStyles.normalTextStyle),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.getProportionateHeight(20),
                ),
                InkWell(
                  onTap: () {
                    // Handle sign-in logic here
                    // For example, you can call a sign-in function with the email and password
                    String email = _emailEditingController.text;
                    String password = _passwordEditingController.text;
                    // Implement your sign-in logic here
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: SizeConfig.getProportionateHeight(50),
                    width: SizeConfig.deviceWidth,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Sign In',
                        style: AppStyles.normalTextStyle
                            .copyWith(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.getProportionateHeight(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: SizeConfig.getProportionateHeight(1),
                      width: SizeConfig.deviceWidth * 0.4,
                      decoration: const BoxDecoration(color: Colors.grey),
                    ),
                    Text("  OR  ", style: AppStyles.normalTextStyle),
                    Container(
                      height: SizeConfig.getProportionateHeight(1),
                      width: SizeConfig.deviceWidth * 0.4,
                      decoration: const BoxDecoration(color: Colors.grey),
                    )
                  ],
                ),
                SizedBox(
                  height: SizeConfig.getProportionateHeight(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: SizeConfig.getProportionateHeight(40),
                      width: SizeConfig.deviceWidth * .25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                              style: BorderStyle.solid)),
                      child: const FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      height: SizeConfig.getProportionateHeight(40),
                      width: SizeConfig.deviceWidth * .25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                              style: BorderStyle.solid)),
                      child: const FaIcon(
                        FontAwesomeIcons.apple,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      height: SizeConfig.getProportionateHeight(40),
                      width: SizeConfig.deviceWidth * .25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                              style: BorderStyle.solid)),
                      child: const FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: SizeConfig.getProportionateHeight(40),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ",
                        style: AppStyles.normalTextStyle),
                    GestureDetector(
                      onTap: () {
                        context.goNamed(AppRoutes.register.name);
                      },
                      child: Text("Register",
                          style: AppStyles.normalTextStyle.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
