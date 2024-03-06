import 'package:news_api/model/news_category_model.dart';
import 'package:news_api/repository/news_repository.dart';

import '../model/news_channel_headlines_model.dart';

class NewsViewModel{
   
  final _rep = NewsRepository();
  //diffrent type of news channel headlines api call....
  Future<NewsChannelsHeadlinesModel>fetchNewsChannelHeadlinesApi(String newsName) async{
    final response = await _rep.fetchNewsChannelHeadlinesApi( newsName);
    return response;
    
}
// news category type api call..
Future<NewsCategoryModel>fetchNewsCategoires(String newsCategory) async{
    final response = await _rep.fetchNewsCategoires( newsCategory);
    return response;
    
}
  
}