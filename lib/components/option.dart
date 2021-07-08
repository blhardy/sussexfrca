import 'package:flutter/material.dart';
import '../constants.dart';

class Option extends StatelessWidget {
  const Option({required this.optionText, required this.optionColor});
  final String optionText;
  final Color optionColor;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        color: optionColor,
        margin: EdgeInsets.only(top: kDefaultPadding),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: kDefaultMargin * 2,
          width: double.infinity,
          height: 55,
          child: Text(optionText),
        ));
  }
}

        // padding: EdgeInsets.all(kDefaultPadding),
        // decoration: BoxDecoration(
        //   border: Border.all(color: kGrayColor, width: 2),
        //   borderRadius: BorderRadius.circular(10),
        // ),
