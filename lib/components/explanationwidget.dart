import 'package:flutter/material.dart';

class ExplanationWidget extends StatelessWidget {
  const ExplanationWidget(
      {required this.explanation, required this.answeredCorrectly});
  final String explanation;
  final bool answeredCorrectly;

  @override
  Widget build(BuildContext context) {
    String correctOrFalse = 'Explanation';
    if (answeredCorrectly) {
      correctOrFalse = "Correct";
    } else {
      correctOrFalse = 'False';
    }
    List<String> explanationList = explanation.split("~");
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
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Column(children: [
              Text(
                correctOrFalse,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(2),
                  itemCount: explanationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(explanationList[index]);
                  }),
            ])));
  }
}

        // padding: EdgeInsets.all(kDefaultPadding),
        // decoration: BoxDecoration(
        //   border: Border.all(color: kGrayColor, width: 2),
        //   borderRadius: BorderRadius.circular(10),
        // ),
