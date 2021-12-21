import 'package:SussexFRCA/components/party_user_widget.dart';
import 'package:SussexFRCA/models/user_login.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/selected_topics_cubit.dart';

class PartyDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    var stc = BlocProvider.of<SelectedTopicsCubit>(context);
    return Drawer(
      child: Material(
        color: Color.fromRGBO(50, 75, 205, 1),
        child: Column(children: [
          SizedBox(height: 60),
          Text("Users logged in:",
              style: TextStyle(color: Colors.white, fontSize: 30)),
          SizedBox(height: 50),
          Expanded(
            child: FirebaseAnimatedList(
                controller: stc.scrollController,
                query: stc.userloginDao.getUserLoginsQuery(),
                itemBuilder: (context, snapshot, animation, index) {
                  final json =
                      snapshot.child('userlogins') as Map<dynamic, dynamic>;
                  final userLogin = UserLogin.fromJson(json);
                  if (userLogin.signInDateTime
                      .isAfter(DateTime.now().subtract(Duration(days: 10)))) {
                    return PartyUserWidget(
                        username: userLogin.username,
                        finishedSession: userLogin.finishedSession);
                  } else {
                    return Text("");
                  }
                }),
          ),
        ]),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        break;
      case 1:
        break;
    }
  }
}
