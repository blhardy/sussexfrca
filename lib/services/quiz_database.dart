import 'package:SussexFRCA/logic/selected_topics_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/shared_styles.dart';

class QuizDatabaseService {
  int noTotalQuestionsAnswered = 0;
  int noCorrectlyAnsweredQuestions = 0;
  String uid = '';

  QuizDatabaseService({required this.uid});
  //collection reference
  final CollectionReference quizReference =
      FirebaseFirestore.instance.collection('quiz_details');

  Future updateUserData(
      String firstName,
      String physics1status,
      String physics2status,
      String physio1status,
      String physio2status,
      String pharm1status,
      String pharm2status,
      Map<String, QuestionAnsweredItem> questionsAnsweredList) async {
    return quizReference.doc(uid).set({
      'firstName': firstName,
      'physics1status': physics1status,
      'physics2status': physics2status,
      'physio1status': physio1status,
      'physio2status': physio2status,
      'pharm1status': pharm1status,
      'pharm2status': pharm2status,
      'questionsAnsweredList': questionsAnsweredList
    });
  }

  //Add question answered item to list
  Future questionAnswered(String sessionTitle, String questionTopic,
      bool answeredCorrectly, int chosenOption) async {
    QuestionAnsweredItem item = QuestionAnsweredItem(
        answeredCorrectly: answeredCorrectly,
        questionTopic: questionTopic,
        sessionTitle: sessionTitle,
        chosenOption: chosenOption,
        dateTime: DateTime.now());
    return quizReference
        .doc('$uid')
        .update({'questionsAnsweredList.${item.questionTopic}': item.toJson()})
        .then((value) => print("Question added"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  //quiz has commenced
  Future quizCommenced(String sessionTitle) async {
    return quizReference
        .doc(uid)
        .update({'${sessionTitle}status': 'commenced'})
        .then((value) => print("quizStatus Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  //quizfinished
  Future quizComplete(String sessionTitle) async {
    return quizReference
        .doc(uid)
        .update({'${sessionTitle}status': 'complete'})
        .then((value) => print("quizStatus: Complete"))
        .catchError((error) => print("Failed to update quiz status: $error"));
  }

  int get getNoTotalQuestions {
    return noTotalQuestionsAnswered;
  }

  int get getNoCorrectAnswers {
    return noCorrectlyAnsweredQuestions;
  }

  // List<String> getSessionStatus() {
  //   List<String> sessionStatuses = [];
  //   sessionStatuses.add(quizReference.doc('$uid/pharm1status').get() as String);
  //   sessionStatuses.add(quizReference.doc('$uid/pharm2status').get() as String);
  //   sessionStatuses
  //       .add(quizReference.doc('$uid/physics1status').get() as String);
  //   sessionStatuses
  //       .add(quizReference.doc('$uid/physics2status').get() as String);
  //   sessionStatuses
  //       .add(quizReference.doc('$uid/physiol1status').get() as String);
  //   sessionStatuses
  //       .add(quizReference.doc('$uid/physiol2status').get() as String);
  //   print(sessionStatuses);
  //   return sessionStatuses;
  // }

  //get number of times option was selected

  //Get total questions answered
  Future calculateAnsweredQuestions(context) {
    var stc = BlocProvider.of<SelectedTopicsCubit>(context);
    noTotalQuestionsAnswered = 0;
    noCorrectlyAnsweredQuestions = 0;
    Map<String, dynamic> answerMap;
    return quizReference.doc(uid).get().then((DocumentSnapshot snapshot) => {
          answerMap = snapshot['questionsAnsweredList'] as Map<String, dynamic>,
          answerMap.forEach((key, value) {
            if (value['sessionTitle'] == stc.selectedQuiz) {
              noTotalQuestionsAnswered += 1;
              if (value.toString().contains('true')) {
                noCorrectlyAnsweredQuestions += 1;
              }
            }
          }),
          stc.setAnswerTotals(
              noTotalQuestionsAnswered, noCorrectlyAnsweredQuestions),
          print(
              "total questions: $noTotalQuestionsAnswered, and correct: $noCorrectlyAnsweredQuestions")
        });
  }
}
