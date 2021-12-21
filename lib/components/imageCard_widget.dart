import 'package:SussexFRCA/logic/selected_topics_cubit.dart';
import 'package:SussexFRCA/models/image_explanation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';

class ImageCard extends StatelessWidget {
  final ImageAndExplanation imageDetails;
  const ImageCard({required this.imageDetails});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedTopicsCubit, SelectedTopicsState>(
      builder: (context, state) {
        return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: kGrayColor, width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child:
                      Text(imageDetails.title, style: TextStyle(fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage(
                        "assets/EASYFRCAImages/${imageDetails.assetLink}"),
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Text(
                          '------------------------------------------------');
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(imageDetails.explanation),
                ),
              ]),
            ));
      },
    );
  }
}
