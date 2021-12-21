import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'expansion_question_state.dart';

class ExpansionQuestionCubit extends Cubit<ExpansionQuestionState>
    with HydratedMixin {
  ExpansionQuestionCubit()
      : super(ExpansionQuestionState(
            selectedQuestionIndex: 0,
            selectedSubQuestionIndex: "A",
            selectedOption: "",
            expanded: false,
            subQuestionAnswered: false));

  void selectImage(int selQ, String selSubQ) {
    emit(ExpansionQuestionState(
        selectedQuestionIndex: selQ,
        selectedSubQuestionIndex: selSubQ,
        expanded: state.expanded,
        selectedOption: "",
        subQuestionAnswered: false));
  }

  void nextSubQuestion(int selQ, String selSubQ) {
    String tempSubQ;
    if (selSubQ == "A") {
      tempSubQ = "B";
    } else if (selSubQ == "B") {
      tempSubQ = "C";
    } else if (selSubQ == "C") {
      tempSubQ = "D";
    } else {
      tempSubQ = "D";
    }

    emit(ExpansionQuestionState(
        selectedQuestionIndex: selQ,
        selectedSubQuestionIndex: tempSubQ,
        expanded: false,
        selectedOption: "",
        subQuestionAnswered: false));
  }

  void selectOption(String selectedOption) {
    emit(ExpansionQuestionState(
        selectedQuestionIndex: state.selectedQuestionIndex,
        selectedSubQuestionIndex: state.selectedSubQuestionIndex,
        expanded: state.expanded,
        selectedOption: selectedOption,
        subQuestionAnswered: state.subQuestionAnswered));
  }

  int getSelectedQuestionIndex() {
    return state.selectedQuestionIndex;
  }

  @override
  void onChange(Change<ExpansionQuestionState> change) {
    super.onChange(change);
  }

  void initialiseExpandedQuestion(int index) {
    emit(ExpansionQuestionState(
        expanded: false,
        selectedQuestionIndex: index,
        selectedSubQuestionIndex: "A",
        selectedOption: "",
        subQuestionAnswered: false));
  }

  void expandOrContractObject() => {
        emit(ExpansionQuestionState(
            expanded: !state.expanded,
            selectedQuestionIndex: state.selectedQuestionIndex,
            selectedSubQuestionIndex: state.selectedSubQuestionIndex,
            selectedOption: "",
            subQuestionAnswered: state.subQuestionAnswered))
      };

  @override
  ExpansionQuestionState? fromJson(Map<String, dynamic> json) {}

  @override
  Map<String, dynamic>? toJson(ExpansionQuestionState state) {}
}
