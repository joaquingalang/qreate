import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:qreate/services/connectivity/connectivity_service.dart';
import 'package:qreate/utils/constants.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:qreate/widgets/buttons/color_picker_button.dart';

class TestingScreen extends StatefulWidget {
  const TestingScreen({super.key});

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  final ConnectivityService _connectivity = ConnectivityService();

  bool? _connection;

  @override
  void initState() {
    super.initState();
    StreamSubscription subscription = _connectivity.getSubscription((List<ConnectivityResult> result) {
      setState(() {
        if (result.contains(ConnectivityResult.none)) {
          _connection = false;
        } else {
          _connection = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              color: _connection! ? Colors.green : Colors.red,
              child: Text(
                _connection!
                    ? 'Connected to internet'
                    : 'No internet connection',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                final bool isConnected =
                    await _connectivity.checkConnectivity();
                print('CONNECTION STATUS: $isConnected');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: isConnected ? Colors.green : Colors.red,
                    content: Text(
                      isConnected
                          ? 'Connected to internet'
                          : 'No internet connection',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
              child: Text('Check Connectivity'),
            ),
          ],
        ),
      ),
    );
  }
}
