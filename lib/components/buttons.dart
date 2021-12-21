import 'package:SussexFRCA/logic/selected_topics_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionButton extends StatelessWidget {
  final String session;
  const SessionButton({required this.session});

  @override
  Widget build(context) {
    var stc = BlocProvider.of<SelectedTopicsCubit>(context);
    return Container(
        width: 140,
        height: 50,
        child: ElevatedButton(
            onPressed: () => {
                  stc.setSelectedQuiz(session),
                  Navigator.of(context).pushNamed('/passcode')
                },
            child: Text(
              session,
              style: TextStyle(fontSize: 16),
            )));
  }
}
