import 'package:SussexFRCA/components/option.dart';
import 'package:SussexFRCA/logic/selected_topics_cubit.dart';
import 'package:SussexFRCA/models/quiz_item.dart';
import 'package:SussexFRCA/models/user_answer_model.dart';
import 'package:SussexFRCA/question_bank.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserResultCharts extends StatefulWidget {
  @override
  _UserResultChartsState createState() => _UserResultChartsState();
}

class _UserResultChartsState extends State<UserResultCharts> {
  final Stream<QuerySnapshot> quizStream =
      FirebaseFirestore.instance.collection('quiz_details').snapshots();
  List<UserAnswer> userAnswers = [];

  @override
  Widget build(BuildContext context) {
    List<QuizItem> questionGroup =
        BlocProvider.of<SelectedTopicsCubit>(context).getCurrentQuizItemGroup();
    return StreamBuilder<QuerySnapshot>(
      stream: quizStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }

        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: questionGroup.length,
            itemBuilder: (BuildContext context, int) {
              return Card(
                margin: EdgeInsets.all(5),
                child: Container(
                    padding: EdgeInsets.all(10),
                    width: 300,
                    child: Column(children: [
                      Text(
                        "Question ${int + 1} (${questionGroup[int].queOC.questionType})",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text("${questionGroup[int].queOC.questionStem}"),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (BuildContext context, index) {
                            var list = snapshot.data?.docs
                                .map((doc) => doc.data())
                                .toList();
                            if (questionGroup[int].queOC.questionType == "SBA")
                              return SBAResultOption(
                                  optionText:
                                      questionGroup[int].queOC.options[index],
                                  fraction: parseAnswerQueryData(list,
                                      questionGroup[int].queOC.topic, index));
                            if (questionGroup[int].queOC.questionType == "MTF")
                              return MTFResultOption(
                                  optionText:
                                      questionGroup[int].queOC.options[index],
                                  trueOrFalse: questionGroup[int]
                                      .queOC
                                      .correctOption
                                      .split(',')[index]);
                            return Text("");
                          }),
                    ])),
              );
            });

        // shrinkWrap: true,
        // children: snapshot.data!.docs.map((DocumentSnapshot document) {
        //   Map<String, dynamic> data =
        //       document.data()! as Map<String, dynamic>;
        //   return Card(
        //     child: Column(children: [
        //       Text("First bit of data"),
        //     ]),
        //   );
        // }).toList(),
      },
    );
  }

  double parseAnswerQueryData(
      List<Object?>? data, String questionTopic, int optionIndex) {
    String quiz = BlocProvider.of<SelectedTopicsCubit>(context).selectedQuiz;
    var _activeUsers = [];
    int _numberOfTimesChosen = 0;
    data?.forEach((userDataCollection) {
      Map<String, dynamic> userDataList =
          userDataCollection as Map<String, dynamic>;

      if (userDataList['questionsAnsweredList'] != []) {
        if ((!_activeUsers.contains(userDataList['firstName']) &&
            (userDataList['${quiz.toLowerCase()}status'] != 'not_started'))) {
          _activeUsers.add(userDataList['firstName']);
        }
        var answerItems =
            userDataList['questionsAnsweredList'] as Map<String, dynamic>;
        answerItems.forEach((key, value) {
          if ((key == questionTopic) && (value['chosenOption'] == optionIndex))
          // && (DateTime.parse(value['dateTime'])
          //     .isAfter(DateTime.now().subtract(Duration(hours: 6)))))
          {
            _numberOfTimesChosen += 1;
          }
        });
      }
    });
    return _numberOfTimesChosen / _activeUsers.length;
  }
}
