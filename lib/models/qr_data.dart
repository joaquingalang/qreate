import 'package:flutter/material.dart';
import 'package:qreate/utils/qr_patterns.dart';
import 'package:qreate/utils/logos.dart';

class QrData {

  const QrData({
    required this.title,
    required this.source,
    required this.pattern,
    required this.canvasColor,
    required this.pixelColor,
    required this.logo,
  });

  final String title;
  final String source;
  final QrPattern pattern;
  final Color canvasColor;
  final Color pixelColor;
  final Logos logo;



}
