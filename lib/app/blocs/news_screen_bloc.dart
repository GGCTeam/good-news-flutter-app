import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:good_news_flutter/app/data/api_service.dart';
import 'package:good_news_flutter/app/data/storage_service.dart';
import 'package:good_news_flutter/app/models/News.dart';

class NewsScreenBloc {
  NewsScreenBloc({
    @required this.api,
    @required this.storage,
  }) {
    // TODO add data listener to news bookmarks storage
    // storage.news.stream.listen((news) { print("\n\nFROM NewsScreenBloc: \n\n"); print(news); });
  }

  final ApiService api;
  final StorageService storage; // TODO

  final StreamController<List<News>> _newsController =
      StreamController<List<News>>();

  Stream<List<News>> get newsStream => _newsController.stream;
  List<News> _news = [];

  Future<void> get() async {
    try {
      final news = await api.getNews();

      storage.news.save(news);
      updateWith(news: news);
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
