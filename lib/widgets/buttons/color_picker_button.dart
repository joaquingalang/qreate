import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class ColorPickerButton extends StatefulWidget {
  const ColorPickerButton({
    super.key,
    required this.title,
    this.color = Colors.white,
    required this.onColorChanged,
  });

  final String title;
  final Color color;
  final Function(Color) onColorChanged;

  @override
  State<ColorPickerButton> createState() => _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  late Color selectedColor;

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      // Use the dialogPickerColor as start and active color.
      color: selectedColor,
      // Update the dialogPickerColor using the callback.
      onColorChanged: (Color color) =>
          setState(() => selectedColor = color),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
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
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
      },
    ).showPickerDialog(
      context,
      backgroundColor: kGrayColor200,
      // New in version 3.0.0 custom transitions support.
      transitionBuilder: (BuildContext context,
          Animation<double> a1,
          Animation<double> a2,
          Widget widget) {
        final double curvedValue =
            Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(
              0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: widget,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
      constraints:
      const BoxConstraints(minHeight: 300, minWidth: 300, maxWidth: 320),
    );
  }

  @override
  void initState() {
    super.initState();
    selectedColor = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final Color colorBeforeDialog = selectedColor;
        if (!(await colorPickerDialog())) {
          selectedColor = colorBeforeDialog;
        }
        widget.onColorChanged(selectedColor);
      },
      child: Container(
        width: 180,
        height: 55,
        decoration: BoxDecoration(
          color: kGrayColor200,
          border: Border.all(
              color: Colors.black
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          title: Text(widget.title, style: kSubtext16),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: selectedColor,
              border: Border.all(
                width: 2,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}