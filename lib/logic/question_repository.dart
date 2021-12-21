import 'package:SussexFRCA/models/session_and_passcode.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/question_model.dart';

class QuestionRepository {
  List<String> physics1QuestionTopics = [];
  List<String> physics2QuestionTopics = [];
  List<String> pharm1QuestionTopics = [];
  List<String> pharm2QuestionTopics = [];
  List<String> physio1QuestionTopics = [];
  List<String> physio2QuestionTopics = [];
  List<Question> physics1Questions = [];
  List<Question> physics2Questions = [];
  List<Question> pharm1Questions = [];
  List<Question> pharm2Questions = [];
  List<Question> physio1Questions = [];
  List<Question> physio2Questions = [];
  List<SessionAndPasscode> sessionsAndPasscodes = [];
  String courseName = "";

//Change "Feb22"
  Future<List<Question>> getQuestionsFromGSheet() async {
    //Getting Feb22 questions
    getPasscodes();
    List<Question> _quizQuestions = [];
    final List<dynamic> _questionRef1 = (await FirebaseDatabase.instance
            .ref()
            .child('1SrJy1MxkEIMZdSC09kahMKvvTqKELrivCoyu206IeLw/Feb22')
            .once())
        .snapshot
        .value as List<dynamic>;
    _questionRef1.forEach((questionPart) {
      if (questionPart != null) {
        _quizQuestions.add(Question.fromRTDB(questionPart));
      }
    });
    getSeparateQuizzesFromDB(_quizQuestions);

    return _quizQuestions;
  }

  getPasscodes() async {
    sessionsAndPasscodes = [];
    DatabaseReference _passcodeRef = FirebaseDatabase.instance
        .ref('1SrJy1MxkEIMZdSC09kahMKvvTqKELrivCoyu206IeLw/Admin');
    DatabaseEvent event = await _passcodeRef.once();
    List<dynamic> _tobeMapped = event.snapshot.value as List<dynamic>;
    _tobeMapped.forEach((questionPart) {
      if (questionPart != null) {
        sessionsAndPasscodes.add(SessionAndPasscode.fromRTDB(questionPart));
      }
    });
  }

  void resetTopicLists() {
    physics1QuestionTopics = [];
    physics2QuestionTopics = [];
    pharm1QuestionTopics = [];
    pharm2QuestionTopics = [];
    physio1QuestionTopics = [];
    physio2QuestionTopics = [];
    physics1Questions = [];
    physics2Questions = [];
    pharm1Questions = [];
    pharm2Questions = [];
    physio1Questions = [];
    physio2Questions = [];
  }

  void getSeparateQuizzesFromDB(List<Question> _quizQuestions) {
    resetTopicLists();

    for (Question q in _quizQuestions) {
      switch (q.sessionName) {
        case "Physics1":
          physics1Questions.add(q);
          physics1QuestionTopics.add(q.topic);
          break;
        case "Physics2":
          physics2Questions.add(q);
          physics2QuestionTopics.add(q.topic);
          break;
        case "Physio1":
          physio1Questions.add(q);
          physio1QuestionTopics.add(q.topic);
          break;
        case "Physio2":
          physio2Questions.add(q);
          physio2QuestionTopics.add(q.topic);
          break;
        case "Pharm1":
          pharm1Questions.add(q);
          pharm1QuestionTopics.add(q.topic);
          break;
        case "Pharm2":
          pharm2Questions.add(q);
          pharm2QuestionTopics.add(q.topic);
          break;
      }
    }
  }
}
