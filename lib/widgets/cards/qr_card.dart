import 'package:flutter/material.dart';
import 'package:qreate/screens/qr_screen.dart';
import 'package:qreate/screens/update_qr_screen.dart';
import 'package:qreate/utils/constants.dart';
import 'package:qreate/models/qr_code.dart';
import 'package:qreate/services/database/qr_database.dart';
import 'package:qreate/utils/logos.dart';
import 'package:qreate/widgets/qr/qr_view.dart';

class QrCard extends StatelessWidget {
  const QrCard({
    super.key,
    required this.qrData,
  });

  final QrCode qrData;

  Future<void> _delete() async {
    final QrDatabase qrDatabase = QrDatabase();
    await qrDatabase.deleteQr(qrData);
  }

  void _update(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateQrScreen(qrData: qrData),
      ),
    );
  }

  void _view(BuildContext context) {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => QrScreen(qrData: qrData),),);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double cardWidth = (screenWidth - 75) / 2;
    double cardHeight = cardWidth - 10;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GestureDetector(
        onTap: () => _view(context),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 2),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: cardWidth,
                height: cardHeight * 0.70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: QrView(
                      source: qrData.source,
                      selectedLogo: qrData.logo,
                      selectedPattern: qrData.pattern,
                      canvasColor: qrData.canvasColor,
                      pixelColor: qrData.pixelColor,
                      logoUrl: qrData.logoUrl,
                    ),
                  ),
                ),
              ),
              Opacity(
                opacity: 0.6,
                child: Container(
                  width: cardWidth,
                  height: cardHeight * 0.30,
                  decoration: BoxDecoration(
                    color: kBlueColor400,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '   ${_trimTitle(qrData.title)}',
                        style: kSubtext16.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      PopupMenuButton(
                        iconColor: Colors.white,
                        itemBuilder: (context) =>
                        [
                          PopupMenuItem(
                            onTap: () => _update(context),
                            child: Text('Update'),
                          ),
                          PopupMenuItem(
                            onTap: _delete,
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _trimTitle(String title) {
    String trimmed = title;
    if (title.length > 10) {
      trimmed = '${title.substring(0, 9)}...';
    }
    return trimmed;
  }
}
