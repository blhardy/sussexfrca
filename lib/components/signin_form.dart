import 'dart:ui';

import 'package:SussexFRCA/components/loading.dart';
import 'package:SussexFRCA/components/shared_styles.dart';
import 'package:SussexFRCA/services/auth.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  final Function? toggleView;
  const SignInForm({Key? key, this.toggleView}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _registerFormKey = GlobalKey<FormState>();
  final _auth = AuthService();
  var email;
  var password;
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text("Sign In"),
                actions: <Widget>[
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(width: 2, color: Colors.white)),
                    child:
                        Text("Register", style: TextStyle(color: Colors.white)),
                    onPressed: () => widget.toggleView!(),
                  ),
                ]),
            body: Container(
              width: 400,
              child: Center(
                child: Form(
                  key: _registerFormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? 'Enter email' : null,
                          onChanged: (value) {
                            setState(() => {
                                  email = value,
                                });
                          },
                          decoration:
                              textInputDecoration.copyWith(hintText: "Email"),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                            validator: (value) => value!.length < 6
                                ? 'Passwords must be more than 6 characters'
                                : null,
                            obscureText: true,
                            onChanged: (value) {
                              setState(() => {password = value});
                            },
                            decoration: textInputDecoration.copyWith(
                                hintText: "Password")),
                        SizedBox(height: 20),
                        Container(
                          width: 150,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_registerFormKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    loading = false;
                                    setState((() => error =
                                        'could not sign in with those details'));
                                  }
                                }
                              },
                              child: Text("Sign In")),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(error, style: TextStyle(color: Colors.red))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
