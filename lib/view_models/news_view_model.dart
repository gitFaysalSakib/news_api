import 'package:news_api/repository/news_repository.dart';

import '../model/news_channel_headlines_model.dart';

class NewsViewModel{
  final _rep = NewsRepository();
  Future<NewsChannelsHeadlinesModel>fetchNewsChannelHeadlinesApi() async{
    final response = await _rep.fetchNewsChannelHeadlinesApi();
    return response;
    

  }
  
}