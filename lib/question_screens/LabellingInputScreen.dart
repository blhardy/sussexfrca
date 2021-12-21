import 'package:SussexFRCA/components/explanationwidget.dart';
import 'package:SussexFRCA/models/question_model.dart';
import 'package:flutter/material.dart';

class LabellingInputScreen extends StatefulWidget {
  final Question queOC;
  final bool answerSubmitted;
  final bool expanded;
  LabellingInputScreen(
      {required this.queOC,
      required this.answerSubmitted,
      required this.expanded});

  @override
  State<LabellingInputScreen> createState() => _LabellingInputScreenState();
}

class _LabellingInputScreenState extends State<LabellingInputScreen> {
  // ignore: unused_field
  int _selectedOption = 10;
  int currentIndex = 0;
  List _selecteCategorys = [];
  List<String> subList = [];
  String query = '';
  List<bool> optionGuessed = [false, false, false, false, false, false, false];

  void _onCategorySelected(bool selected, String optionText) {
    if (selected == true) {
      setState(() {
        _selecteCategorys.add(optionText);
      });
    } else {
      setState(() {
        _selecteCategorys.remove(optionText);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var _answerSubmitted = widget.answerSubmitted;
    var _expanded = widget.expanded;
    var options = widget.queOC.options;
    var answers = widget.queOC.correctOption.split('/');
    Set intersectionList = {};

    List<String> getSublist() {
      if (widget.answerSubmitted) {
        return widget.queOC.options;
      } else {
        return subList;
      }
    }

    Color getColor(String optionText) {
      if (subList.contains(optionText)) {
        return Colors.green[100]!;
      } else {
        return Colors.red[100]!;
      }
    }

    Set getIntersectionList() {
      Set s1 = Set.from(subList);
      Set s2 = Set.from(widget.queOC.options);
      intersectionList = (s2.difference(s1));
      setState(() {});
      return intersectionList;
    }

    return Column(children: [
      Visibility(
        visible: (_expanded),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              if (_answerSubmitted) {
                optionGuessed = [true, true, true, true, true, true, true];
              }
              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: Card(
                  elevation: 3,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(options[index]),
                        SizedBox(
                          width: 220,
                          child: Visibility(
                              replacement: Row(children: [
                                Text(" ${answers[index]}   "),
                                Icon(
                                  Icons.check,
                                  color: Colors.green[300]!,
                                )
                              ]),
                              visible: !optionGuessed[index],
                              child: TextField(
                                onChanged: (text) {
                                  if (text.length > 3) {
                                    if (answers[index]
                                        .toString()
                                        .toLowerCase()
                                        .contains(text)) {
                                      optionGuessed[index] = true;
                                      setState(() => {});
                                    }
                                  }
                                },
                              )),
                        ),
                      ]),
                ),
              );
            }),
      ),
      Visibility(
          visible: _answerSubmitted,
          child: ExplanationWidget(
            explanation: widget.queOC.explanation,
            answeredCorrectly: (widget.queOC.options[_selectedOption] ==
                widget.queOC.correctOption),
          ))
    ]);
  }
}
