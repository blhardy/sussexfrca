import 'package:flutter/material.dart';

class ExamTipsScreen extends StatefulWidget {
  @override
  ExamTipsScreenState createState() => ExamTipsScreenState();
}

class ExamTipsScreenState extends State<ExamTipsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Exam Tips')),
        body: Card(child: Text('The exam tips will be here one day, Card')));
  }
}
