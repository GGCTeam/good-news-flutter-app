import 'dart:async';
import 'package:good_news_flutter/app/data/constants.dart';
import 'package:good_news_flutter/app/models/News.dart';
import 'package:dio/dio.dart';

class NewsScreenBloc {
  // final ApiService api; // TODO
  // final StorageService storage; // TODO

  final StreamController<List<News>> _newsController =
      StreamController<List<News>>();

  Stream<List<News>> get newsStream => _newsController.stream;
  List<News> _news = [];

  NewsScreenBloc() {
    // TODO add data listener to news bookmarks storage
  }

  Future<void> get() async {
    try {
      // TODO move it to separate file API
      Response<List<dynamic>> resp = await Dio()
          .get<List<dynamic>>("${Constants.baseUrl}/v1/news/");

      List<News> _news = [];
      for (dynamic _n in resp.data) {
        _news.add(News.fromMap(_n));
      }

      updateWith(news: _news);
    } catch (e) {
      updateWithError(error: e);
      // rethrow;
    }
  }

  void updateWith({
    List<News> news,
  }) {
    _news = news;

    _newsController.add(_news);
  }

  void updateWithError({
    Object error,
  }) {
    _newsController.addError(error);
  }

  void dispose() {
    _newsController.close();
  }
}
