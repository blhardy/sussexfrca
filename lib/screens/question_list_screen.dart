import 'package:SussexFRCA/components/party_drawer.dart';
import 'package:SussexFRCA/logic/expansion_question_cubit.dart';
import 'package:SussexFRCA/logic/question_repository.dart';
import 'package:SussexFRCA/logic/selected_topics_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../question_bank.dart';

class QuestionsListScreen extends StatefulWidget {
  @override
  QuestionsListScreenState createState() => QuestionsListScreenState();
}

class QuestionsListScreenState extends State<QuestionsListScreen> {
  var questionList;
  var selectedQuestionTopics;
  // var userAnswerController = UserAnswerController();
  var answerStrings;
  var interim;

  void _setSelectedQuestion(
      var index, var title, selectedQuestionTopics) async {
    // prefs.setInt('currentQuestionIndex', int.parse(index));

    Navigator.pushNamed(context, '/questions');
  }

  @override
  Widget build(BuildContext context) {
    var topicList;
    var stc = BlocProvider.of<SelectedTopicsCubit>(context);
    print(stc.pharm1QuestionTopics);
    switch (stc.selectedQuiz) {
      case "Physics1":
        topicList = stc.physics1QuestionTopics;
        break;
      case "Physics2":
        topicList = stc.physics2QuestionTopics;
        break;
      case "Pharm1":
        topicList = stc.pharm1QuestionTopics;
        break;
      case "Pharm2":
        topicList = stc.pharm2QuestionTopics;
        break;
      case "Physio1":
        topicList = stc.physio1QuestionTopics;
        break;
      case "Physio2":
        topicList = stc.physio2QuestionTopics;
        break;
    }
    return Scaffold(
        endDrawer: PartyDrawerWidget(),
        appBar: AppBar(
            leading: InkWell(
              child: Icon(Icons.arrow_back_ios_new),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyHomePage(title: 'SussexFRCA Revision')));
              },
            ),
            title: Text('Question List')),
        body: BlocListener<SelectedTopicsCubit, SelectedTopicsState>(
          listener: (context, state) {
            setState(() {});
          },
          child: ListView.builder(
              itemCount: topicList.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                  onTap: () => {
                    BlocProvider.of<SelectedTopicsCubit>(context)
                        .setSelectedQuestionString(topicList[index]),
                    Navigator.pushNamed(context, '/questions'),
                  },
                  title: Text("${index + 1}.  ${topicList[index]}"),
                ));
              }),
        ));
  }
}
