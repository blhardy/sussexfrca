import 'package:SussexFRCA/components/option.dart';
import 'package:SussexFRCA/models/quiz_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/selected_topics_cubit.dart';

class SBAScreen extends StatefulWidget {
  final QuizItem quizItem;
  SBAScreen({required this.quizItem});

  @override
  State<SBAScreen> createState() => _SBAScreenState();
}

class _SBAScreenState extends State<SBAScreen> {
  var _selectedOption;
  int currentIndex = 0;

  IconData getIcon(bool _expanded) {
    if (_expanded) {
      return Icons.minimize_outlined;
    } else {
      return Icons.add_circle_outline_rounded;
    }
  }

  Color getColorOfOption(thisOption, selectedOption, correctOption, context) {
    var _answerSubmitted = widget.quizItem.answered;
    if (selectedOption == correctOption) {
      BlocProvider.of<SelectedTopicsCubit>(context).setAnsweredCorrectly();
    } else {
      BlocProvider.of<SelectedTopicsCubit>(context).setAnsweredIncorrectly();
    }
    if (!_answerSubmitted && (thisOption == selectedOption)) {
      return Colors.blue[100]!;
    } else if (_answerSubmitted && (thisOption == correctOption)) {
      return Colors.green[100]!;
    } else if (_answerSubmitted &&
        (thisOption != correctOption) &&
        (thisOption == selectedOption)) {
      return Colors.red[100]!;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    var stc = BlocProvider.of<SelectedTopicsCubit>(context);
    _selectedOption = stc.selectedOption;
    return Column(children: [
      ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.quizItem.queOC.options.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => {
                if (!widget.quizItem.answered)
                  {
                    stc.setSelectedOption(index),
                    setState(() => {}),
                  }
              },
              child: Option(
                  // selectedOption: stc.getSelectedOption,
                  optionText: widget.quizItem.queOC.options[index],
                  optionColor: getColorOfOption(
                      index,
                      stc.getSelectedOption,
                      widget.quizItem.queOC.options.indexWhere(
                          (e) => (e == widget.quizItem.queOC.correctOption)),
                      context)),
            );
          }),
    ]);
  }
}
