import 'package:equatable/equatable.dart';

class Question extends Equatable {
  String sessionName;
  String curriculumReference;
  String subject;
  String topic;
  String questionType;
  String questionStem;
  String questionText;
  List<String> options;
  String correctOption;
  String explanation;
  String imagePath;
  String references;

  Question({
    required this.sessionName,
    required this.curriculumReference,
    required this.subject,
    required this.topic,
    required this.questionType,
    required this.questionStem,
    required this.questionText,
    required this.options,
    required this.correctOption,
    required this.explanation,
    required this.imagePath,
    required this.references,
  });

  factory Question.fromRTDB(Map<dynamic, dynamic> data) {
    return Question(
      sessionName: data['SessionName'] ?? "",
      curriculumReference: data['CurriculumReference'] ?? "",
      subject: data['Specialty'] ?? "",
      topic: data['UniqueTopicName'] ?? "",
      questionType: data['QuestionType'] ?? "",
      questionStem: data['QuestionStem'] ?? "",
      questionText: data['QuestionText'] ?? "",
      options: data["OptionsSeparatedBySlash"].toString().split("/"),
      correctOption: data['CorrectOption'] ?? "",
      explanation: data['ExplanationText'] ?? "",
      imagePath: data['ExplanationImageLink'] ?? "",
      references: data['References'].toString(),
    );
  }

  String getOptionsFromRTDB(Map<dynamic, dynamic> data) {
    return "${data['option1']}/${data['option2']}/${data['option3']}/${data['option4']}/${data['option5']}";
  }

  @override
  List<Object?> get props => [
        subject,
        topic,
        questionType,
        questionStem,
        questionText,
        options,
        correctOption,
        explanation,
        imagePath,
        references
      ];
}
