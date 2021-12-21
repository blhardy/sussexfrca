import 'package:SussexFRCA/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_login.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userLoggedIn = Provider.of<UserLogin>(context);

    if (userLoggedIn.uid == '') {
      return Authenticate();
    } else {
      return MyHomePage(title: 'Sussex FRCA');
    }
  }
}
