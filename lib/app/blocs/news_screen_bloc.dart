import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:good_news_flutter/app/data/storage_service.dart';
import 'package:good_news_flutter/app/models/News.dart';

class NewsScreenBloc {
  NewsScreenBloc({
    @required this.storage,
  }) {
    storage.news.stream.listen((news) => this.updateWith(news: news));
  }

  final StorageService storage;

  final StreamController<List<News>> _newsController =
      StreamController<List<News>>();

  Stream<List<News>> get newsStream => _newsController.stream;

  Future<void> get() async {
    try {
      await storage.news.get(newsSources: await storage.newsSources.getFromLocalStorage());
    } catch (e) {
      updateWithError(error: e);
    }
  }

  void addToBookmarks(News bookmark) {
    storage.bookmarks.add(bookmark);
  }

  void updateWith({
    List<News> news,
  }) {
    _newsController.add(news);
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
