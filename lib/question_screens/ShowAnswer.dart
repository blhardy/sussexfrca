import 'package:SussexFRCA/components/explanationwidget.dart';
import 'package:SussexFRCA/models/question_model.dart';
import 'package:flutter/material.dart';

class ShowAnswerScreen extends StatefulWidget {
  final Question queOC;
  final bool answerSubmitted;
  final bool expanded;
  ShowAnswerScreen(
      {required this.queOC,
      required this.answerSubmitted,
      required this.expanded});

  @override
  State<ShowAnswerScreen> createState() => _ShowAnswerScreenState();
}

class _ShowAnswerScreenState extends State<ShowAnswerScreen> {
  @override
  Widget build(BuildContext context) {
    var _answerSubmitted = widget.answerSubmitted;
    var _expanded = widget.expanded;
    return Column(children: [
      Visibility(
          visible: (_expanded),
          child: ExplanationWidget(
            explanation: widget.queOC.explanation,
            answeredCorrectly: true,
          ))
    ]);
  }
}
