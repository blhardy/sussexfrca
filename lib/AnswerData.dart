import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Answer Data Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: AnswerDataPage(title: 'Answer Data Demo'),
    );
  }
}

class AnswerDataPage extends StatefulWidget {
  AnswerDataPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _AnswerDataPageState createState() => _AnswerDataPageState();
}

class _AnswerDataPageState extends State<AnswerDataPage> {
  var answerStrings;

  @override
  void initState() {
    super.initState();
    _loadAnswerMap();
  }

  //Loading counter value on start
  void _loadAnswerMap() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      answerStrings = (prefs.getStringList('answerStrings') ?? 0);
    });
  }

  void _setTestAnswerMap() async {
    final prefs = await SharedPreferences.getInstance();
    answerStrings = ['1,true', '2, true', '3,true', '5,true'];
    prefs.setStringList('answerStrings', answerStrings);
    _loadAnswerMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              answerStrings.toString(),
            ),
            Text(
              '10',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _setTestAnswerMap,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
