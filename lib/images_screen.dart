import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImagesScreen extends StatefulWidget {
  @override
  ImagesScreenState createState() => ImagesScreenState();
}

class ImagesScreenState extends State<ImagesScreen> {
  var rowsAsListOfValues = [];
  loadAsset() async {
    final data = await rootBundle.loadString('assets/PrimarySBA.csv');
    rowsAsListOfValues = data.split(",,");
    rowsAsListOfValues.forEach((element) {
      element.split(',');
    });
  }

  @override
  Widget build(BuildContext context) {
    loadAsset();

    return Scaffold(
        appBar: AppBar(title: Text('Images')),
        body: Card(child: Text('The Images will go here')));
  }
}
