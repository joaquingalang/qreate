import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';
import 'package:qreate/widgets/buttons/pattern_button.dart';

class PatternSelect extends StatelessWidget {
  const PatternSelect({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  final QrPattern selected;
  final Function(QrPattern) onSelect;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PatternButton(
          pattern: QrPattern.classic,
          isSelected: (QrPattern.classic == selected),
          onPressed: () => onSelect(QrPattern.classic),
        ),
        PatternButton(
          pattern: QrPattern.rounded,
          isSelected: (QrPattern.rounded == selected),
          onPressed: () => onSelect(QrPattern.rounded),
        ),
        PatternButton(
          pattern: QrPattern.thin,
          isSelected: (QrPattern.thin == selected),
          onPressed: () => onSelect(QrPattern.thin),
        ),
        PatternButton(
          pattern: QrPattern.smooth,
          isSelected: (QrPattern.smooth == selected),
          onPressed: () => onSelect(QrPattern.smooth),
        ),
        PatternButton(
          pattern: QrPattern.circles,
          isSelected: (QrPattern.circles == selected),
          onPressed: () => onSelect(QrPattern.circles),
        ),
      ],
    );
  }
}