import 'package:carousel_slider/carousel_slider.dart';
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
        body: CarouselSlider(
          options: CarouselOptions(height: 600.0),
          items: [1, 2, 3, 4, 5, 6].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Image(
                    image: AssetImage("assets/ExamTipImages/ExamTip${i}.jpg"),
                  ),
                );
              },
            );
          }).toList(),
        ));
  }
}
