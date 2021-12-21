part of 'question_screen_cubit.dart';

class QuestionScreenState {
  late Question currentQuestion;
  late Option selectedOption;

  QuestionScreenState();
}

class InitialState extends QuestionScreenState {
  List<Object> get props => [];
}
