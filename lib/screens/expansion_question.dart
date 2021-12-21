import 'package:SussexFRCA/components/arrow_components.dart';
import 'package:SussexFRCA/logic/expansion_question_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This is the stateful widget that the main application instantiates.
class ExpansionQuestionScreen extends StatefulWidget {
  ExpansionQuestionScreen({Key? key}) : super(key: key);

  @override
  State<ExpansionQuestionScreen> createState() =>
      _ExpansionQuestionScreenState();
}

class _ExpansionQuestionScreenState extends State<ExpansionQuestionScreen> {
  Color getOptionColor(
      String option, bool subquestionAnswered, String correctOption) {
    Color cardColor = Colors.white;
    if (option == selectedOption && !subquestionAnswered) {
      return Colors.blue[100]!;
    } else if (subquestionAnswered) {
      if (option == correctOption) {
        return Colors.green[100]!;
      } else if (option == selectedOption && option != correctOption) {
        return Colors.red[100]!;
      }
    }
    return cardColor;
  }

  void selectOption(String option) {
    if (!subquestionAnswered) {
      setState(() {
        selectedOption = option;
      });
    }
  }

  void setAnswerSubmittedAndOptionSelectedToFalse() {
    subquestionAnswered = false;
    selectedOption = '';
  }

  void submitAnswer() {
    if (!subquestionAnswered) {
      setState(() {
        subquestionAnswered = true;
      });
    }
  }

  String selectedOption = "";
  bool subquestionAnswered = false;

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpansionQuestionCubit(),
      child: BlocBuilder<ExpansionQuestionCubit, ExpansionQuestionState>(
        builder: (context, state) {
          String selSubQ = state.selectedSubQuestionIndex;
          return Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(children: [
                Text("Part ${state.selectedSubQuestionIndex}",
                    style: TextStyle(fontSize: 24)),
                // TODO Image.asset("assets/EASYFRCAImages/${queOC.imagePath}"),
                Center(
                  child: AnimatedContainer(
                      padding: EdgeInsets.all(4.0),
                      height: state.expanded ? 500.0 : 150.0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.fastOutSlowIn,
                      child: !(state.expanded)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                  Text("queOC.subQuestionText",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  InkWell(
                                      child: DownArrowBar(),
                                      onTap: () => BlocProvider.of<
                                              ExpansionQuestionCubit>(context)
                                          .expandOrContractObject()),
                                ])
                          : BlocBuilder<ExpansionQuestionCubit,
                              ExpansionQuestionState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    Text("subquestion.subQuestionText",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    InkWell(
                                        child: UpArrowBar(),
                                        onTap: () => BlocProvider.of<
                                                ExpansionQuestionCubit>(context)
                                            .expandOrContractObject()),
                                    Text(""),
                                    // InkWell(
                                    //     child: Option(
                                    //         optionText:
                                    //             "subquestion.subQuestionOption1",
                                    //         optionColor: getOptionColor(
                                    //             subquestion.subQuestionOption1,
                                    //             subquestionAnswered,
                                    //             subquestion
                                    //                 .subQuestionCorrectOption)),
                                    //     onTap: () => {
                                    //           selectOption(subquestion
                                    //               .subQuestionOption1),
                                    //           BlocProvider.of<
                                    //                       ExpansionQuestionCubit>(
                                    //                   context)
                                    //               .selectOption(subquestion
                                    //                   .subQuestionOption1),
                                    //         }),
                                    // InkWell(
                                    //     child: Option(
                                    //         optionText:
                                    //             subquestion.subQuestionOption2,
                                    //         optionColor: getOptionColor(
                                    //             subquestion.subQuestionOption2,
                                    //             subquestionAnswered,
                                    //             subquestion
                                    //                 .subQuestionCorrectOption)),
                                    //     onTap: () => {
                                    //           selectOption(subquestion
                                    //               .subQuestionOption2),
                                    //           BlocProvider.of<
                                    //                       ExpansionQuestionCubit>(
                                    //                   context)
                                    //               .selectOption(subquestion
                                    //                   .subQuestionOption2),
                                    //         }),
                                    // InkWell(
                                    //     child: Option(
                                    //         optionText:
                                    //             subquestion.subQuestionOption3,
                                    //         optionColor: getOptionColor(
                                    //             subquestion.subQuestionOption3,
                                    //             subquestionAnswered,
                                    //             subquestion
                                    //                 .subQuestionCorrectOption)),
                                    //     onTap: () => {
                                    //           selectOption(subquestion
                                    //               .subQuestionOption3),
                                    //           BlocProvider.of<
                                    //                       ExpansionQuestionCubit>(
                                    //                   context)
                                    //               .selectOption(subquestion
                                    //                   .subQuestionOption3),
                                    //         }),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        if (!subquestionAnswered)
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: const Size(200, 50)),
                                            onPressed: () => submitAnswer(),
                                            child: Text("Submit Answer"),
                                          ),
                                        if (subquestionAnswered)
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  fixedSize:
                                                      const Size(200, 50)),
                                              onPressed: () => {
                                                    setAnswerSubmittedAndOptionSelectedToFalse(),
                                                    BlocProvider.of<
                                                                ExpansionQuestionCubit>(
                                                            context)
                                                        .nextSubQuestion(
                                                            state
                                                                .selectedQuestionIndex,
                                                            state
                                                                .selectedSubQuestionIndex)
                                                  },
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text("Next Question"),
                                                    Icon(Icons.arrow_right)
                                                  ]))
                                      ],
                                    ),
                                    if (subquestionAnswered)
                                      Text(
                                          "subquestion.subQuestionExplanation"),
                                  ],
                                );
                              },
                            )),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
