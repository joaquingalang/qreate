import 'package:flutter/material.dart';
import 'package:qreate/utils/qr_patterns.dart';
import 'package:qreate/utils/logos.dart';
import 'package:qreate/utils/color_helpers.dart';

class QrCode {
  const QrCode({
    this.id,
    this.userId,
    this.title = '',
    this.source = '',
    this.canvasColor = Colors.white,
    this.pixelColor = Colors.black,
    this.pattern = QrPattern.classic,
    this.logo = Logos.none,
    this.logoUrl,
  });

  final int? id;
  final String? userId;
  final String title;
  final String source;
  final Color canvasColor;
  final Color pixelColor;
  final QrPattern pattern;
  final Logos logo;
  final String? logoUrl;

  // Map to QrCode
  factory QrCode.fromMap(Map<String, dynamic> map) {
    return QrCode(
      id: map['id'],
      userId: map['user_id'],
      title: map['title'],
      source: map['source'],
      canvasColor: stringToColor(map['canvas_color']),
      pixelColor: stringToColor(map['pixel_color']),
      pattern: stringToPattern[map['pattern']]!,
      logo: stringToLogo[map['logo']]!,
      logoUrl: map['logo_url'],
    );
  }

  // QrCode to Map
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'title': title,
      'source': source,
      'canvas_color': colorToString(canvasColor),
      'pixel_color': colorToString(pixelColor),
      'pattern': patternToString[pattern],
      'logo': logoToString[logo],
      'logo_url': logoUrl,
    };
  }

}
