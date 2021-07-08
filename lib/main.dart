import 'dart:io';
import 'package:csv/csv.dart';
import 'package:easyfrca/question_bank.dart';
import 'package:easyfrca/userData.dart';
// import 'package:easyfrca/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'custom_theme_data.dart';
import './feedback_screen.dart';
import './exam_tips_screen.dart';
import './images_screen.dart';
import './question_screen.dart';
import './question_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'EASY FRCA',
        theme: CustomTheme.lightTheme,
        home: MyHomePage(title: 'EASY FRCA'),
        initialRoute: '/',
        routes: {
          '/questions': (context) => QuestionsScreen(),
          '/images': (context) => ImagesScreen(),
          '/examtips': (context) => ExamTipsScreen(),
          '/feedback': (context) => FeedbackScreen(),
          '/questionsList': (context) => QuestionsListScreen(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var storage = AnswerStorage();
  var userStorageData;
  var rowsAsListOfValues;
  final File primarySBAFile = new File('/assets/PrimarySBA.csv');
  late bool includePhysio = true;
  late bool includePhysics = true;
  late bool includePharm = true;
  var selectedTopics = [];
  var userDataRetrieved;

  List<dynamic> getSelectedTopics() {
    var _selectedTopics = [];
    if (includePhysio) {
      _selectedTopics.add('Physiology & Anatomy');
    }
    if (includePhysics) {
      _selectedTopics.add('Physics & Equipment');
    }
    if (includePharm) {
      _selectedTopics.add('Pharmacology & Statistics');
    }
    return _selectedTopics;
  }

  late bool newValue = false;
  late bool checkedValue = true;

  void switchScreen(BuildContext ctx, String screenAddress) {
    Navigator.pushNamed(ctx, '/$screenAddress');
  }

  // loadAsset() async {
  //   final myData = await rootBundle.loadString("assets/PrimarySBA.csv");
  //   List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
  //   rowsAsListOfValues = csvTable;
  // }

  @override
  Widget build(BuildContext context) {
    // loadAsset();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(children: [
        Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
            image: new AssetImage('assets/DrugLabels.jpg'),
            fit: BoxFit.cover,
          )),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                  margin: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(children: [
                    Container(
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () {
                            selectedTopics = getSelectedTopics();
                            Navigator.pushNamed(context, '/questionsList',
                                arguments: {
                                  'selectedQuestionTopics': selectedTopics
                                });
                          },
                          child: Text('Start Questions')),
                    ),
                    CheckboxListTile(
                      title: Text("Physiology"),
                      value: includePhysio,
                      onChanged: (newValue) {
                        setState(() {
                          includePhysio = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      title: Text("Physics"),
                      value: includePhysics,
                      onChanged: (newValue) {
                        setState(() {
                          includePhysics = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      title: Text("Pharmacology"),
                      value: includePharm,
                      onChanged: (newValue) {
                        setState(() {
                          includePharm = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    )
                  ])),
              Container(
                width: 300,
                child: ElevatedButton(
                    onPressed: () => switchScreen(context, 'images'),
                    child: Text('Images')),
              ),
              Container(
                width: 300,
                child: ElevatedButton(
                    onPressed: () => switchScreen(context, 'examtips'),
                    child: Text('Exam Tips')),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
