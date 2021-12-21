import 'package:SussexFRCA/components/user_result_charts.dart';
import 'package:SussexFRCA/main.dart';
import 'package:SussexFRCA/models/quiz_item.dart';
import 'package:SussexFRCA/screens/wrapper.dart';
import 'package:SussexFRCA/services/quiz_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:SussexFRCA/logic/selected_topics_cubit.dart';

import '../components/personal_result.dart';

class ResultScreen extends StatefulWidget {
  @override
  ResultScreenState createState() => ResultScreenState();
}

class ResultScreenState extends State<ResultScreen> {
  var questionList;
  var selectedQuestionTopics;
  var userInput;
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
    var stc = BlocProvider.of<SelectedTopicsCubit>(context);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    QuizDatabaseService qdb = QuizDatabaseService(uid: _auth.currentUser!.uid);

    return FutureBuilder<dynamic>(
      future: qdb.calculateAnsweredQuestions(context),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
              // endDrawer: PartyDrawerWidget(),

              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text('Results Screen')),
              body: BlocListener<SelectedTopicsCubit, SelectedTopicsState>(
                  listener: (context, state) {
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                          Colors.red,
                          Colors.blue,
                          Colors.green,
                        ])),
                    child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            if (stc.totalAnsweredThisSession > 1)
                              PersonalResultChart(),
                            UserResultCharts(),
                            Container(
                              width: 250,
                              height: 60,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      side: BorderSide(
                                          width: 2, color: Colors.yellow),
                                      primary:
                                          Color.fromARGB(255, 200, 123, 45)),
                                  onPressed: () => {
                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title: Text("Complete Quiz?"),
                                                  content: Text(
                                                      "Go to the home screen? You will need to complete the quiz again to view the results."),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Wrapper()));
                                                        },
                                                        child: Text('Yes')),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('No'))
                                                  ],
                                                )),
                                      },
                                  child: Text('Back to Home Screen',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white))),
                            )
                          ])),
                    ),
                  )));
        }

        return Text("loading");
      },
    );
  }
}
