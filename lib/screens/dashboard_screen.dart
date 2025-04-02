import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';
import 'package:qreate/services/auth/auth_service.dart';
import 'package:qreate/widgets/cards/qr_card.dart';
import 'package:qreate/widgets/buttons/gradient_floating_button.dart';
import 'package:qreate/screens/create_qr_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // Supabase Authentication Service
  final AuthService _auth = AuthService();

  List<Widget> qrList = [
    QrCard(),
    QrCard(),
    QrCard(),
    QrCard(),
    QrCard(),
  ];

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
      body: ListView(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: qrList.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return qrList[index];
              },
            ),
          ),
        ],
      ),
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
