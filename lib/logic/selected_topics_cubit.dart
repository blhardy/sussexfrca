import 'dart:convert';
import 'package:SussexFRCA/logic/question_repository.dart';
import 'package:SussexFRCA/models/quiz_item.dart';
import 'package:SussexFRCA/models/session_and_passcode.dart';
import 'package:SussexFRCA/models/user_answer_model.dart';
import 'package:SussexFRCA/models/question_model.dart';
import 'package:SussexFRCA/models/user_login.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/userlogin_dao.dart';
part 'selected_topics_state.dart';

class SelectedTopicsCubit extends Cubit<SelectedTopicsState>
    with HydratedMixin {
  SelectedTopicsCubit()
      : super(SelectedTopicsState(
            includePhysio: true,
            includePharm: true,
            includePhysics: true,
            questionAnswered: false,
            currentQuestionTitle: '',
            currentQuestionInt: 0,
            userAnswers: []));
  var myData;
  var selectedTopics;
  String selectedQuiz = '';
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
  List<QuizItem> physics1QuizItems = [];
  List<QuizItem> physics2QuizItems = [];
  List<QuizItem> pharm1QuizItems = [];
  List<QuizItem> pharm2QuizItems = [];
  List<QuizItem> physio1QuizItems = [];
  List<QuizItem> physio2QuizItems = [];
  List<String> station5Topics = [];
  ScrollController scrollController = ScrollController();
  final userloginDao = UserLoginDao();
  var selectedOption = 10;
  String sbaOrCRQ = '';
  List<Question> filteredQuestions = [];
  List<String> questionTopics = [];
  var questionData;
  final repository = QuestionRepository();
  List<Question> questionGroup = [];
  List<SessionAndPasscode> passcodes = [];
  List<QuizItem> sessionAnswers = [];
  String username = '';
  String userLoginID = '';
  int totalAnsweredThisSession = 0;
  int noAnsweredCorrectly = 0;
  bool? answeredCorrectly;
  DateTime dateTime =
      DateTime(DateTime.now().day, DateTime.now().month, DateTime.now().year);
  String physics1status = '';
  String physics2status = '';
  String physiol1status = '';
  String physiol2status = '';
  String pharm1status = '';
  String pharm2status = '';
  var mtfSelections = ['F', 'F', 'F', 'F', 'F'];

  void setMTFSelection(int index, String value) {
    mtfSelections[index] = value;
  }

  bool checkMTFAnswers(Question queOC) {
    int correctAnswers = 0;
    List<String> answers = queOC.correctOption.split(',');
    for (int index in [0, 1, 2, 3, 4]) {
      if (answers[index] == mtfSelections[index]) {
        correctAnswers += 1;
      }
    }
    if (correctAnswers > 2) {
      return true;
    } else {
      return false;
    }
  }

  void setUsername(String userName) {
    username = userName.trim();
  }

  void setAnswerTotals(int total, int correct) {
    totalAnsweredThisSession = total;
    noAnsweredCorrectly = correct;
  }

  void setSelectedOption(int option) {
    selectedOption = option;
  }

  void setAnsweredCorrectly() {
    answeredCorrectly = true;
  }

  void setAnsweredIncorrectly() {
    answeredCorrectly = false;
  }

  int get getSelectedOption {
    return selectedOption;
  }

  void clearUserAnswers() {}

  List<QuizItem> get getUserAnswers {
    return sessionAnswers;
  }

  QuizItem makeQuizItem(Question queOC) {
    return QuizItem(
        queOC: queOC,
        answered: false,
        selectedOptions: [],
        dateTime: DateTime.now());
  }

  void setUserLoginID() async {
    userloginDao.getIDForUserLogin().then((value) {
      userLoginID = value.toString();
      userloginDao.saveLogin(UserLogin(
          username, DateTime.now(), selectedQuiz, false, userLoginID));
    });
  }

  List<QuizItem> makeQuizItemList(List<Question> questionList) {
    return questionList.map((e) => makeQuizItem(e)).toList();
  }

  Future<List<String>> initialiseRepo() async {
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    // var quizDatabase = QuizDatabaseService(uid: _auth.currentUser!.uid);
    // List<String> sessionStatuses = quizDatabase.getSessionStatus();
    // pharm1status = sessionStatuses[0];
    // pharm2status = sessionStatuses[1];
    // physics1status = sessionStatuses[2];
    // physics2status = sessionStatuses[3];
    // physiol1status = sessionStatuses[4];
    // physiol2status = sessionStatuses[5];

    await repository.getQuestionsFromGSheet();
    physics1Questions = repository.physics1Questions;
    physics1QuizItems = makeQuizItemList(physics1Questions);
    physics1QuestionTopics = repository.physics1QuestionTopics;
    physics2Questions = repository.physics2Questions;
    physics2QuizItems = makeQuizItemList(physics2Questions);
    physics2QuestionTopics = repository.physics2QuestionTopics;
    physio1Questions = repository.physio1Questions;
    physio1QuizItems = makeQuizItemList(physio1Questions);
    physio1QuestionTopics = repository.physio1QuestionTopics;
    physio2Questions = repository.physio2Questions;
    physio2QuizItems = makeQuizItemList(physio2Questions);
    physio2QuestionTopics = repository.physio2QuestionTopics;
    pharm1Questions = repository.pharm1Questions;
    pharm1QuizItems = makeQuizItemList(pharm1Questions);
    pharm1QuestionTopics = repository.pharm1QuestionTopics;
    pharm2Questions = repository.pharm2Questions;
    pharm2QuizItems = makeQuizItemList(pharm2Questions);
    pharm2QuestionTopics = repository.pharm2QuestionTopics;
    passcodes = repository.sessionsAndPasscodes;
    return pharm2QuestionTopics;
  }

  void setSelectedQuiz(String station) {
    selectedQuiz = station;
  }

  void setSBAorCRQ(String questionType) {
    sbaOrCRQ = questionType;
  }

  List<QuizItem> getCurrentQuizItemGroup() {
    List<QuizItem> qs = [];
    switch (selectedQuiz) {
      case "Physics1":
        return physics1QuizItems;
      case "Physics2":
        return physics2QuizItems;
      case "Pharm1":
        return pharm1QuizItems;
      case "Pharm2":
        return pharm2QuizItems;
      case "Physio1":
        return physio1QuizItems;
      case "Physio2":
        return physio2QuizItems;
    }
    return qs;
  }

  String getQuestionSubjectFromTitle(String title) {
    return (filteredQuestions.firstWhere((element) => element.topic == title))
        .subject;
  }

  void setSelectedQuestionString(String title) => {
        emit(SelectedTopicsState(
            includePhysio: state.includePhysio,
            includePharm: state.includePharm,
            includePhysics: state.includePhysics,
            questionAnswered: false,
            currentQuestionInt:
                filteredQuestions.indexWhere((e) => e.topic == title),
            currentQuestionTitle: title,
            userAnswers: state.userAnswers))
      };

  void setQuestionIndex(int index) => {
        emit(SelectedTopicsState(
            includePhysio: state.includePhysio,
            includePharm: state.includePharm,
            includePhysics: state.includePhysics,
            questionAnswered: false,
            currentQuestionInt: index,
            currentQuestionTitle: filteredQuestions[index].topic,
            userAnswers: state.userAnswers))
      };

  List<dynamic> getSelectedTopics() {
    var _selectedTopics = [];
    if (state.includePhysio) {
      _selectedTopics.add('Physiology & Anatomy');
    }
    if (state.includePhysics) {
      _selectedTopics.add('Physics & Equipment');
    }
    if (state.includePharm) {
      _selectedTopics.add('Pharmacology & Statistics');
    }
    return _selectedTopics;
  }

  void answerSubmitted() => {
        emit(SelectedTopicsState(
            includePhysio: state.includePhysio,
            includePharm: state.includePharm,
            includePhysics: state.includePhysics,
            questionAnswered: true,
            currentQuestionInt: state.currentQuestionInt,
            currentQuestionTitle: state.currentQuestionTitle,
            userAnswers: state.userAnswers))
      };

  Future<List<Question>> getFilteredQuestions() async {
    selectedTopics = getSelectedTopics();
    var _questions = await repository.getQuestionsFromGSheet();
    List<Question> _filteredQuestions = [];
    for (var question in _questions) {
      _filteredQuestions.add(question);
    }
    filteredQuestions = _filteredQuestions;
    for (var question in filteredQuestions) {
      if (!questionTopics.contains(question.topic)) {
        questionTopics.add(question.topic);
      }
    }
    return filteredQuestions;
  }

  void nextQuestion(context) => {
        if (state.currentQuestionInt < filteredQuestions.length - 1 &&
            state.currentQuestionTitle ==
                filteredQuestions[state.currentQuestionInt += 1].topic)
          {
            emit(SelectedTopicsState(
                includePhysio: state.includePhysio,
                includePharm: state.includePharm,
                includePhysics: state.includePhysics,
                questionAnswered: false,
                currentQuestionInt: state.currentQuestionInt += 1,
                currentQuestionTitle:
                    filteredQuestions[state.currentQuestionInt].topic,
                userAnswers: state.userAnswers))
          }
        else
          {Navigator.pushNamed(context, '/questionsList', arguments: [])}
      };

  void flipPhysio() => {
        emit(SelectedTopicsState(
            includePhysio: !state.includePhysio,
            includePharm: state.includePharm,
            includePhysics: state.includePhysics,
            questionAnswered: state.questionAnswered,
            currentQuestionInt: state.currentQuestionInt,
            currentQuestionTitle: state.currentQuestionTitle,
            userAnswers: state.userAnswers))
      };

  void addAnswerToStorage(UserAnswer userAnswer) {
    state.userAnswers.add(userAnswer);
  }

  void flipPharm() => {
        emit(SelectedTopicsState(
            includePhysio: state.includePhysio,
            includePharm: !state.includePharm,
            includePhysics: state.includePhysics,
            questionAnswered: state.questionAnswered,
            currentQuestionInt: state.currentQuestionInt,
            currentQuestionTitle: state.currentQuestionTitle,
            userAnswers: state.userAnswers))
      };

  void flipPhysics() => {
        emit(SelectedTopicsState(
            includePhysio: state.includePhysio,
            includePharm: state.includePharm,
            includePhysics: !state.includePhysics,
            questionAnswered: state.questionAnswered,
            currentQuestionInt: state.currentQuestionInt,
            currentQuestionTitle: state.currentQuestionTitle,
            userAnswers: state.userAnswers))
      };

  int getCurrentQuestionIndex() {
    return state.currentQuestionInt;
  }

  @override
  SelectedTopicsState? fromJson(Map<String, dynamic> json) {
    return SelectedTopicsState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SelectedTopicsState state) {
    return state.toMap();
  }
}
