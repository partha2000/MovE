import 'dart:convert';
// Model for the recieving auth token
class newSession {
  String sessionId;

  newSession({
    this.sessionId,
  });

  factory newSession.fromJson(Map<String, dynamic> json) => newSession(
    sessionId: json["session_id"],
  );

//  Map<String, dynamic> toJson() => {
//    "session_id": sessionId
//  };
}
newSession generateSessionId(String str) => newSession.fromJson(json.decode(str));

//String welcomeToJson(newSession data) => json.encode(data.toJson());