import 'dart:math';
import 'package:SussexFRCA/components/arrow_components.dart';
import 'package:SussexFRCA/components/image_presenter.dart';
import 'package:SussexFRCA/components/party_drawer.dart';
import 'package:SussexFRCA/components/question_text_box.dart';
import 'package:SussexFRCA/models/quiz_item.dart';
import 'package:SussexFRCA/models/user_login.dart';
import 'package:SussexFRCA/question_screens/ChecklistScreen.dart';
import 'package:SussexFRCA/question_screens/InputTextScreen.dart';
import 'package:SussexFRCA/question_screens/LabellingInputScreen.dart';
import 'package:SussexFRCA/question_screens/MTFScreen.dart';
import 'package:SussexFRCA/question_screens/SBAScreen.dart';
import 'package:SussexFRCA/question_screens/ShowAnswer.dart';
import 'package:SussexFRCA/services/quiz_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';
import '../logic/selected_topics_cubit.dart';
import '../models/question_model.dart';
import '../models/userlogin_dao.dart';

// TODO Make the questionScreen pass the list of questions to the type of screen

class QuestionScreen extends StatefulWidget {
  @override
  QuestionScreenState createState() => QuestionScreenState();
}

class QuestionScreenState extends State<QuestionScreen> {
  var questionTitle;
  List<Question> questionList = [];
  List<QuizItem> questionGroup = [];
  bool expanded = false;
  late Question queOC;
  var options;
  var selectedOption;
  var answerSubmitted = false;
  var revealExplanation;
  var selectedQuestionTopics;
  var answeredCorrectly;
  var answerStrings;
  double opacityLevel = 1;
  var currentGroupIndex = 0;
  var selectedQuestionList = [];
  String nextQuestionText = 'Next Question';
  String answerSubmittedText = 'Submit Answer';

  @override
  void initState() {
    super.initState();
  }

  nextQuestion(context) {
    selectedOption = '';
    BlocProvider.of<SelectedTopicsCubit>(context).nextQuestion(context);
    setState(() {});
  }

  showExplanation(queOC) {
    revealExplanation = true;
  }

  void selectOption(String option, bool answerSubmitted) {
    if (!answerSubmitted) {
      setState(() {
        selectedOption = option;
      });
    }
  }

  void loadQuestion() {}

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var quizDatabase = QuizDatabaseService(uid: _auth.currentUser!.uid);
    questionGroup =
        BlocProvider.of<SelectedTopicsCubit>(context).getCurrentQuizItemGroup();

