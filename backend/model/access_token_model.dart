
import 'dart:convert';
// Model for the recieving auth token
class Auth_token {
  String requestToken;

  Auth_token({
    this.requestToken,
  });

  factory Auth_token.fromJson(Map<String, dynamic> json) => Auth_token(
    requestToken: json["request_token"],
  );

//  Map<String, dynamic> toJson() => {
//    "request_token": requestToken,
//  };
}
Auth_token auth_tokenFromJson(String str) => Auth_token.fromJson(json.decode(str));

//String welcomeToJson(Auth_token data) => json.encode(data.toJson());