import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';
import 'package:qreate/utils/qr_patterns.dart';
import 'package:qreate/utils/logos.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qreate/widgets/buttons/rounded_rectangle_button.dart';
import 'package:qreate/widgets/progress_indicators/loading_icon.dart';
import 'package:qreate/widgets/text_fields/custom_text_field.dart';
import 'package:qreate/widgets/select/pattern_select.dart';
import 'package:qreate/widgets/buttons/color_picker_button.dart';
import 'package:qreate/widgets/select/logo_select.dart';

class CreateQrScreen extends StatefulWidget {
  const CreateQrScreen({super.key});

  @override
  State<CreateQrScreen> createState() => _CreateQrScreenState();
}

class _CreateQrScreenState extends State<CreateQrScreen> {
  // Screen State
  bool _isLoading = false;

  // Form Values
  late final TextEditingController _titleController;
  String _title = '';

  late final TextEditingController _sourceController;
  String _source = '';

  // Selected Pattern
  QrPattern selectedPattern = QrPattern.classic;

  // Colors
  Color canvasColor = Colors.white;
  Color squareColor = Colors.black;
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

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _titleController.text = _title;
    _sourceController = TextEditingController();
    _sourceController.text = _source;
  }

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

              // QR Code
              Container(
                width: qrSize,
                padding: EdgeInsets.all(8),
                color: canvasColor,
                child: PrettyQrView.data(
                  data: _source,
                  decoration: PrettyQrDecoration(
                    shape: (selectedPattern == QrPattern.circles)
                        ? PrettyQrRoundedSymbol(
                            color: pixelColor,
                          )
                        : PrettyQrSmoothSymbol(
                            color: pixelColor,
                          ),
                    image: (selectedLogo == Logos.none)
                        ? null
                        : PrettyQrDecorationImage(
                            image: AssetImage(logoSource[selectedLogo]),
                          ),
                  ),
                ),
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
                          CustomTextField(
                            hintText: 'Survey Form',
                            controller: _titleController,
                            onChanged: (value) {
                              setState(() {
                                _title = value;
                              });
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
                          CustomTextField(
                            hintText: 'www.example.com',
                            controller: _sourceController,
                            onChanged: (value) {
                              setState(() {
                                _source = value;
                              });
                            },
                          ),

                          // Offset
                          SizedBox(height: 18),

                          // Pattern Label
                          Text(
                            'Pattern',
                            style: kSubtext24.copyWith(
                                fontWeight: FontWeight.bold),
                          ),

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
                                  color: canvasColor,
                                  onColorChanged: (Color color) {
                                    setState(() {
                                      canvasColor = color;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: ColorPickerButton(
                                  title: 'Pixels',
                                  color: pixelColor,
                                  onColorChanged: (Color color) {
                                    setState(() {
                                      pixelColor = color;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          // Offset
                          SizedBox(height: 18),

                          // Select Logo Label
                          Text(
                            'Select Logo',
                            style: kSubtext24.copyWith(
                                fontWeight: FontWeight.bold),
                          ),

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
                              onPressed: () {},
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
