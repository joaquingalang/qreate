import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField({
    super.key,
    required this.onSaved,
    this.hintText,
    this.obscureText = false,
  });

  final Function(String?) onSaved;
  final String? hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      style: kSubtext20,
      cursorColor: kBlueColor400,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: kSubtext20.copyWith(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
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
    );
  }
}