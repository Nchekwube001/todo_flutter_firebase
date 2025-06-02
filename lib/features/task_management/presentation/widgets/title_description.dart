import 'package:flutter/material.dart';
import 'package:flutter_todo/utils/app_styles.dart';
import 'package:flutter_todo/utils/size_config.dart';

class TitleDescription extends StatelessWidget {
  const TitleDescription(
      {super.key,
      required this.title,
      required this.prefixIcon,
      required this.hintText,
      required this.maxLines,
      required this.controller});
  final String title;
  final IconData prefixIcon;
  final String hintText;
  final int maxLines;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppStyles.headingTextStyle.copyWith(fontSize: 18)),
        SizedBox(height: SizeConfig.getProportionateHeight(10)),
        TextFormField(
          controller: controller,
          minLines: 1,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon, color: Colors.grey),
            hintText: hintText,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
      ],
    );
  }
}
