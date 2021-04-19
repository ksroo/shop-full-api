import 'package:flutter/material.dart';
import 'package:shop_udemy/shared/style/colors.dart';

class CustomTextFromField extends StatelessWidget {
  final String labeltext;
  final TextEditingController controller;
  final Function validator;
  final Widget prefix;
  final Widget suffixIcon;

  CustomTextFromField({
    this.labeltext,
    this.controller,
    this.validator,
    this.prefix,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      
      decoration: InputDecoration(
        labelText: labeltext,
        prefix: prefix,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: defaultColor),
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: defaultColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
