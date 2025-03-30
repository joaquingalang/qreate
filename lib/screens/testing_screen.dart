import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qreate/widgets/progress_indicators/loading_icon.dart';

class TestingScreen extends StatefulWidget {
  const TestingScreen({super.key});

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  late QrCode qrCode;

  late QrImage qrImage;

  @override
  void initState() {
    super.initState();
    QrCode qrCode = QrCode.fromData(
      data: 'www.wikipedia.com',
      errorCorrectLevel: QrErrorCorrectLevel.H,
    );
    qrImage = QrImage(qrCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.scale(
          scale: 0.5,
          child: PrettyQrView(
            qrImage: qrImage,
            decoration: const PrettyQrDecoration(
              image: PrettyQrDecorationImage(image: AssetImage('assets/images/icons/facebook_icon.png'))
            ),
          ),
        ),
      ),
    );
  }
}
