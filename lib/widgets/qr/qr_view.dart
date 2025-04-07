import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';
import 'package:qreate/utils/qr_patterns.dart';
import 'package:qreate/utils/logos.dart';
import 'package:qreate/models/qr_code.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrView extends StatelessWidget {
  const QrView({
    super.key,
    this.qrSize,
    required this.canvasColor,
    required this.source,
    required this.selectedLogo,
    required this.selectedPattern,
    this.logoUrl,
    required this.pixelColor,
  });

  final double? qrSize;
  final String source;
  final Color canvasColor;
  final Color pixelColor;
  final QrPattern selectedPattern;
  final Logos selectedLogo;
  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    print('LOGO URL $logoUrl');
    return Container(
      width: qrSize,
      padding: EdgeInsets.all(8),
      color: canvasColor,
      child: PrettyQrView.data(
        data: source,
        errorCorrectLevel: (selectedLogo == Logos.none)
            ? QrErrorCorrectLevel.L
            : QrErrorCorrectLevel.M,
        decoration: PrettyQrDecoration(
          shape: (selectedPattern == QrPattern.circles)
              ? PrettyQrRoundedSymbol(
            color: pixelColor,
          )
              : PrettyQrSmoothSymbol(
            color: pixelColor,
          ),
          image: (selectedLogo == Logos.none)
              ? null
              : PrettyQrDecorationImage(
            image: (selectedLogo == Logos.upload) ? NetworkImage(logoUrl ?? kPlacholderLogoPath) : AssetImage(logoSource[selectedLogo]),
          ),
        ),
      ),
    );
  }
}