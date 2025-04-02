import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qreate/utils/qr_patterns.dart';
import 'package:qreate/utils/logos.dart';

class QrCode {
  const QrCode({
    this.id,
    required this.title,
    required this.source,
    this.canvasColor = Colors.white,
    this.pixelColor = Colors.black,
    this.pattern = QrPattern.classic,
    this.logo = Logos.none,
  });

  final String? id;
  final String title;
  final String source;
  final Color canvasColor;
  final Color pixelColor;
  final QrPattern pattern;
  final Logos logo;

  // Map to QrCode
  factory QrCode.fromMap(Map<String, dynamic> map) {
    return QrCode(
      id: map['id'],
      title: map['title'],
      source: map['source'],
      canvasColor: map['canvas_color'],
      pixelColor: map['pixel_color'],
      pattern: map['pattern'],
      logo: map['logo'],
    );
  }

  // QrCode to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'source': source,
      'canvas_color': canvasColor,
      'pixel_color': pixelColor,
      'pattern': pattern,
      'logo': logo,
    };
  }


}
