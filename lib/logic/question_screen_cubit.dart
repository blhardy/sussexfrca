import 'package:bloc/bloc.dart';
import 'package:SussexFRCA/components/option.dart';
import 'package:SussexFRCA/models/question_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'question_screen_state.dart';

class QuestionScreenCubit extends Cubit<QuestionScreenState> {
  QuestionScreenCubit() : super(InitialState());
  var myData;
  var questions;
  var questionData;
  var currentQuestionIndex;
}
