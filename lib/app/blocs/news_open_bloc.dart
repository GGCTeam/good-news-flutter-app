import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:good_news_flutter/app/data/storage_service.dart';
import 'package:good_news_flutter/app/models/News.dart';
import 'package:rxdart/subjects.dart';

class NewsOpenBloc {
  NewsOpenBloc({
    @required this.storage,
    @required this.news,
  }) {
    // this is done to check is current opened article is in bookmarks array
    // even if a person adds it while being on NewsOpenScreen
    // and then goes to BookmarksScreen and remove article from there
    storage.bookmarks.stream.listen((bookmarks) => this.checkIfBookmarked(news));
  }

  final StorageService storage;
  final News news;

  final BehaviorSubject stream = new BehaviorSubject<bool>();

  void addToBookmarks(News news) {
    storage.bookmarks.add(news);

    updateWith(isBookmarked: true);
  }

  void removeFromBookmarks(News news) {
    storage.bookmarks.remove(news);

    updateWith(isBookmarked: false);
  }

  void checkIfBookmarked(News news) {
    updateWith(isBookmarked: storage.bookmarks.isBookmarked(news));
  }

  void updateWith({
    bool isBookmarked,
  }) {
    stream.add(isBookmarked);
  }

  void dispose() {
    stream.close();
  }
}
