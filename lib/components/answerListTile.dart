import 'package:flutter/material.dart';
import '../constants.dart';

class AnswerListTile extends StatelessWidget {
  const AnswerListTile(
      {required this.optionText,
      required this.optionColor,
      this.selectedOption});
  final String optionText;
  final Color optionColor;
  final int? selectedOption;

  @override
  Widget build(BuildContext context) {
    Icon getIcon(Color color) {
      if (color == Colors.red[100]) {
        return Icon(Icons.clear);
      } else {
        return Icon(Icons.check);
      }
    }

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // if you need this
          side: BorderSide(
            color: Colors.grey.withOpacity(0.4),
            width: 2,
          ),
        ),
        elevation: 2,
        color: optionColor,
        margin: EdgeInsets.only(top: kDefaultPadding),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(2.5),
          width: double.infinity,
          height: 35,
          child: Row(children: [
            getIcon(optionColor),
            SizedBox(width: 4),
            Flexible(child: Text(optionText))
          ]),
        ));
  }
}

        // padding: EdgeInsets.all(kDefaultPadding),
        // decoration: BoxDecoration(
        //   border: Border.all(color: kGrayColor, width: 2),
        //   borderRadius: BorderRadius.circular(10),
        // ),
