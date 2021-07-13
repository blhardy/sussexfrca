import 'dart:async';
import 'package:easyfrca/components/questionCard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './question_bank.dart';
import 'components/option.dart';
import 'constants.dart';

//TODO make sure that something happens at the end of the question list, no more questions screen

class QuestionsScreen extends StatefulWidget {
  @override
  QuestionsScreenState createState() => QuestionsScreenState();
}

class QuestionsScreenState extends State<QuestionsScreen> {
  var questionTitle;
  var questionList;
  var queOC;
  var options;
  var selectedOption;
  var answerSubmitted = false;
  var revealExplanation;
  var selectedQuestionTopics;
  var answeredCorrectly;
  var answerStrings;
  var currentQuestionIndex;
  var selectedQuestionList = [];
  String nextQuestionText = 'Next Question';

  @override
  void initState() {
    super.initState();
    _getCurrentQuestionIndex();
    _loadAnswerMap();
  }

  updateSelectedQuestionCount() {
    for (Question question in questionList) {
      if (selectedQuestionTopics
          .contains(questionList[currentQuestionIndex].subject)) {}
    }
  }

  nextQuestion(queOC) {
    if (currentQuestionIndex + 1 == questionList.length) {
      print('Almost end of the quiz');
      nextQuestionText = 'End Quiz';
    } else if (currentQuestionIndex == questionList.length) {
      print('End of the quiz');
      nextQuestionText = 'End Quiz';
      Navigator.pushNamed(context, '/questionsList');
    }
    setState(() {
      answerSubmitted = false;
      selectedOption = '';
      getNextQuestionIndex();
      getQuestions();
    });
  }

  showExplanation(queOC) {
    revealExplanation = true;
  }

  void _setAnswerSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _loadAnswerMap();
    var indexPlusOne = currentQuestionIndex + 1;
    answerStrings.add('$indexPlusOne, $answeredCorrectly');
    prefs.setStringList('answerStrings', answerStrings);
  }

  void _loadAnswerMap() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      answerStrings = (prefs.getStringList('answerStrings'));
    });
  }

  void submitAnswer(Question question, String selectedAnswer) {
    selectedOption = selectedAnswer;
    if (question.correctAnswer == selectedAnswer) {
      answeredCorrectly = 'true';
    } else {
      answeredCorrectly = 'false';
    }
    _setAnswerSharedPreferences();
    setState(() {
      answerSubmitted = true;
    });
  }

  void _getCurrentQuestionIndex() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentQuestionIndex = (prefs.getInt('currentQuestionIndex') ?? 0);
    });
  }

  void getQuestions() async {
    var questList = await questionBank.getQuestionsAsync();
    questList.removeAt(0);
    for (Question question in questList) {
      if (selectedQuestionTopics
          .contains(questList[currentQuestionIndex].subject)) {
        selectedQuestionList.add(question);
      }
    }
    setState(() {
      questionList = (selectedQuestionList);
      queOC = questionList[currentQuestionIndex];
    });
  }

  void getNextQuestionIndex() async {
    currentQuestionIndex += 1;
    while (!selectedQuestionTopics
        .contains(selectedQuestionList[currentQuestionIndex].subject)) {
      currentQuestionIndex += 1;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentQuestionIndex', currentQuestionIndex);
    setState(() {});
  }

  var questionBank = new QuestionBank();

  Color getOptionColor(String option) {
    Color cardColor = Colors.white;
    if (selectedOption == option && !answerSubmitted) {
      return Colors.blue[100]!;
    } else if (answerSubmitted) {
      if (option == queOC.correctAnswer) {
        return Colors.green[100]!;
      } else if (option == selectedOption && option != queOC.correctAnswer) {
        return Colors.red[100]!;
      }
    }
    return cardColor;
  }

  void selectOption(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    questionTitle = routeArgs['title'];
    selectedQuestionTopics = routeArgs['selectedQuestionTopics'];
    getQuestions();

    return Scaffold(
      appBar: AppBar(title: Text('SBA Revision')),
      bottomNavigationBar: Container(
        color: Colors.purple[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: (!answerSubmitted),
              child: Container(
                  margin: EdgeInsets.only(top: kDefaultPadding),
                  padding: EdgeInsets.all(kDefaultPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                      onPressed: () => submitAnswer(queOC, selectedOption),
                      child: Text('Submit Answer'))),
            ),
            Visibility(
                visible: (answerSubmitted),
                child: Row(children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.purple[400]!),
                      onPressed: () => nextQuestion(queOC),
                      child: Text(nextQuestionText,
                          style: TextStyle(color: Colors.white))),
                ]))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(children: [
            QuestionCard(questionText: queOC.question),
            InkWell(
              child: Option(
                  optionText: queOC.option1,
                  optionColor: getOptionColor(queOC.option1)),
              onTap: () => selectOption(queOC.option1),
            ),
            InkWell(
              child: Option(
                  optionText: queOC.option2,
                  optionColor: getOptionColor(queOC.option2)),
              onTap: () => selectOption(queOC.option2),
            ),
            InkWell(
              child: Option(
                  optionText: queOC.option3,
                  optionColor: getOptionColor(queOC.option3)),
              onTap: () => selectOption(queOC.option3),
            ),
            InkWell(
              child: Option(
                  optionText: queOC.option4,
                  optionColor: getOptionColor(queOC.option4)),
              onTap: () => selectOption(queOC.option4),
            ),
            InkWell(
              child: Option(
                  optionText: queOC.option5,
                  optionColor: getOptionColor(queOC.option5)),
              onTap: () => selectOption(queOC.option5),
            ),
            Visibility(
                visible: (answerSubmitted),
                child: Container(
                    child: Card(
                        margin: kDefaultMargin,
                        elevation: 5,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.network(
                                queOC.image,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Text('-------------------');
                                },
                              ),
                              Text(
                                queOC.title + ' Explanation',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(queOC.explanation))
                            ]))))
          ]),
        ),
      ),
    );
  }
}






// Future<void> getOneQuestionForScreen() async {
//     final questionRetreived = await QuestionBank().getOneQuestion();
//     _question1 = questionRetreived;
//   }