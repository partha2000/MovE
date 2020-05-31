import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviereccomendation/backend/model/access_token_model.dart';
import 'package:moviereccomendation/backend/model/newSessionIdModel.dart';
import 'package:http/http.dart' as http;
import 'package:moviereccomendation/helpers/constants.dart';

class Authentication_Authorisation {

  static const String url = "https://api.themoviedb.org/3/authentication/token/new?api_key=${API_KEY}";


//  static String completeAutentication(String username,String password){
//    String sessionId = AuthenticateToken(username,password) as String;
//    print(sessionId);
//  }

  static Future<String> getAuthToken() async {
    print("Authentication accessed");
    final res = await http.get(url);
    if(res.statusCode == 200){
//      print(res.body);
      final parsedJson = auth_tokenFromJson(res.body);

     print("Request token sent = "+parsedJson.requestToken);
      return parsedJson.requestToken;
    }
    else throw Exception(
        'http.get error: statusCode= ${res.statusCode}');
    print(res.statusCode);
  }

  static Future<String> AuthenticateToken(String username,String password) async {

    print("Authorisation accessed");
    Future<String> requestToken = getAuthToken();
    String requestTokenString = await getAuthToken();
    print("Access token recievd = "+requestTokenString);

    String authenticationURL = "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=$API_KEY&username=$username&password=$password&request_token=$requestTokenString";
    final res = await http.get(authenticationURL);
    if(res.statusCode == 200){
//      final parsedJson = auth_tokenFromJson(res.body);
//      print(parsedJson.requestToken);
//      Future<String> session_id = createSession(requestToken);
    print("Creating a session");
      return createSession(requestTokenString);
    }
    else throw Exception(
        'http.get error: statusCode= ${res.statusCode}');
    print(res.statusCode);
  }

  static Future<String> createSession(String authenticated_token) async {

    print("Create Session accessed");
//    String token = await authenticated_token;

    String sessionURL = "https://api.themoviedb.org/3/authentication/session/new?api_key=$API_KEY&request_token=$authenticated_token";
    final res = await http.get(sessionURL);
    if(res.statusCode == 200){
      final parsedJson = await generateSessionId(res.body);
      print("session created : "+res.body.toString());
      print("Session_id = "+parsedJson.sessionId.toString());
      return parsedJson.sessionId;
    }
    else
      print("session status = (ERROR) "+ res.statusCode.toString());

  }


}


// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

//import 'package:http/http.dart' as http;
//
//void main() async {
//  var headers = {
//    'Authorization': 'Bearer <<access_token>>',
//    'Content-Type': 'application/json;charset=utf-8',
//  };
//
//  var res = await http.get('https://api.themoviedb.org/3/movie/76341', headers: headers);
//  if (res.statusCode != 200) throw Exception('http.get error: statusCode= ${res.statusCode}');
//  print(res.body);
//}