import 'package:SussexFRCA/components/shared_styles.dart';
import 'package:SussexFRCA/services/auth.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  final Function? toggleView;
  const RegisterForm({Key? key, this.toggleView}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _auth = AuthService();
  final _registerFormKey = GlobalKey<FormState>();
  var email;
  var password;
  var firstName;
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Register Account"),
        actions: [
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide(width: 2, color: Colors.white)),
              onPressed: () => widget.toggleView!(),
              child: Text(
                "Sign In",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Center(
        child: Form(
          key: _registerFormKey,
          child: Container(
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value) => value!.isEmpty ? 'Enter email' : null,
                    onChanged: (value) => {
                      setState(() => {email = value}),
                    },
                    decoration: textInputDecoration.copyWith(hintText: "Email"),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: "Password"),
                    validator: (value) => value!.length < 6
                        ? 'Passwords must be more than 6 characters'
                        : null,
                    obscureText: true,
                    onChanged: (value) => {
                      setState(() => {password = value}),
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: "First name"),
                    validator: (value) => value!.isEmpty
                        ? 'Please enter first name or nickname'
                        : null,
                    onChanged: (value) => {
                      setState(() => {firstName = value}),
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_registerFormKey.currentState!.validate()) {
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    firstName, email, password);
                            if (result == null) {
                              setState((() =>
                                  error = 'please supply valid details'));
                            }
                          }
                          ;
                        },
                        child: Text("Register Account")),
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
