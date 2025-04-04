import 'package:flutter/material.dart';
import 'package:qreate/models/qr_code.dart';
import 'package:qreate/utils/constants.dart';
import 'package:qreate/services/auth/auth_service.dart';
import 'package:qreate/services/database/qr_database.dart';
import 'package:qreate/widgets/cards/qr_card.dart';
import 'package:qreate/widgets/buttons/gradient_floating_button.dart';
import 'package:qreate/screens/create_qr_screen.dart';
import 'package:qreate/widgets/progress_indicators/loading_icon.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Supabase Authentication Service
  final AuthService _auth = AuthService();

  // SUpabase QR Database
  final QrDatabase _qrDatabase = QrDatabase();

  Future<void> _signOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGrayColor100,

      // Page App Bar
      appBar: AppBar(
        backgroundColor: kBlueColor500,
        title: Row(
          spacing: 11,
          children: [
            Image.asset(kAppLogoPath, width: 30),
            Text('Qreate', style: kOrbitronMedium),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _signOut,
            icon: Icon(
              Icons.logout,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),

      // Page Body
      body: StreamBuilder(
          stream: _qrDatabase.getStream(),
          builder: (context, snapshot) {
            print('Stream Event: ${snapshot.data}');
            if (!snapshot.hasData) {
              return LoadingIcon(
                icon: Icon(
                  Icons.qr_code,
                  size: 72,
                ),
              );
            }

            final qrCodes = snapshot.data!;

            return ListView(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: qrCodes.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      final QrCode qrCode = QrCode(
                        id: qrCodes[index].id,
                        userId: qrCodes[index].userId,
                        title: qrCodes[index].title,
                        source: qrCodes[index].source,
                        canvasColor: qrCodes[index].canvasColor,
                        pixelColor: qrCodes[index].pixelColor,
                        pattern: qrCodes[index].pattern,
                        logo: qrCodes[index].logo,
                      );
                      return QrCard(
                        qrData: qrCode,
                        refresh: () => setState(() {}),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
      floatingActionButton: GradientFloatingButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateQrScreen(),
          ),
        ),
      ),
    );
  }
}
