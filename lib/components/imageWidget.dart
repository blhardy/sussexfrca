import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String imagePath;
  const ImageWidget({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: Colors.blue.withOpacity(0.8),
            width: 3,
          ),
        ),
        child: Image(
          height: 180,
          fit: BoxFit.fill,
          image: AssetImage("assets/EASYFRCAImages/$imagePath"),
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Text('------------------------------------------------');
          },
        ));
  }
}
