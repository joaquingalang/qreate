import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';
import 'package:qreate/widgets/progress_indicators/loading_icon.dart';

class TestingScreen extends StatefulWidget {
  const TestingScreen({super.key});

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  bool _isStopped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingIcon(
            isStopped: _isStopped,
            icon: Icon(
              Icons.qr_code,
              size: 100,
            ),
          ),
          SizedBox(height: 50),
          TextButton(
            onPressed: () {
              setState(() {
                _isStopped = !_isStopped;
              });
            },
            child: Text('STOP / PLAY'),
          ),
        ],
      ),
    );
  }
}
