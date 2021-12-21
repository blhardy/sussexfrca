import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/user_answer_model.dart';

class PartyUserWidget extends StatelessWidget {
  const PartyUserWidget(
      {required this.username, required this.finishedSession});
  final String username;
  final bool? finishedSession;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> quizStream =
      FirebaseFirestore.instance.collection('quiz_details').snapshots();
      
    Icon finishedSessionIcon = Icon(Icons.circle_outlined);
    if (finishedSession != null) {
      finishedSessionIcon = Icon(
        Icons.check_circle,
        color: Colors.green[600],
      );
    }
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: Colors.blue[400]!,
            width: 1,
          ),
        ),
        elevation: 2,
        child: Container(
          height: 55,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(2),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text(username),
            SizedBox(width: 10),
            Icon(Icons.person),
            SizedBox(width: 10),
            finishedSessionIcon,
          ]),
        ));
  }
}
