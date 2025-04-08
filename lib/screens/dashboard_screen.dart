import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:qreate/models/qr_code.dart';
import 'package:qreate/services/connectivity/connectivity_service.dart';
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

  // Connectivity Service & State
  final ConnectivityService _connectivity = ConnectivityService();
  bool _isConnected = true;

  // Supabase Authentication Service
  final AuthService _auth = AuthService();

  // SUpabase QR Database
  final QrDatabase _qrDatabase = QrDatabase();

  Future<void> _signOut() async {
    await _auth.signOut();
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      setState(() => _isConnected = false);
    } else {
      setState(() => _isConnected = true);
    }
  }

  @override
  void initState() {
    super.initState();
    StreamSubscription<List<ConnectivityResult>> connectionSubscription = _connectivity.getSubscription(_updateConnectionStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGrayColor100,

      // Page App Bar
      appBar: AppBar(
        backgroundColor: kBlueColor500,
        automaticallyImplyLeading: false,
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

            if (!_isConnected) {
              return NoInternetIndicator();
            }

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
                        logoUrl: qrCodes[index].logoUrl,
                      );
                      return QrCard(
                        qrData: qrCode,
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

class NoInternetIndicator extends StatelessWidget {
  const NoInternetIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [

          // No internet icon
          Icon(
            Icons.signal_wifi_connected_no_internet_4,
            size: 70,
            color: Colors.grey,
          ),

          // No internet message
          Text(
            'No internet connection',
            style: kSubtext20.copyWith(color: Colors.grey),
          ),

          // Offset
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
