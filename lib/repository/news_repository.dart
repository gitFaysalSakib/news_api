import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_api/model/news_category_model.dart';
import 'package:news_api/model/news_channel_headlines_model.dart';


class NewsRepository {
 

  Future<NewsCategoryModel> fetchNewsCategoires(String category) async {
    String newsUrl =
        'https://newsapi.org/v2/everything?q=$category&apiKey=1cd2cfb700314b3a9d02920cab868a19';
    final response = await http.get(Uri.parse(newsUrl));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return NewsCategoryModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(String newsName) async {
    String newsUrl = 'https://newsapi.org/v2/top-headlines?sources=$newsName&apiKey=1cd2cfb700314b3a9d02920cab868a19';
    final response = await http.get(Uri.parse(newsUrl));
  
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      
      return NewsChannelsHeadlinesModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }
}