import 'package:flutter/material.dart';
import 'package:qreate/services/auth/auth_manager.dart';
import 'package:qreate/utils/constants.dart';

class QreateAppBar extends StatelessWidget {
  const QreateAppBar({
    super.key,
    required this.context,
    required this.title,
  });

  final String title;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: kSubtext20.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AuthManager(),
          ),
        ),
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }
}
