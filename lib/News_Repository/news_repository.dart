
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_apps/Models/news_headlines_model.dart';

class NewsRepository{

  Future<NewsHeadlinesModel> fetchHeadlinesApi(String channelName) async {

    String url = 'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=f41dac012c9347e98c1219c09c688126';
    final response = await http.get(Uri.parse(url));
 print(url);
    if(response.statusCode == 200){

    final data = jsonDecode(response.body);
    return NewsHeadlinesModel.fromJson(data);
    }
    throw Exception('Error');
  }

}