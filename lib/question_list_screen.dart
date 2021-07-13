import 'package:csv/csv.dart';
import 'package:easyfrca/user_answer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './question_bank.dart';

//TODO filter questions by topics

class QuestionsListScreen extends StatefulWidget {
  @override
  QuestionsListScreenState createState() => QuestionsListScreenState();
}

class QuestionsListScreenState extends State<QuestionsListScreen> {
  var _data;
  var questionList;
  var selectedQuestionTopics;
  var questionBank = new QuestionBank();
  var userAnswerController = UserAnswerController();
  var answerStrings;
  var interim;

  void fetchAnsweredQuestions() async {
    SharedPreferences.getInstance().then((prefs) {
      answerStrings = (prefs.getStringList('answerStrings'));
      setState(() {});
    });
  }

  Future<List<Question>> getQuestions() =>
      questionBank.getQuestionsAsync().then((_data) {
        _data.removeAt(0);
        questionList = _data;
        fetchAnsweredQuestions();
        return _data;
      });

  Color getColour(var index) {
    var color = Colors.white;
    try {
      for (String answer in answerStrings) {
        if (answer.startsWith((index + 1).toString())) {
          if (answer.endsWith('ue')) {
            color = Colors.green[100]!;
          } else {
            color = Colors.red[100]!;
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return color;
  }

  void _setSelectedQuestion(var index, selectedQuestionTopics) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentQuestionIndex', index);

    // prefs.setInt('currentQuestionIndex', int.parse(index));
    Navigator.pushNamed(context, '/questions', arguments: {
      'index': index,
      'title': questionList[index].title,
      'selectedQuestionTopics': selectedQuestionTopics
    });
  }

  bool isThisQuestionInSelectedTopics(int index) {
    return (selectedQuestionTopics.contains(questionList[index].subject));
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: getQuestions(),
        builder: (context, snapshot) {
          final widgetQuestionList = questionList;
          final routeArgs = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          selectedQuestionTopics = routeArgs['selectedQuestionTopics'];
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(title: Text('Questions')),
                body: ListView.builder(
                    itemCount: 150,
                    itemBuilder: (context, index) {
                      return Visibility(
                          visible: (isThisQuestionInSelectedTopics(index)),
                          child: Card(
                              color: getColour(index),
                              child: ListTile(
                                  onTap: () => _setSelectedQuestion(
                                      index, selectedQuestionTopics),
                                  title: Text(widgetQuestionList[index].title),
                                  subtitle: Text(
                                      widgetQuestionList[index].subject))));
                    }));
          } else {
            // We can show the loading view until the data comes back.
            return CircularProgressIndicator();
          }
        },
      );
}

// Future<void> getOneQuestionForScreen() async {
//     final questionRetreived = await QuestionBank().getOneQuestion();
//     _question1 = questionRetreived;
//   }