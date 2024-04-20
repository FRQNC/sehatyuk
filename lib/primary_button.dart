import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {

  final double containerWidth;
  final VoidCallback onPressed;
  final String buttonText;
  final double fontSize;

  PrimaryButton({required this.containerWidth, required this.onPressed, required this.buttonText, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
