import 'package:flutter/material.dart';
import 'package:qreate/screens/results_screen.dart';
import 'package:qreate/screens/testing_screen.dart';
import 'package:qreate/screens/sign_in_screen.dart';
import 'package:qreate/screens/sign_up_screen.dart';
import 'package:qreate/screens/auth_screen.dart';
import 'package:qreate/screens/dashboard_screen.dart';
import 'package:qreate/screens/create_qr_screen.dart';
import 'package:qreate/screens/qr_screen.dart';

void main() {
  runApp(Qreate());
}

class Qreate extends StatelessWidget {
  const Qreate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreateQrScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
