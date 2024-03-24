


import '../../Models/news_headlines_model.dart';
import '../../News_Repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsHeadlinesModel> fetchHeadlinesApi (String channelName  ) async {
    final response = await _rep.fetchHeadlinesApi(channelName);
    return response;
  }

  }


