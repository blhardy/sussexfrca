import 'package:SussexFRCA/models/question_model.dart';
import 'package:equatable/equatable.dart';

class QuizItem extends Equatable {
  Question queOC;
  bool answered = false;
  List<int> selectedOptions = [];
  DateTime dateTime;
  String? username;

  QuizItem(
      {required this.queOC,
      required this.answered,
      required this.selectedOptions,
      required this.dateTime,
      this.username});

  factory QuizItem.fromRTDB(Map<dynamic, dynamic> data) {
    return QuizItem(
        queOC: data['queOC'],
        answered: data['answered'] == true,
        selectedOptions: data['selectedOption'],
        dateTime: data['dateTime']);
  }

  @override
  List<Object?> get props => [queOC, answered, selectedOptions, dateTime];
}
