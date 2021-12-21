part of 'expansion_question_cubit.dart';

// ignore: must_be_immutable
class ExpansionQuestionState extends Equatable {
  int selectedQuestionIndex = 0;
  String selectedSubQuestionIndex = "A";
  String selectedOption;
  bool expanded = false;
  bool subQuestionAnswered = false;

  ExpansionQuestionState(
      {required this.selectedQuestionIndex,
      required this.selectedSubQuestionIndex,
      required this.expanded,
      required this.selectedOption,
      required this.subQuestionAnswered});

  @override
  List<Object?> get props =>
      [selectedQuestionIndex, selectedSubQuestionIndex, expanded];
}
