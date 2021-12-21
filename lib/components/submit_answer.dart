import 'package:flutter/material.dart';
import '../constants.dart';

class SubmitAnswerButton extends StatelessWidget {
  SubmitAnswerButton({required this.answerSubmitted});
  final bool answerSubmitted;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // if you need this
          side: BorderSide(
            color: Colors.grey.withOpacity(0.4),
            width: 2,
          ),
        ),
        elevation: 2,
        color: Colors.blue[600]!,
        margin: EdgeInsets.only(top: kDefaultPadding),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(2.5),
          height: 55,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(width: 4),
            Flexible(
                child: Text(
              getButtonText(answerSubmitted),
              style: TextStyle(fontSize: 20, color: Colors.white),
            ))
          ]),
        ));
  }

  Color getButtonColor(bool answerSubmitted) {
    if (answerSubmitted) {
      return Colors.blue[200]!;
    } else {
      return Colors.blue[400]!;
    }
  }

  String getButtonText(bool answerSubmitted) {
    if (answerSubmitted) {
      return "Next Question";
    } else {
      return "Submit Answer";
    }
  }
}
