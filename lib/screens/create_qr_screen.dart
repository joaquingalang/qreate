import 'package:flutter/material.dart';
import 'package:qreate/screens/qr_screen.dart';
import 'package:qreate/utils/constants.dart';
import 'package:qreate/utils/qr_patterns.dart';
import 'package:qreate/utils/logos.dart';
import 'package:qreate/models/qr_data.dart';
import 'package:qreate/widgets/app_bar/qreate_app_bar.dart';
import 'package:qreate/widgets/qr/qr_view.dart';
import 'package:qreate/widgets/buttons/rounded_rectangle_button.dart';
import 'package:qreate/widgets/text_fields/qreate_text_field.dart';
import 'package:qreate/widgets/select/pattern_select.dart';
import 'package:qreate/widgets/buttons/color_picker_button.dart';
import 'package:qreate/widgets/select/logo_select.dart';

class CreateQrScreen extends StatefulWidget {
  const CreateQrScreen({super.key});

  @override
  State<CreateQrScreen> createState() => _CreateQrScreenState();
}

class _CreateQrScreenState extends State<CreateQrScreen> {
  // Form Values
  late final TextEditingController _titleController;
  String title = '';

  late final TextEditingController _sourceController;
  String source = '';

  // Selected Pattern
  QrPattern selectedPattern = QrPattern.classic;

  // Colors
  Color canvasColor = Colors.white;
  Color pixelColor = Colors.black;

  // Selected Logos
  Logos selectedLogo = Logos.none;

  void _selectPattern(QrPattern pattern) {
    setState(() {
      selectedPattern = pattern;
    });
  }

  void _selectLogo(Logos logo) {
    setState(() {
      selectedLogo = logo;
    });
  }

  QrData _generateQr() {
    QrData newQrCode = QrData(
      title: title,
      source: source,
      pattern: selectedPattern,
      canvasColor: canvasColor,
      pixelColor: pixelColor,
      logo: selectedLogo,
    );
    return newQrCode;
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _titleController.text = title;
    _sourceController = TextEditingController();
    _sourceController.text = source;
  }

  @override
  Widget build(BuildContext context) {
    // Get Responsive Height Of All Components
    double screenWidth = MediaQuery.of(context).size.width;
    double qrSize = screenWidth * (3 / 7);

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
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              // Screen App Bar
              QreateAppBar(context: context, title: 'Generate New QR'),

              // Offset
              SizedBox(height: 18),

              // QR Code
              QrView(
                qrSize: qrSize,
                source: source,
                canvasColor: canvasColor,
                pixelColor: pixelColor,
                selectedPattern: selectedPattern,
                selectedLogo: selectedLogo,
              ),

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
                child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Offset
                          SizedBox(height: 18),

                          // Title Label
                          Text(
                            'Title',
                            style: kSubtext24B,
                          ),

                          // Offset
                          SizedBox(height: 5),

                          // Title Form Field
                          QreateTextField(
                            hintText: 'Survey Form',
                            controller: _titleController,
                            onChanged: (value) {
                              setState(() => title = value);
                            },
                          ),

                          // Offset
                          SizedBox(height: 18),

                          // Title Label
                          Text('Source', style: kSubtext24B),

                          // Offset
                          SizedBox(height: 5),

                          // Source Form Field
                          QreateTextField(
                            hintText: 'www.example.com',
                            controller: _sourceController,
                            onChanged: (value) {
                              setState(() => source = value);
                            },
                          ),

                          // Offset
                          SizedBox(height: 18),

                          // Pattern Label
                          Text('Pattern', style: kSubtext24B),

                          // Offset
                          SizedBox(height: 5),

                          // Pattern Options
                          PatternSelect(
                            selected: selectedPattern,
                            onSelect: _selectPattern,
                          ),

                          // Offset
                          SizedBox(height: 18),

                          // Color Label
                          Text('Color', style: kSubtext24B),

                          // Offset
                          SizedBox(height: 5),

                          Row(
                            children: [
                              Expanded(
                                child: ColorPickerButton(
                                  title: 'Canvas',
                                  color: canvasColor,
                                  onColorChanged: (Color color) {
                                    setState(() => canvasColor = color);
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: ColorPickerButton(
                                  title: 'Pixels',
                                  color: pixelColor,
                                  onColorChanged: (Color color) {
                                    setState(() => pixelColor = color);
                                  },
                                ),
                              ),
                            ],
                          ),

                          // Offset
                          SizedBox(height: 18),

                          // Select Logo Label
                          Text('Select Logo', style: kSubtext24B),

                          // Offset
                          SizedBox(height: 5),

                          // Select Logo
                          LogoSelect(
                            selected: selectedLogo,
                            onSelect: _selectLogo,
                          ),

                          // Offset
                          SizedBox(height: 18),

                          Center(
                            child: RoundedRectangleButton(
                              title: 'Generate QR',
                              borderRadius: BorderRadius.circular(90),
                              onPressed: () {
                                // Save Qr Data
                                final QrData qrData = _generateQr();

                                // Navigate To Results Screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        QrScreen(qrData: qrData),
                                  ),
                                );
                              },
                            ),
                          ),

                          // Offset
                          SizedBox(height: 18),
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
