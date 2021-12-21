import 'package:SussexFRCA/components/register_form.dart';
import 'package:SussexFRCA/components/signin_form.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    print("Sign in bool is $showSignIn");
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Container(child: SignInForm(toggleView: toggleView));
    } else {
      return Container(child: RegisterForm(toggleView: toggleView));
    }
  }
}
