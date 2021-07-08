import 'dart:async';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:easyfrca/question_bank.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnswerStorage {
  var userAnswersList = [];
  Map map1 = {};

  AnswerStorage();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/userAnswerData.csv');
  }

  Future<File> writeData(Map answerMap) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString('$answerMap');
  }

  void addQuestionToSavedData(String index, String answeredCorrectly) async {
    Map map3 = {};
    getMapOfUserAnswers().then((mapOfAnswers) {
      map3 = mapOfAnswers;
    });
    if (!map3.keys.contains(index)) {
      map3[index] = answeredCorrectly;
      print('This is Map3 during writing  : ' + map3.toString());
    }
    writeData(map3);
  }

  processLines(List<String> lines) {
    print(lines);
  }

  handleError(Error e) {
    print(e);
  }

  Future<Map> getMapOfUserAnswers() async {
    Map answerMap = {};
    final file = await _localFile;
    // Read the file
    file.readAsLines().then((line) {
      var splits = line[0].split(':');
      answerMap[splits[0]] = splits[1];
    }).catchError((e) => handleError(e));
    print('This is the retrieved asnwermap' + answerMap.toString());
    return answerMap;
  }
}
