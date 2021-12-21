import 'package:flutter/material.dart';

class ScreenArguments {
  final String imageAddress;

  ScreenArguments(this.imageAddress);
}

class ImagePresenter extends StatelessWidget {
  late String imageAddress;

  ImagePresenter({required this.imageAddress});

  @override
  Widget build(BuildContext context) {
    if (this.imageAddress == "") {
      return SizedBox.shrink();
    }
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: Colors.blue.withOpacity(0.8),
            width: 3,
          ),
        ),
        child: GestureDetector(
            child: Image(
              image: AssetImage("assets/EASYFRCAImages/$imageAddress"),
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return SizedBox.shrink();
              },
            ),
            onTap: () => {
                  Navigator.pushNamed(
                    context,
                    '/imagepresenter',
                    arguments: ScreenArguments(imageAddress),
                  )
                }));
  }
}
