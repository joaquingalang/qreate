import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';
import 'package:qreate/utils/logos.dart';

class LogoButton extends StatelessWidget {
  const LogoButton({
    super.key,
    this.logo = Logos.none,
    this.isSelected = false,
    required this.onPressed,
  });

  final Logos logo;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kGrayColor200,
          borderRadius: BorderRadius.circular(90),
          border: Border.all(
            width: 2,
            color: (isSelected) ? kBlueColor300 : Colors.transparent,
          ),
        ),
        child: Center(
          child: logoData[logo],
        ),
      ),
    );
  }
}