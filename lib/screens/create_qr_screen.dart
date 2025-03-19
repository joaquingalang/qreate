import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';
import 'package:qreate/widgets/progress_indicators/loading_icon.dart';
import 'package:qreate/widgets/text_fields/auth_form_field.dart';
import 'package:qreate/widgets/buttons/color_picker_button.dart';

class CreateQrScreen extends StatefulWidget {
  const CreateQrScreen({super.key});

  @override
  State<CreateQrScreen> createState() => _CreateQrScreenState();
}

class _CreateQrScreenState extends State<CreateQrScreen> {
  // Screen State
  bool _isLoading = false;

  // Form Values
  String _title = '';

  @override
  Widget build(BuildContext context) {
    // Get Responsive Height Of All Components
    double screenWidth = MediaQuery.of(context).size.width;
    double qrSize = screenWidth * (3 / 7);
    double buttonWidth = screenWidth * (2 / 5);

    return Scaffold(
      body: Container(
        // Gradient Container Has Infinite Bounds
        width: double.infinity,

        // Gradiant Background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            colors: [
              kBlueColor500,
              kBlueColor400,
            ],
            stops: [0, 6],
          ),
        ),

        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              // Screen App Bar
              AppBar(
                backgroundColor: Colors.transparent,
                title: Text(
                  'Generate New QR',
                  style: kSubtext20.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),

              // Offset
              SizedBox(height: 18),

              // App Logo
              Image.asset(kAppLogoPath, width: qrSize),

              // Offset
              SizedBox(height: 36),

              // Authentication Form Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: (_isLoading)
                    ? LoadingIcon(
                        icon: Icon(
                          Icons.qr_code,
                          size: 72,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Offset
                          SizedBox(height: 18),

                          // Title Label
                          Text(
                            'Title',
                            style: kSubtext24.copyWith(
                                fontWeight: FontWeight.bold),
                          ),

                          // Offset
                          SizedBox(height: 5),

                          // Title Form Field
                          AuthFormField(
                            hintText: 'Survey Form',
                            onSaved: (value) {
                              _title = value!;
                            },
                          ),

                          // Offset
                          SizedBox(height: 18),

                          // Title Label
                          Text(
                            'Source',
                            style: kSubtext24.copyWith(
                                fontWeight: FontWeight.bold),
                          ),

                          // Offset
                          SizedBox(height: 5),

                          // Source Form Field
                          AuthFormField(
                            hintText: 'www.example.com',
                            onSaved: (value) {
                              _title = value!;
                            },
                          ),

                          // Offset
                          SizedBox(height: 18),

                          // Title Label
                          Text(
                            'Pattern',
                            style: kSubtext24.copyWith(
                                fontWeight: FontWeight.bold),
                          ),

                          // Offset
                          SizedBox(height: 18),

                          // Title Label
                          Text(
                            'Color',
                            style: kSubtext24.copyWith(
                                fontWeight: FontWeight.bold),
                          ),

                          // Offset
                          SizedBox(height: 5),


                          Row(
                            children: [
                              Expanded(
                                child: ColorPickerButton(
                                  title: 'Canvas',
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: ColorPickerButton(
                                  title: 'Squares',
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),

                          // Offset
                          SizedBox(height: 10),

                          Row(
                            children: [
                              Expanded(
                                child: ColorPickerButton(
                                  title: 'Pixels',
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: SizedBox(),
                              ),
                            ],
                          ),

                          // Offset
                          SizedBox(height: 18),

                          // Title Label
                          Text(
                            'Select Logo',
                            style: kSubtext24.copyWith(
                                fontWeight: FontWeight.bold),
                          ),

                          // Offset
                          SizedBox(height: 500),

                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
