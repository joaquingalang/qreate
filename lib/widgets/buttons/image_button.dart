import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({
    super.key,
    required this.imageUrl,
    required this.onPressed,
    required this.onDelete,
  });

  final String imageUrl;
  final VoidCallback onPressed;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(4),
            child: Image.network(imageUrl),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
              ),
              child: GestureDetector(
                onTap: onDelete,
                child: Icon(Icons.close, color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AddImageButton extends StatelessWidget {
  const AddImageButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: kGrayColor200,
        child: Center(
          child: Icon(Icons.add, size: 50),
        ),
      ),
    );
  }
}