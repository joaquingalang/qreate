import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';

class QreateTextField extends StatelessWidget {
  const QreateTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.hintText,
  });

  final TextEditingController controller;
  final Function(String)? onChanged;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: kSubtext20,
      cursorColor: kBlueColor400,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: kSubtext20.copyWith(color: Colors.grey.shade600),
          filled: true,
          fillColor: kGrayColor200,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kBlueColor400,
              width: 1,
            ),
          )
      ),
      onChanged: onChanged,
    );
  }
}
