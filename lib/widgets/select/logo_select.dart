import 'package:flutter/material.dart';
import 'package:qreate/utils/logos.dart';
import 'package:qreate/widgets/buttons/logo_button.dart';

class LogoSelect extends StatelessWidget {
  const LogoSelect({
    super.key,
    this.selected = Logos.none,
    required this.onSelect,
  });

  final Logos selected;
  final Function(Logos) onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            LogoButton(
              logo: Logos.none,
              isSelected: (Logos.none == selected),
              onPressed: () => onSelect(Logos.none),
            ),
            LogoButton(
              logo: Logos.upload,
              isSelected: (Logos.upload == selected),
              onPressed: () => onSelect(Logos.upload),
            ),
            LogoButton(
              logo: Logos.facebook,
              isSelected: (Logos.facebook == selected),
              onPressed: () => onSelect(Logos.facebook),
            ),
            LogoButton(
              logo: Logos.instagram,
              isSelected: (Logos.instagram == selected),
              onPressed: () => onSelect(Logos.instagram),
            ),
            LogoButton(
              logo: Logos.linkedin,
              isSelected: (Logos.linkedin == selected),
              onPressed: () => onSelect(Logos.linkedin),
            ),
            LogoButton(
              logo: Logos.x,
              isSelected: (Logos.x == selected),
              onPressed: () => onSelect(Logos.x),
            ),
          ],
        ),
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            LogoButton(
              logo: Logos.youtube,
              isSelected: (Logos.youtube == selected),
              onPressed: () => onSelect(Logos.youtube),
            ),
            LogoButton(
              logo: Logos.tiktok,
              isSelected: (Logos.tiktok == selected),
              onPressed: () => onSelect(Logos.tiktok),
            ),
            LogoButton(
              logo: Logos.pinterest,
              isSelected: (Logos.pinterest == selected),
              onPressed: () => onSelect(Logos.pinterest),
            ),
            LogoButton(
              logo: Logos.shopify,
              isSelected: (Logos.shopify == selected),
              onPressed: () => onSelect(Logos.shopify),
            ),
            LogoButton(
              logo: Logos.gcash,
              isSelected: (Logos.gcash == selected),
              onPressed: () => onSelect(Logos.gcash),
            ),
            LogoButton(
              logo: Logos.github,
              isSelected: (Logos.github == selected),
              onPressed: () => onSelect(Logos.github),
            ),
          ],
        ),
      ],
    );
  }
}