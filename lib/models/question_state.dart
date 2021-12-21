import 'package:SussexFRCA/models/question_model.dart';
import 'package:equatable/equatable.dart';

abstract class QuestionState extends Equatable {}

class InitialState extends QuestionState {
  @override
  List<Object> get props => [];
}

class LoadingState extends QuestionState {
  @override
  List<Object> get props => [];
}

class LoadedState extends QuestionState {
  LoadedState(this.questionList);

  final List<Question> questionList;

  @override
  List<Object> get props => [questionList];
}

class ErrorState extends QuestionState {
  @override
  List<Object> get props => [];
}
