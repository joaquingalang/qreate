import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';
import 'package:qreate/widgets/cards/qr_card.dart';
import 'package:qreate/widgets/buttons/gradient_floating_button.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Widget> qrList = [
    QrCard(),
    QrCard(),
    QrCard(),
    QrCard(),
    QrCard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGrayColor200,

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
            onPressed: () {},
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
        onPressed: () {},
      ),
    );
  }
}
