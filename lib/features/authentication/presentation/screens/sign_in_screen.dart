import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/features/authentication/presentation/widgets/common_text_field.dart';
import 'package:flutter_todo/utils/app_styles.dart';
import 'package:flutter_todo/utils/size_config.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
