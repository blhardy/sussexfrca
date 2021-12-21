import 'package:SussexFRCA/logic/images_cubit.dart';
import 'package:SussexFRCA/models/image_explanation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeyTopicListScreen extends StatefulWidget {
  List<ImageAndExplanation> listOfImages = [];

  @override
  KeyTopicListState createState() => KeyTopicListState();
}

class KeyTopicListState extends State<KeyTopicListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImagesCubit(),
      child: Scaffold(
          appBar: AppBar(title: Text('Key Topics')),
          body: BlocBuilder<ImagesCubit, ImageScreenState>(
              builder: (blocContext, state) {
            return ListView.builder(
                itemCount: state.listOfImages.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      onTap: () => {
                        BlocProvider.of<ImagesCubit>(context)
                            .selectImage(index),
                        print('Index is: ' + index.toString()),
                        print('Stored index is : ' +
                            state.selectedImageIndex.toString()),
                        Navigator.pushNamed(context, '/keytopic',
                            arguments: {'index': index})
                      },
                      title: Text(state.listOfImages[index].title),
                    ),
                  );
                });
          })),
    );
  }
}
