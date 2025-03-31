import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:qreate/widgets/buttons/color_picker_button.dart';

class TestingScreen extends StatefulWidget {
  const TestingScreen({super.key});

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  late Color screenPickerColor;
  late Color dialogPickerColor;
  late Color dialogSelectColor;

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      // Use the dialogPickerColor as start and active color.
      color: dialogPickerColor,
      // Update the dialogPickerColor using the callback.
      onColorChanged: (Color color) =>
          setState(() => dialogPickerColor = color),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      // showMaterialName: true,
      // showColorName: true,
      // showColorCode: true,
      // copyPasteBehavior: const ColorPickerCopyPasteBehavior(
      //   longPressMenu: true,
      // ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      // customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      // New in version 3.0.0 custom transitions support.
      transitionBuilder: (BuildContext context, Animation<double> a1,
          Animation<double> a2, Widget widget) {
        final double curvedValue =
            Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: widget,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
      constraints:
          const BoxConstraints(minHeight: 400, minWidth: 300, maxWidth: 320),
    );
  }

  @override
  void initState() {
    super.initState();
    screenPickerColor = Colors.red;
    dialogPickerColor = Colors.blue;
    dialogSelectColor = const Color(0xFFA239CA);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ColorPickerButton(
            title: 'Canvas',
            color: dialogPickerColor,
            onColorChanged: (Color color) {
              setState(
                () {
                  dialogPickerColor = color;
                },
              );
            },
          )
        ],
      ),
    );
  }
}
