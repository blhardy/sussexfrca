import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  FeedbackScreenState createState() => FeedbackScreenState();
}

class FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Feedback')),
        body: Card(child: Text('The feedback Card')));
  }
}
