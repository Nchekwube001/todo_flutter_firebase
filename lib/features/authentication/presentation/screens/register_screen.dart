import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/common_widgets/async_value_ui.dart';
import 'package:flutter_todo/features/authentication/controllers/auth_controller.dart';
import 'package:flutter_todo/features/authentication/presentation/widgets/common_text_field.dart';
import 'package:flutter_todo/routes/routes.dart';
import 'package:flutter_todo/utils/app_styles.dart';
import 'package:flutter_todo/utils/size_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

//  match /{document=**}
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  bool isChecked = false;
  // Controllers for the text fields
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  void validateDetails() {
    String email = _emailEditingController.text;
    String password = _passwordEditingController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email and Password cannot be empty")),
      );
      return;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid email address")),
      );
      return;
    } else if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password must be at least 6 characters long")),
      );
      return;
    } else {
      // If validation passes, navigate to the main screen
      ref.read(authControllerProvider.notifier).createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
      // context.goNamed(AppRoutes.main.name);
    }
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);

    SizeConfig.init(context);
    ref.listen(
      authControllerProvider,
      (previous, next) {
        next.showAlertDialogOnError(context);
      },
    );
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
                  "Create An Account 🥳",
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
                    validateDetails();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: SizeConfig.getProportionateHeight(50),
                    width: SizeConfig.deviceWidth,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: state.isLoading
                        ? const CircularProgressIndicator()
                        : Text('Register',
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
                    Text("Already have an account? ",
                        style: AppStyles.normalTextStyle),
                    GestureDetector(
                      onTap: () {
                        context.goNamed(AppRoutes.signIn.name);
                      },
                      child: Text("Login",
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
