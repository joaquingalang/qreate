import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';
import 'package:qreate/widgets/buttons/rounded_rectangle_button.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get Responsive Height Of All Components
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double barHeight = screenHeight * (1 / 6);
    double qrSize = screenWidth * (1 / 2);

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
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'QR Title',
                        style: kSubtext20.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
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
              color: kGrayColor100.withOpacity(0.65),
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
                Image.asset('assets/images/qreate_logo_gray.png',
                    width: qrSize),
                SizedBox(height: 10),
                Text(
                  'Title',
                  style: kTitleMedium,
                ),
                SizedBox(height: 16),
                RoundedRectangleButton(
                  title: 'Download',
                  borderRadius: BorderRadius.circular(30),
                  onPressed: () {},
                ),
                RoundedRectangleButton(
                  title: 'Copy To Clipboard',
                  borderRadius: BorderRadius.circular(30),
                  onPressed: () {},
                ),
                RoundedRectangleButton(
                  title: 'Edit Details',
                  borderRadius: BorderRadius.circular(30),
                  onPressed: () {},
                ),
                RoundedRectangleButton(
                  title: 'Delete QR',
                  borderRadius: BorderRadius.circular(30),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
