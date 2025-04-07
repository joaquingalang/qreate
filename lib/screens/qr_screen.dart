import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qreate/utils/constants.dart';
import 'package:qreate/models/qr_code.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qreate/widgets/app_bar/qreate_app_bar.dart';
import 'package:qreate/widgets/qr/qr_view.dart';
import 'package:qreate/widgets/buttons/rounded_rectangle_button.dart';
import 'package:share_plus/share_plus.dart';

class QrScreen extends StatefulWidget {
  QrScreen({super.key, required this.qrData});

  // Qr Data
  final QrCode qrData;

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  final GlobalKey _qrKey = GlobalKey();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get Responsive Height Of All Components
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double barHeight = screenHeight * (1 / 6);
    double qrSize = screenWidth * (3 / 5);

    return Scaffold(
      body: Stack(
        children: [
          // Backdrop
          Column(
            children: [
              Container(
                width: double.infinity,
                height: barHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kBlueColor500, kBlueColor400],
                    stops: [0, 6],
                  ),
                ),
                child: SafeArea(
                  child: QreateAppBar(context: context, title: widget.qrData.title),
                ),
              ),
            ],
          ),

          // Transparent QR Box
          Container(
            margin: EdgeInsets.only(
                top: barHeight - 36, left: 25, bottom: 36, right: 25),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kGrayColor200.withOpacity(0.65),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(1, 4),
                  blurRadius: 8,
                  spreadRadius: 8,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // QR Code
                RepaintBoundary(
                  key: _qrKey,
                  child: QrView(
                    qrSize: qrSize,
                    source: widget.qrData.source,
                    canvasColor: widget.qrData.canvasColor,
                    pixelColor: widget.qrData.pixelColor,
                    selectedPattern: widget.qrData.pattern,
                    selectedLogo: widget.qrData.logo,
                    logoUrl: widget.qrData.logoUrl,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.qrData.title,
                  style: kTitleSmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                RoundedRectangleButton(
                  title: 'DOWNLOAD',
                  borderRadius: BorderRadius.circular(30),
                  onPressed: _saveToGallery,
                ),
                RoundedRectangleButton(
                  title: 'SHARE',
                  borderRadius: BorderRadius.circular(30),
                  onPressed: _shareQrCode,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Capture QR Code As Image
  Future<Uint8List?> _captureQrCode() async {
    try {
      // Find the render object
      RenderRepaintBoundary boundary =
          _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      // Capture render object as image
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      return byteData?.buffer.asUint8List();
    } catch (e) {
      print('Error capturing QR code: $e');
      return null;
    }
  }

  // Save QR Image To Gallery
  Future<void> _saveToGallery() async {
    // Set status to saving
    setState(() {
      _isSaving = true;
    });

    try {
      // Capture the QR code
      final Uint8List? imageBytes = await _captureQrCode();
      if (imageBytes == null) {
        throw Exception('Failed to capture QR code');
      }

      // Save to gallery
      final result = await ImageGallerySaverPlus.saveImage(
        imageBytes,
        name: widget.qrData.title,
        quality: 100,
      );

      // Visibly indicate success
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('QR code saved to gallery successfully!')));
    } catch (e) {
      // Visibly indicate failure
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to save QR code: $e')));
    } finally {
      // Set status to not saving
      setState(() {
        _isSaving = false;
      });
    }
  }

  // Share QR Image
  Future<void> _shareQrCode() async {
    // Set status to saving
    setState(() {
      _isSaving = true;
    });

    try {
      // Capture the QR code
      final Uint8List? imageBytes = await _captureQrCode();
      if (imageBytes == null) {
        throw Exception('Failed to capture QR code');
      }

      // Get temporary directory
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/${widget.qrData.title}.png';
      final file = File(filePath);

      // Write bytes to file
      await file.writeAsBytes(imageBytes);

      // Share the file
      final sharedFile = XFile(file.path);
      await Share.shareXFiles(
        [sharedFile],
        text: '${widget.qrData.title} QR Code',
        subject: 'Share QR Code',
      );
    } catch (e) {
      // Visibly indicate failure
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to save QR code: $e')));
    } finally {
      // Set status to not saving
      setState(() {
        _isSaving = false;
      });
    }
  }
}
