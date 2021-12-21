import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Color.fromARGB(255, 196, 254, 248),
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: Color.fromARGB(255, 221, 226, 180), width: 2)),
  focusedBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: Color.fromARGB(255, 187, 184, 10), width: 2)),
);

enum quizStatus { not_started, commenced, complete }

class QuestionAnsweredItem {
  String? questionTopic = '';
  String? sessionTitle = '';
  bool? answeredCorrectly;
  int? chosenOption;
  DateTime? dateTime;

  QuestionAnsweredItem(
      {this.answeredCorrectly,
      this.questionTopic,
      this.sessionTitle,
      this.chosenOption,
      this.dateTime});

  QuestionAnsweredItem.fromJson(Map<String, dynamic> json)
      : questionTopic = json['questionTopic'],
        sessionTitle = json['sessionTitle'],
        answeredCorrectly = json['answeredCorrecly'] == true,
        chosenOption = int.parse(json['chosenOption']),
        dateTime = DateTime.tryParse(json['dateTime']);

  Map<String, dynamic> toJson() => {
        'questionTopic': questionTopic,
        'sessionTitle': sessionTitle,
        'answeredCorrectly': answeredCorrectly,
        'chosenOption': chosenOption,
        'dateTime': dateTime?.toIso8601String(),
      };
}
