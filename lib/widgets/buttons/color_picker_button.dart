import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';

class ColorPickerButton extends StatelessWidget {
  const ColorPickerButton({
    super.key,
    required this.title,
    this.color = Colors.white,
    required this.onPressed,
  });

  final String title;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 180,
        height: 55,
        decoration: BoxDecoration(
          color: kGrayColor100,
          border: Border.all(
              color: Colors.black
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          title: Text(title, style: kSubtext16),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(
                width: 2,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}