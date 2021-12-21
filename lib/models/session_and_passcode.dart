class SessionAndPasscode {
  String sessionID;
  String passcode;
  SessionAndPasscode({required this.sessionID, required this.passcode});

  factory SessionAndPasscode.fromRTDB(Map<dynamic, dynamic> data) {
    return SessionAndPasscode(
      sessionID: data['Session'] ?? "",
      passcode: data['Access Code'].toString(),
    );
  }
}
