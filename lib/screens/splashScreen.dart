import 'dart:async';
import 'package:SussexFRCA/logic/selected_topics_cubit.dart';
import 'package:SussexFRCA/main.dart';
import 'package:SussexFRCA/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Wrapper()));
    });
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SelectedTopicsCubit>(context).initialiseRepo();
    return Scaffold(
        backgroundColor: Colors.lightBlue[400]!,
        body: Center(
            child: Lottie.asset('assets/lottie/splashanimation.json',
                width: 300, height: 300)));
  }
}
