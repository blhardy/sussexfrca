import 'package:SussexFRCA/components/answerListTile.dart';
import 'package:SussexFRCA/components/explanationwidget.dart';
import 'package:SussexFRCA/components/option.dart';
import 'package:SussexFRCA/models/question_model.dart';
import 'package:flutter/material.dart';

class InputTextScreen extends StatefulWidget {
  final Question queOC;
  final bool answerSubmitted;
  final bool expanded;
  InputTextScreen(
      {required this.queOC,
      required this.answerSubmitted,
      required this.expanded});

  @override
  State<InputTextScreen> createState() => _InputTextScreenState();
}

class _InputTextScreenState extends State<InputTextScreen> {
  // ignore: unused_field
  int _selectedOption = 10;
  int currentIndex = 0;
  List _selecteCategorys = [];
  List<String> subList = [];
  String query = '';

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
    Set intersectionList = {};
    var msgController = TextEditingController();

    bool _checkQuery(String query) {
      for (String optionText in widget.queOC.options) {
        if (optionText.toString().toLowerCase().contains(query) &&
            !subList.contains(optionText)) {
          subList.add(optionText);
          return true;
        }
      }
      return false;
    }

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
        child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: msgController,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                  ),
                  hintText: 'Type answer here..'),
              onChanged: (text) {
                if (text.length > 3) {
                  if (_checkQuery(text)) {
                    msgController.clear();
                  }
                  setState(() => {});
                }
              },
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: getSublist().length,
              itemBuilder: (context, index) {
                return AnswerListTile(
                    optionText: getSublist()[index],
                    optionColor: getColor(getSublist()[index]));
              }),
        ]),
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
