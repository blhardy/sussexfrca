import 'package:flutter/material.dart';
import '../constants.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({required this.questionText});
  final String questionText;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 200,
        margin: EdgeInsets.only(top: kDefaultPadding),
        padding: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          border: Border.all(color: kGrayColor, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: kSpace,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                child: Text(
              questionText,
              style: TextStyle(fontSize: 15),
            ))
          ],
        ));
  }
}
