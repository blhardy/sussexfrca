// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAnswer _$UserAnswerFromJson(Map<String, dynamic> json) => UserAnswer(
      questionTopic: json['questionTopic'] as String,
      answeredCorrectly: json['answeredCorrectly'] as bool,
      dateTime: DateTime.parse(json['dateTime']),
      chosenOption: json['chosenOption'] as int,
      sessionTitle: json['sessionTitle'] as String,
    );

Map<String, dynamic> _$UserAnswerToJson(UserAnswer instance) =>
    <String, dynamic>{
      'questionTopic': instance.questionTopic,
      'answeredCorrectly': instance.answeredCorrectly,
    };
