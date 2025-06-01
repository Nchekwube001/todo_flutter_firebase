import 'package:flutter/material.dart';
import 'package:flutter_todo/utils/app_styles.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {super.key,
      required this.hintText,
      required this.textInputType,
      required this.controller,
      this.obscureText});
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppStyles.normalTextStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20)),
    );
  }
}
