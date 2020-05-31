
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:moviereccomendation/helpers/constants.dart';
import 'package:moviereccomendation/backend/model/MovieWatchListModel.dart';


class FavoriteMovies {

  static const String url = "https://api.themoviedb.org/3/authentication/token/new?api_key=${API_KEY}";


  static Future<List<Result>> getWatchListt() async {
    print("Retriving favorite movie list");

    String ssid = "4e9cf10b9a5bb8d1ab97b45240fd8489ddf37206";

    String requestURL = "https://api.themoviedb.org/3/account/{account_id}/watchlist/movies?api_key=$API_KEY&session_id=$ssid";


    final res = await http.get(requestURL);
    if (res.statusCode == 200) {
      print("Retriving Movie watch list is successfull: " +
          res.statusCode.toString());
      final parsedJson = watchListFromJson(res.body);

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

