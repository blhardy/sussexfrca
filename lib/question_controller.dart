import 'package:easyfrca/question_bank.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

// We use get package for our state management

class QuestionController extends GetxController {
  // Lets animated our progress bar

  late PageController _pageController;
  PageController get pageController => this._pageController;
  var questionBank = new QuestionBank();

  List<Question> get questions => this.questionBank.questions;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  late String _correctAns;
  String get correctAns => this._correctAns;

  late String _selectedAns;
  String get selectedAns => this._selectedAns;

  // for more about obs please check documentation
  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    _pageController = PageController();
    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _pageController.dispose();
  }
}
  // void submitAnswer(Question question, String selectedAnswer) {
  //   // because once user press any option then it will run
  //   _isAnswered = true;
  //   _correctAns = question.correctAnswer;
  //   _selectedAns = selectedAnswer;
  // }

//   void nextQuestion() {
//     if (_questionNumber.value != questions.length) {
//       _isAnswered = false;
//       _pageController.nextPage(
//           duration: Duration(milliseconds: 250), curve: Curves.ease);
//     }

//     void updateTheQnNum(int index) {
//       _questionNumber.value = index + 1;
//     }
//   }
// }
