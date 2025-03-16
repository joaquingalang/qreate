import 'package:flutter/material.dart';
import 'package:qreate/screens/sign_in_screen.dart';
import 'package:qreate/screens/sign_up_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  bool _showLogin = true;

  void toggleView() {
    setState(() {
      _showLogin = !_showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_showLogin) ? SignInScreen(onTap: toggleView) : SignUpScreen(onTap: toggleView);
  }
}
