import 'package:SussexFRCA/logic/selected_topics_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalResultChart extends StatelessWidget {
  const PersonalResultChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var stc = BlocProvider.of<SelectedTopicsCubit>(context);
    int totalAnswered = stc.totalAnsweredThisSession;
    int answeredCorrectly = stc.noAnsweredCorrectly;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue[600]!, width: 3),
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.blue[50],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Container(
                alignment: AlignmentDirectional.topCenter,
                height: 30,
                width: 220,
                child: Text(
                  "${stc.selectedQuiz} Results",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 300, height: 20),
              Container(
                height: 200,
                width: 5000,
                child: PieChart(
                  PieChartData(sections: [
                    PieChartSectionData(
                        title: ('${totalAnswered - answeredCorrectly}'),
                        color: Colors.red[400]!,
                        value: (totalAnswered - answeredCorrectly).toDouble()),
                    PieChartSectionData(
                        title: ('$answeredCorrectly'),
                        color: Colors.green[400],
                        value: (answeredCorrectly).toDouble())
                  ]),
                ),
              ),
              SizedBox(width: 300, height: 50),
              Text(
                'Score: ${(answeredCorrectly / totalAnswered * 100).toStringAsPrecision(2)}%',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ]),
          )),
    );
  }
}
