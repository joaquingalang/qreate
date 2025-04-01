import 'package:flutter/material.dart';
import 'package:qreate/utils/qr_patterns.dart';
import 'package:qreate/utils/logos.dart';

class QrData {

  const QrData({
    required this.title,
    required this.source,
    this.pattern = QrPattern.classic,
    this.canvasColor = Colors.white,
    this.pixelColor = Colors.black,
    this.logo = Logos.none,
  });

  final String title;
  final String source;
  final QrPattern pattern;
  final Color canvasColor;
  final Color pixelColor;
  final Logos logo;



}
