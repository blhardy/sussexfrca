import 'package:flutter/material.dart';

class QuestionTextBox extends StatelessWidget {
  const QuestionTextBox(
      {required this.questionText, required this.questionStem});
  final String questionText;
  final String questionStem;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: Colors.blue.withOpacity(0.8),
            width: 3,
          ),
        ),
        elevation: 2,
        child: Container(
          width: 340,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(10),
          child: Column(children: [
            Text(questionStem),
            Text(""),
            Flexible(
                child: Text(questionText,
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ]),
        ));
  }
}

// padding: EdgeInsets.all(kDefaultPadding),
// decoration: BoxDecoration(
//   border: Border.all(color: kGrayColor, width: 2),
//   borderRadius: BorderRadius.circular(10),
// ),
