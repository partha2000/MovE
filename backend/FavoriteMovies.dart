import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviereccomendation/backend/model/access_token_model.dart';
import 'package:moviereccomendation/backend/model/newSessionIdModel.dart';
import 'package:http/http.dart' as http;
import 'package:moviereccomendation/helpers/constants.dart';
import 'model/favoriteMoviesModel.dart';


class FavoriteMovies {

  static const String url = "https://api.themoviedb.org/3/authentication/token/new?api_key=${API_KEY}";


  static Future<List<Result>> getFavoriteMovies() async {
    print("Retriving favorite movie list");

    String ssid = "4e9cf10b9a5bb8d1ab97b45240fd8489ddf37206";
    String requestURL = "https://api.themoviedb.org/3/account/{account_id}/favorite/movies?api_key=$API_KEY&session_id=$ssid";


    final res = await http.get(requestURL);
    if (res.statusCode == 200) {
      print("Retriving favorite movie list successfull: " +
          res.statusCode.toString());
      final parsedJson = favoriteMoviesFromJson(res.body);

      for(int i = 0 ; i< parsedJson.results.length;i++){
      print(parsedJson.results.elementAt(i).title.toString());
        }

      return parsedJson.results;
    }
    else
      print("Retriving favorite movie list not successfull: " +
          res.statusCode.toString());
  }
}

