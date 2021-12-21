import 'package:SussexFRCA/models/user_login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserLoginDao {
  final DatabaseReference _userloginsRef =
      FirebaseDatabase.instance.ref().child('userlogins');

  void saveLogin(UserLogin userLogin) async {
    try {
      await _userloginsRef.push().set(userLogin.toJson());
    } catch (error) {
      print(error);
    }
  }

  Query getUserLoginsQuery() {
    return _userloginsRef;
  }

  Future<String?> getIDForUserLogin() async {
    var loginID = _userloginsRef.push().key;
    return loginID;
  }

  void updateSessionFinished(String id, String sessionFinished) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref().child("quiz_details/$id");
    await ref.update({
      "${sessionFinished}status": 'complete',
    });
  }
}
