import 'package:csv/csv.dart';
import 'package:easyfrca/userData.dart';
import 'package:easyfrca/userData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './question_bank.dart';

class QuestionsListScreen extends StatefulWidget {
  @override
  QuestionsListScreenState createState() => QuestionsListScreenState();
}

class QuestionsListScreenState extends State<QuestionsListScreen> {
  var _data;
  var questionList;
  var selectedQuestionTopics;
  var storage = AnswerStorage();
  var questionBank = new QuestionBank();

  Color getColour(var index) {
    var color = Colors.white;
    return color;
  }

  dynamic loadQuestions() async {
    _data = await questionBank.loadAsset();
    return _data;
  }

  void _setSelectedQuestion(var index, selectedQuestionTopics) async {
    final prefs = await SharedPreferences.getInstance();

    // prefs.setInt('currentQuestionIndex', int.parse(index));
    Navigator.pushNamed(context, '/questions', arguments: {
      'index': index,
      'title': questionList[index].title,
      'selectedQuestionTopics': selectedQuestionTopics
    });
  }

  // bool getWhetherQuestionShouldBeDisplayed(int index) {
  //   // getQuestions();
  //   return (selectedQuestionTopics.contains(questionList[index].subject));
  // }

  List<Question> getQuestionsFromStringList(var data) {
    var questionsList = data.map<Question>((questionParts) {
      return Question(
        questionParts[0],
        questionParts[1],
        questionParts[2],
        questionParts[3],
        questionParts[4].toString(),
        questionParts[5].toString(),
        questionParts[6].toString(),
        questionParts[7].toString(),
        questionParts[8].toString(),
        questionParts[9].toString(),
        questionParts[10].toString(),
        questionParts[11].toString(),
        questionParts[12].toString(),
        questionParts[13].toString(),
        questionParts[14].toString(),
      );
    }).toList();
    return questionsList;
  }

  @override
  Widget build(BuildContext context) {
    var interim;
    loadQuestions().then((data) => {
          data.removeAt(0),
          interim = getQuestionsFromStringList(data),
          setState(() {
            questionList = interim;
          })
        });

    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    selectedQuestionTopics = routeArgs['selectedQuestionTopics'];

    return Scaffold(
        appBar: AppBar(title: Text('Questions')),
        body: ListView.builder(
            itemCount: 151,
            itemBuilder: (context, index) {
              return Visibility(
                visible: (selectedQuestionTopics
                    .contains(questionList[index].subject)),
                child: Card(
                    color: getColour(index),
                    child: ListTile(
                        onTap: () =>
                            _setSelectedQuestion(index, selectedQuestionTopics),
                        title: Text(questionList[index].title),
                        subtitle: Text(questionList[index].subject))),
              );
            }));
  }
}

// Future<void> getOneQuestionForScreen() async {
//     final questionRetreived = await QuestionBank().getOneQuestion();
//     _question1 = questionRetreived;
//   }