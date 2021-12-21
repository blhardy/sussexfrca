import 'package:SussexFRCA/components/explanationwidget.dart';
import 'package:SussexFRCA/models/question_model.dart';
import 'package:flutter/material.dart';

class ChecklistScreen extends StatefulWidget {
  final Question queOC;
  final bool answerSubmitted;
  final bool expanded;
  ChecklistScreen(
      {required this.queOC,
      required this.answerSubmitted,
      required this.expanded});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  // ignore: unused_field
  int _selectedOption = 10;
  int currentIndex = 0;
  List _selecteCategorys = [];

  Color getCheckColor(thisOption, selectedOptions, correctOptions) {
    var _answerSubmitted = widget.answerSubmitted;
    if (!_answerSubmitted && (selectedOptions.contains(thisOption))) {
      return Colors.blue[100]!;
    } else if (_answerSubmitted && (correctOptions.contains(thisOption))) {
      return Colors.green[100]!;
    } else if (_answerSubmitted &&
        (!correctOptions.contains(thisOption)) &&
        (selectedOptions.contains(thisOption))) {
      return Colors.red[100]!;
    } else {
      return Colors.white;
    }
  }

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
    return Column(children: [
      Visibility(
        visible: (_expanded),
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.queOC.options.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () => {
                        if (!_answerSubmitted)
                          {_selectedOption = index, setState(() => {})}
                      },
                  child: CheckboxListTile(
                    dense: true,
                    tileColor: getCheckColor(
                        widget.queOC.options[index],
                        _selecteCategorys,
                        widget.queOC.correctOption.split("/")),
                    title: Text(widget.queOC.options[index]),
                    value:
                        _selecteCategorys.contains(widget.queOC.options[index]),
                    onChanged: (bool? value) {
                      if (!_answerSubmitted) {
                        if (value != null) {
                          _onCategorySelected(
                              value, widget.queOC.options[index]);
                        }
                      }
                    },
                  ));
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