    queOC = questionGroup[currentGroupIndex].queOC;
    if (questionGroup[currentGroupIndex].answered) {
      answerSubmittedText = "Next Question";
    } else {
      answerSubmittedText = "Submit Answer";
    }
    var stc = BlocProvider.of<SelectedTopicsCubit>(context);
    return Scaffold(
        // endDrawer: PartyDrawerWidget(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "(${currentGroupIndex + 1} of ${questionGroup.length}) - ${questionGroup[currentGroupIndex].queOC.topic}",
            textAlign: TextAlign.left,
          ),
        ),
        bottomNavigationBar:
            BlocBuilder<SelectedTopicsCubit, SelectedTopicsState>(
          builder: (context, state) {
            return Container(
              height: 80,
              color: Colors.blue[600]!,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(""),
                    InkWell(
                        onTap: () {
                          if (currentGroupIndex > 0) {
                            setState(() =>
                                opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
                            Future.delayed(Duration(milliseconds: 100))
                                .then((value) => {
                                      currentGroupIndex -= 1,
                                      stc.setSelectedOption(10),
                                      answerSubmitted =
                                          questionGroup[currentGroupIndex]
                                              .answered,
                                      setState(() => opacityLevel =
                                          opacityLevel == 0 ? 1.0 : 0.0)
                                    });
                          }
                        },
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colors.white)),
                    InkWell(
                      onTap: () => {
                        if (questionGroup[currentGroupIndex]
                                .queOC
                                .questionType ==
                            "MTF")
                          {
                            if (!questionGroup[currentGroupIndex].answered)
                              {
                                quizDatabase.questionAnswered(
                                    stc.selectedQuiz,
                                    questionGroup[currentGroupIndex]
                                        .queOC
                                        .topic,
                                    stc.checkMTFAnswers(
                                        questionGroup[currentGroupIndex].queOC),
                                    10),
                                questionGroup[currentGroupIndex].username =
                                    stc.username,
                                questionGroup[currentGroupIndex].dateTime =
                                    DateTime.now(),
                                questionGroup[currentGroupIndex]
                                    .selectedOptions
                                    .add(stc.selectedOption),
                                questionGroup[currentGroupIndex].answered =
                                    true,
                              }
                            else if ((questionGroup[currentGroupIndex]
                                .answered))
                              {
                                answerSubmittedText = 'Submit Answer',
                                if (currentGroupIndex <
                                    questionGroup.length - 1)
                                  {
                                    setState(() => opacityLevel =
                                        opacityLevel == 0 ? 1.0 : 0.0),
                                    Future.delayed(Duration(milliseconds: 300))
                                        .then((value) => {
                                              stc.setSelectedOption(10),
                                              currentGroupIndex += 1,
                                              setState(() => opacityLevel =
                                                  opacityLevel == 0 ? 1.0 : 0.0)
                                            }),
                                  }
                                else
                                  {
                                    quizDatabase.questionAnswered(
                                        stc.selectedQuiz,
                                        questionGroup[currentGroupIndex]
                                            .queOC
                                            .topic,
                                        stc.checkMTFAnswers(
                                            questionGroup[currentGroupIndex]
                                                .queOC),
                                        stc.selectedOption),
                                    showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: Text("Complete Quiz?"),
                                              content: Text(
                                                  "Would you like to complete the quiz and submit your answers?"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      //submit quiz results
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              "/results");
                                                    },
                                                    child: Text('Yes')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('No'))
                                              ],
                                            ))
                                  }
                              }
                          },
                        if (questionGroup[currentGroupIndex]
                                .queOC
                                .questionType ==
                            "SBA")
                          {
                            if (questionGroup[currentGroupIndex].answered)
                              {
                                answerSubmittedText = 'Submit Answer',
                                if (currentGroupIndex <
                                    questionGroup.length - 1)
                                  {
                                    setState(() => opacityLevel =
                                        opacityLevel == 0 ? 1.0 : 0.0),
                                    Future.delayed(Duration(milliseconds: 100))
                                        .then((value) => {
                                              stc.setSelectedOption(10),
                                              currentGroupIndex += 1,
                                              setState(() => opacityLevel =
                                                  opacityLevel == 0 ? 1.0 : 0.0)
                                            }),
                                  }
                                else
                                  {
                                    quizDatabase.questionAnswered(
                                        stc.selectedQuiz,
                                        questionGroup[currentGroupIndex]
                                            .queOC
                                            .topic,
                                        stc.answeredCorrectly!,
                                        stc.selectedOption),
                                    showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: Text("Complete Quiz?"),
                                              content: Text(
                                                  "Would you like to complete the quiz and submit your answers?"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      //submit quiz results
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              "/results");
                                                    },
                                                    child: Text('Yes')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('No'))
                                              ],
                                            ))
                                  }
                              }
                            else
                              {
                                if (stc.selectedOption == 10)
                                  {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars(),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("Please select option")))
                                  }
                                else
                                  {
                                    quizDatabase.questionAnswered(
                                        stc.selectedQuiz,
                                        questionGroup[currentGroupIndex]
                                            .queOC
                                            .topic,
                                        stc.answeredCorrectly!,
                                        stc.selectedOption),
                                    questionGroup[currentGroupIndex].username =
                                        stc.username,
                                    questionGroup[currentGroupIndex].dateTime =
                                        DateTime.now(),
                                    questionGroup[currentGroupIndex]
                                        .selectedOptions
                                        .add(stc.selectedOption),
                                    questionGroup[currentGroupIndex].answered =
                                        true,
                                  }
                              }
                          },
                        setState(() => {})
                      },
                      child: Text(answerSubmittedText,
                          style: TextStyle(color: Colors.white, fontSize: 32)),
                    ),
                    InkWell(
                        onTap: () {
                          if (currentGroupIndex < questionGroup.length - 2) {
                            setState(() =>
                                opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
                            Future.delayed(Duration(milliseconds: 100))
                                .then((value) => {
                                      stc.setSelectedOption(10),
                                      currentGroupIndex += 1,
                                      setState(() => opacityLevel =
                                          opacityLevel == 0 ? 1.0 : 0.0)
                                    });
                          } else {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text("Complete Quiz?"),
                                      content: Text(
                                          "Would you like to complete the quiz and submit your answers?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              quizDatabase.questionAnswered(
                                                  stc.selectedQuiz,
                                                  questionGroup[
                                                          currentGroupIndex]
                                                      .queOC
                                                      .topic,
                                                  stc.answeredCorrectly!,
                                                  stc.selectedOption);
                                              stc.userloginDao
                                                  .updateSessionFinished(
                                                      stc.userLoginID,
                                                      stc.selectedQuiz);
                                              setState(() {});
                                              Navigator.of(context)
                                                  .pushNamed("/results");
                                            },
                                            child: Text('Yes')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('No'))
                                      ],
                                    ));
                          }
                        },
                        child: Icon(Icons.arrow_forward_ios_outlined,
                            color: Colors.white)),
                    Text(""),
                  ]),
            );
          },
        ),
        body: AnimatedOpacity(
          curve: Curves.fastOutSlowIn,
          duration: Duration(milliseconds: 400),
          opacity: opacityLevel,
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                height: 220,
                child: ListView.builder(
                    padding: EdgeInsets.only(left: 20),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: queOC.imagePath.split('~').toList().length + 1,
                    itemBuilder: (context, index) {
                      List<String> imagePaths =
                          queOC.imagePath.split('~').toList();
                      if (index == 0) {
                        return QuestionTextBox(
                            questionStem: queOC.questionStem,
                            questionText: queOC.questionText);
                      } else {
                        return ImagePresenter(
                            imageAddress: imagePaths[index - 1]);
                      }
                    }),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: BlocBuilder<SelectedTopicsCubit, SelectedTopicsState>(
                      builder: (context, state) {
                    switch (queOC.questionType) {
                      case "SBA":
                        return SBAScreen(
                            quizItem: questionGroup[currentGroupIndex]);
                      case "Checklist":
                        return ChecklistScreen(
                            queOC: queOC,
                            answerSubmitted: answerSubmitted,
                            expanded: expanded);
                      case "InputText":
                        return InputTextScreen(
                            queOC: queOC,
                            answerSubmitted: answerSubmitted,
                            expanded: expanded);
                      case "LabellingInput":
                        return LabellingInputScreen(
                            queOC: queOC,
                            answerSubmitted: answerSubmitted,
                            expanded: expanded);
                      case "ShowAnswer":
                        return ShowAnswerScreen(
                            queOC: queOC,
                            answerSubmitted: answerSubmitted,
                            expanded: expanded);
                      case "MTF":
                        return MTFScreen(
                            quizItem: questionGroup[currentGroupIndex]);
                      default:
                        return SBAScreen(
                            quizItem: questionGroup[currentGroupIndex]);
                    }
                  })),
            ]),
          ),
        ));
  }
}
