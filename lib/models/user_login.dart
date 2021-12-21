class UserLogin {
  final String username;
  final DateTime signInDateTime;
  final bool? finishedSession;
  final String? session;
  final String? uid;
  UserLogin(this.username, this.signInDateTime, this.session,
      this.finishedSession, this.uid);

  UserLogin.fromJson(Map<dynamic, dynamic> json)
      : username = json['username'] as String,
        signInDateTime = DateTime.parse(json['signupdatetime']),
        session = json['session'] as String,
        finishedSession = json['finishedSession'] == true,
        uid = json['uid'] ?? '';

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'uid': uid.toString(),
        'username': username.toString(),
        'signupdatetime': signInDateTime.toString(),
        'session': session.toString(),
        'finishedSession': finishedSession.toString(),
      };
}
