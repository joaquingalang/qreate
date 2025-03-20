import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';

class PatternButton extends StatelessWidget {
  const PatternButton({
    super.key,
    required this.pattern,
    this.isSelected=false,
    required this.onPressed,
  });

  final QrPattern pattern;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 64,
        height: 64,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: kGrayColor100,
          border: Border.all(
          width: (isSelected) ? 2 : 0,
          color: (isSelected) ? kBlueColor300 : Colors.transparent,
        ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Opacity(
          opacity: isSelected ? 1 : 0.6,
          child: Image(
            image: AssetImage('assets/images/patterns/${pattern.name}.png'),
          ),
        ),
      ),
    );
  }
}