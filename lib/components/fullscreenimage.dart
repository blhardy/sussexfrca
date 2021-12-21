import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../components/image_presenter.dart';

class FullScreenImage extends StatelessWidget {
  final String imageAddress;

  const FullScreenImage({required this.imageAddress}) : super();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      appBar: AppBar(title: Text(args.imageAddress.split('.')[0])),
      backgroundColor: Colors.black87,
      body: Center(
        child: PhotoView(
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
            imageProvider:
                AssetImage("assets/EASYFRCAImages/${args.imageAddress}")),
      ),
    );
  }
}
