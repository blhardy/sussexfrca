import 'dart:core';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class QuestionBank {
  List<Question> questions = [];
  var questionsList;
  List<List<dynamic>> rowsAsListOfValues = [];
  var questionData;
  var myData;

  QuestionBank() {
    questionsList = getQuestionsAsync();
  }

  Future<List<dynamic>> loadAsset() async {
    final _rawData = await rootBundle.loadString("assets/PrimarySBA.csv");
    List<List<dynamic>> _listData = CsvToListConverter().convert(_rawData);
    return _listData;
  }

  Future<List<Question>> getQuestionsAsync() async {
    myData = await rootBundle.loadString("assets/PrimarySBA.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
    questionData = csvTable;
    questions = questionData.map<Question>((questionParts) {
      return Question(
        questionParts[0],
        questionParts[1],
        questionParts[2],
        questionParts[3],
        questionParts[4].toString(),
        questionParts[5].toString(),
        questionParts[6].toString(),
        questionParts[7].toString(),
        questionParts[8].toString(),
        questionParts[9].toString(),
        questionParts[10].toString(),
        questionParts[11].toString(),
        questionParts[12].toString(),
        questionParts[13].toString(),
        questionParts[14].toString(),
      );
    }).toList();
    return questions;
  }
}

class Question {
  String subject;
  String topic;
  String title;
  String question;
  String image;
  String option1;
  String option2;
  String option3;
  String option4;
  String option5;
  String explanation;
  String correctAnswer;
  String selected;
  String answered;
  String answeredCorrectly;

  Question(
    this.subject,
    this.topic,
    this.title,
    this.question,
    this.image,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.option5,
    this.explanation,
    this.correctAnswer,
    this.selected,
    this.answered,
    this.answeredCorrectly,
  );
}

//   loadData() async {
//     await rootBundle.loadString('assets/PrimarySBA.csv').then((data) {
//       rowsAsListOfValues = const CsvToListConverter().convert((data));
//     });
//     questionData = rowsAsListOfValues;
//   }


//   List<Question> getQuestionsSync() {
//     loadData();
//     // final File primarySBAFile = File('assets/PrimarySBA.csv');
//     Stream<List> inputStream = questionData.openRead();
//     inputStream
//         .transform(utf8.decoder) // Decode bytes to UTF-8.
//         .transform(new LineSplitter()) // Convert stream to individual lines.
//         .listen((String line) {
//       // Process results.

//       List questionParts = line.split(','); // split by comma
//       var newQuestion = Question(
//           questionParts[0],
//           questionParts[1],
//           questionParts[2],
//           questionParts[3],
//           questionParts[4].toString(),
//           questionParts[5].toString(),
//           questionParts[6].toString(),
//           questionParts[7].toString(),
//           questionParts[8].toString(),
//           questionParts[9],
//           questionParts[10].toString());
//       questions.add(newQuestion);
//     }, onDone: () {
//       print('File is now closed.');
//     }, onError: (e) {
//       print(e.toString());
//     });
//     return questions;
//   }
// }

// // getAllQuestions() {
// //   loadAsset() async {
// //     final data = await rootBundle.loadString('assets/PrimarySBA.csv');
// //     // rowsAsListOfValues = const CsvToListConverter().convert(data);
// //   }
// // }

// // getQuestionsGivenTopics(String topic) {
// //   loadAsset() async {
// //     final data = await rootBundle.loadString('assets/PrimarySBA.csv');
// //     // rowsAsListOfValues = const CsvToListConverter().convert(data);
// //   }

// //   return questions;
// // }



  
// // Future<Question> getOneQuestion() async {
// //     loadData();
    


//     // questions.add(Question(
//     //   rowsAsListOfValues[1]['subject'],
//     //   rowsAsListOfValues[1]['topic'],
//     //   rowsAsListOfValues[1]['question'],
//     //   rowsAsListOfValues[1]['image'],
//     //   rowsAsListOfValues[1]['option1'],
//     //   rowsAsListOfValues[1]['option2'],
//     //   rowsAsListOfValues[1]['option3'],
//     //   rowsAsListOfValues[1]['option4'],
//     //   rowsAsListOfValues[1]['option5'],
//     //   rowsAsListOfValues[1]['exaplanation'],
//     //   rowsAsListOfValues[1]['correctAnswer'],
//     // ));

// // questions = await questionData.map<dynamic>((que) {
// //       final questionParts = que.split(',');
// //       return Question(
// //           questionParts[0],
// //           questionParts[1],
//           questionParts[2],
//           questionParts[3],
//           questionParts[4].toString(),
//           questionParts[5].toString(),
//           questionParts[6].toString(),
//           questionParts[7].toString(),
//           questionParts[8].toString(),
//           questionParts[9],
//           questionParts[10].toString());
//     }).toList();
//     return questions[1];
//   }