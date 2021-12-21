import 'package:SussexFRCA/components/imageCard_widget.dart';
import 'package:SussexFRCA/logic/images_cubit.dart';
import 'package:SussexFRCA/models/image_explanation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeyTopicScreen extends StatefulWidget {
  List<ImageAndExplanation> listOfImages = [];

  @override
  KeyTopicScreenState createState() => KeyTopicScreenState();
}

class KeyTopicScreenState extends State<KeyTopicScreen> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var index = routeArgs['index'];
    return BlocProvider(
      create: (context) => ImagesCubit(),
      child: Scaffold(
          appBar: AppBar(title: Text('Key Topics')),
          body: BlocBuilder<ImagesCubit, ImageScreenState>(
              builder: (blocContext, state) {
            return Card(
                elevation: 2,
                child: ImageCard(imageDetails: state.listOfImages[index]));
          })),
    );
  }
}
