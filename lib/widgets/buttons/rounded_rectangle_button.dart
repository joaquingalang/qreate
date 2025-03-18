import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';

class RoundedRectangleButton extends StatelessWidget {
  const RoundedRectangleButton({
    super.key,
    required this.title,
    this.borderRadius,
    required this.onPressed,
  });

  final String title;
  final BorderRadius? borderRadius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                kBlueColor500,
                kBlueColor400,
              ],
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: kSubtext20.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}