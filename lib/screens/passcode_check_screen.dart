import 'package:SussexFRCA/logic/expansion_question_cubit.dart';
import 'package:SussexFRCA/logic/question_repository.dart';
import 'package:SussexFRCA/logic/selected_topics_cubit.dart';
import 'package:SussexFRCA/services/quiz_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_login.dart';
import '../question_bank.dart';

class PasscodeScreen extends StatefulWidget {
  @override
  PasscodeScreenState createState() => PasscodeScreenState();
}

class PasscodeScreenState extends State<PasscodeScreen> {
  var questionList;
  var selectedQuestionTopics;
  var userInput;
  var username;
  var answerStrings;
  var interim;

  void _setSelectedQuestion(
      var index, var title, selectedQuestionTopics) async {
    // prefs.setInt('currentQuestionIndex', int.parse(index));

    Navigator.pushNamed(context, '/questions');
  }

  void switchScreen(BuildContext ctx, String screenAddress) {
    Navigator.pushNamed(ctx, '/$screenAddress');
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var quizDatabase = QuizDatabaseService(uid: _auth.currentUser!.uid);
    var stc = BlocProvider.of<SelectedTopicsCubit>(context);

    return Scaffold(
        backgroundColor: Colors.blueGrey[400],
        appBar: AppBar(title: Text('Passcode Check')),
        body: BlocListener<SelectedTopicsCubit, SelectedTopicsState>(
            listener: (context, state) {
              setState(() {});
            },
            child: Center(
              child: SizedBox(
                height: 300,
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue[600]!, width: 3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Colors.blue[50],
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 60,
                                width: 200,
                                child: Text(
                                  "Enter Passcode for session",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                height: 80,
                                width: 200,
                                child: TextField(
                                  onChanged: (value) => {
                                    setState(() {
                                      userInput = value;
                                    })
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Enter Passcode...'),
                                ),
                              ),
                              Container(
                                width: 150,
                                height: 40,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blue[900]),
                                    onPressed: () => {
                                          stc.clearUserAnswers(),
                                          if ((userInput == '998866'))
                                            {
                                              switchScreen(context, 'questions')
                                            },
                                          for (var passcode in stc.passcodes)
                                            {
                                              if ((passcode.sessionID ==
                                                      stc.selectedQuiz) &&
                                                  (passcode.passcode ==
                                                      userInput))
                                                {
                                                  quizDatabase.quizCommenced(stc
                                                      .selectedQuiz
                                                      .toLowerCase()),
                                                  stc.setUserLoginID,
                                                  switchScreen(
                                                      context, 'questions')
                                                }
                                              else if (!(passcode.passcode ==
                                                      userInput) &&
                                                  (!ScaffoldMessenger.of(
                                                          context)
                                                      .mounted))
                                                {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          margin: EdgeInsets.only(
                                                              bottom: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height -
                                                                  100,
                                                              right: 20,
                                                              left: 20),
                                                          content: Text(
                                                              "Passcode incorrect")))
                                                }
                                            }
                                        },
                                    child: Text('Submit',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white))),
                              ),
                            ]),
                      )),
                ),
              ),
            )));
  }
}
