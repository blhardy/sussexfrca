import 'package:shared_preferences/shared_preferences.dart';

class UserAnswerController {
  var answerStrings;

  Future<dynamic> getAnswerMap() async {
    setAnswerMapAsExamplesOnly();
    SharedPreferences.getInstance().then((prefs) {
      answerStrings = (prefs.getStringList('answerStrings'));
    });
    return answerStrings;
  }

  void setAnswerMapAsExamplesOnly() async {
    final prefs = await SharedPreferences.getInstance();
    var answerExamples = ['1,true', '2, true', '3,true', '5,true'];
    prefs.setStringList('answerStrings', answerExamples);
  }

  void _setAnswerMapExamplesAndNewlyAnswereds(
      int currentQuestionIndex, String answeredCorrectly) async {
    final prefs = await SharedPreferences.getInstance();
    getAnswerMap();
    answerStrings = ['1,true', '2, true', '3,true', '5,true'];
    answerStrings.add('$currentQuestionIndex, $answeredCorrectly');
    prefs.setStringList('answerStrings', answerStrings);
  }
}
