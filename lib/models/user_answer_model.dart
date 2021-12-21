import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_answer_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserAnswer extends Equatable {
  String questionTopic;
  bool answeredCorrectly;
  String sessionTitle;
  DateTime dateTime;
  int chosenOption;

  UserAnswer(
      {required this.questionTopic,
      required this.answeredCorrectly,
      required this.sessionTitle,
      required this.dateTime,
      required this.chosenOption});

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.questionTopic,
        this.answeredCorrectly,
        this.sessionTitle,
        this.dateTime,
        this.chosenOption
      ];

  factory UserAnswer.fromJson(Map<String, dynamic> json) =>
      _$UserAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$UserAnswerToJson(this);
}
