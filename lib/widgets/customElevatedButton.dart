import 'package:flutter/material.dart';
import 'package:shop_udemy/shared/style/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function onPressed;
  final double width;
  final double height;
  final String text;


  CustomElevatedButton({
    this.onPressed,
    this.width,
    this.height,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: defaultColor,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: Size(width, height),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
