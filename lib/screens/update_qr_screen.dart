import 'package:flutter/material.dart';
import 'package:qreate/screens/qr_screen.dart';
import 'package:qreate/services/database/qr_database.dart';
import 'package:qreate/utils/constants.dart';
import 'package:qreate/utils/qr_patterns.dart';
import 'package:qreate/utils/logos.dart';
import 'package:qreate/models/qr_code.dart';
import 'package:qreate/services/auth/auth_service.dart';
import 'package:qreate/widgets/app_bar/qreate_app_bar.dart';
import 'package:qreate/widgets/qr/qr_view.dart';
import 'package:qreate/widgets/buttons/rounded_rectangle_button.dart';
import 'package:qreate/widgets/text_fields/qreate_text_field.dart';
import 'package:qreate/widgets/select/pattern_select.dart';
import 'package:qreate/widgets/buttons/color_picker_button.dart';
import 'package:qreate/widgets/select/logo_select.dart';

class UpdateQrScreen extends StatefulWidget {
  const UpdateQrScreen({super.key, required this.qrData});

  final QrCode qrData;

  @override
  State<UpdateQrScreen> createState() => _UpdateQrScreenState();
}

class _UpdateQrScreenState extends State<UpdateQrScreen> {

  // Supabase Authentication Service
  final AuthService _auth = AuthService();

  // Supabase QR Database
  final QrDatabase _qrDatabase = QrDatabase();

  // Form Values
  late final TextEditingController _titleController;
  late String title;

  late final TextEditingController _sourceController;
  late String source;

  // Selected Pattern
  late QrPattern selectedPattern;

  // Colors
  late Color canvasColor;
  late Color pixelColor;

  // Selected Logos
  late Logos selectedLogo;

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

  Future<QrCode> _updateQr() async {
    final String? userId = _auth.getCurrentUserId();
    QrCode newQr = QrCode(
      userId: userId,
      title: title,
      source: source,
      pattern: selectedPattern,
      canvasColor: canvasColor,
      pixelColor: pixelColor,
      logo: selectedLogo,
    );
    await _qrDatabase.updateQr(widget.qrData, newQr);
    return newQr;
  }

  void _initializeQr() {
    setState(() {
      _titleController = TextEditingController();
      _titleController.text = widget.qrData.title;
      _sourceController = TextEditingController();
      _sourceController.text = widget.qrData.source;
      title = widget.qrData.title;
      source = widget.qrData.source;
      canvasColor = widget.qrData.canvasColor;
      pixelColor = widget.qrData.pixelColor;
      selectedPattern = widget.qrData.pattern;
      selectedLogo = widget.qrData.logo;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeQr();
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
                        title: 'Update QR',
                        borderRadius: BorderRadius.circular(90),
                        onPressed: () async {
                          // Save Qr Data
                          final QrCode qrData = await _updateQr();

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
