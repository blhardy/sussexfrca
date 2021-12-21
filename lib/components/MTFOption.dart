import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../constants.dart';
import '../logic/selected_topics_cubit.dart';

class MTFOption extends StatelessWidget {
  const MTFOption({
    required this.optionText,
    required this.optionColor,
    required this.thisMTFOptionIndex,
  });
  final String optionText;
  final Color optionColor;
  final int thisMTFOptionIndex;

  Icon getIcon(Color color) {
    if (optionColor == Colors.blue[100] || optionColor == Colors.red[100]) {
      return Icon(Icons.circle_rounded);
    } else {
      return (Icon(Icons.circle_outlined));
    }
  }

  @override
  Widget build(BuildContext context) {
    var stc = BlocProvider.of<SelectedTopicsCubit>(context);
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
          height: 55,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(width: 4),
            Flexible(child: Text(optionText)),
            ToggleSwitch(
              minWidth: 60.0,
              cornerRadius: 20.0,
              activeBgColors: [
                [Colors.green[400]!],
                [Colors.red[400]!]
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex:
                  getInitialLabel(stc.mtfSelections[thisMTFOptionIndex]),
              totalSwitches: 2,
              labels: ['True', 'False'],
              radiusStyle: true,
              onToggle: (toggle) {
                if (toggle == 1) {
                  stc.setMTFSelection(thisMTFOptionIndex, "F");
                } else {
                  stc.setMTFSelection(thisMTFOptionIndex, "T");
                }
                print(stc.mtfSelections);
              },
            )
          ]),
        ));
  }
}

getInitialLabel(String value) {
  if (value == 'F') {
    return 1;
  } else {
    return 0;
  }
  ;
}

// padding: EdgeInsets.all(kDefaultPadding),
// decoration: BoxDecoration(
//   border: Border.all(color: kGrayColor, width: 2),
//   borderRadius: BorderRadius.circular(10),
// ),
