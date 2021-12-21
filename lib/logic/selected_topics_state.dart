part of 'selected_topics_cubit.dart';

class SelectedTopicsState {
  late bool includePhysio = true;
  late bool includePhysics = true;
  late bool includePharm = true;
  late bool questionAnswered = false;
  late var questionList;
  String currentQuestionTitle = '';
  int currentQuestionInt = 0;
  List<UserAnswer> userAnswers = [];

  SelectedTopicsState(
      {required this.includePhysio,
      required this.includePhysics,
      required this.questionAnswered,
      required this.includePharm,
      required this.currentQuestionTitle,
      required this.currentQuestionInt,
      required this.userAnswers});

  Map<String, dynamic> toMap() {
    return {
      'includePhysio': includePhysio.toString(),
      'includePhysics': includePhysics.toString(),
      'includePharm': includePharm.toString(),
      'questionAnswered': questionAnswered.toString(),
      'currentQuestionTitle': currentQuestionTitle.toString(),
      'currentQuestionIndex': currentQuestionInt.toString(),
      'userAnswers': json.encode(userAnswers)
    };
  }

  factory SelectedTopicsState.fromMap(Map<String, dynamic> map) {
    List<UserAnswer> userAnswerList = [];
    if (map['currentQuestionIndex'] != null) {
      userAnswerList = (json.decode(map['userAnswers']) as List)
          .map((a) => UserAnswer.fromJson(a))
          .toList();
    }

    return SelectedTopicsState(
        includePhysio: map['includePhysio'] == 'true',
        includePhysics: map['includePhysics'] == 'true',
        includePharm: map['includePharm'] == 'true',
        questionAnswered: map['questionAnswered'] == 'true',
        currentQuestionTitle: map['currentQuestionTitle'],
        currentQuestionInt: int.parse(map['currentQuestionIndex']),
        userAnswers: userAnswerList);
  }

  String toJson() => json.encode(toMap());

  factory SelectedTopicsState.fromJson(String source) =>
      SelectedTopicsState.fromMap(json.decode(source));
}
