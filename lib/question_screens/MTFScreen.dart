import 'package:SussexFRCA/components/MTFOption.dart';
import 'package:SussexFRCA/components/arrow_components.dart';
import 'package:SussexFRCA/components/explanationwidget.dart';
import 'package:SussexFRCA/components/option.dart';
import 'package:SussexFRCA/components/question_text_box.dart';
import 'package:SussexFRCA/components/submit_answer.dart';
import 'package:SussexFRCA/models/question_model.dart';
import 'package:SussexFRCA/models/quiz_item.dart';
import 'package:flutter/material.dart';

class MTFScreen extends StatefulWidget {
  final QuizItem quizItem;
  List<String> trueOrFalse = [];

  MTFScreen({required this.quizItem});

  @override
  State<MTFScreen> createState() => _MTFScreenState();
}

class _MTFScreenState extends State<MTFScreen> {
  int _selectedOption = 10;
  int currentIndex = 0;

  Color getOptionColor(int index) {
    if (!widget.quizItem.answered) {
      return Colors.white;
    } else if (widget.quizItem.queOC.correctOption.split(',')[index] == "T") {
      return Colors.green[100]!;
    } else {
      return Colors.red[100]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.trueOrFalse = widget.quizItem.queOC.correctOption.split('');
    return Column(children: [
      ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.quizItem.queOC.options.length,
          itemBuilder: (context, index) {
            return MTFOption(
              thisMTFOptionIndex: index,
              optionText: widget.quizItem.queOC.options[index],
              optionColor: getOptionColor(index),
            );
          }),
    ]);
  }
}
