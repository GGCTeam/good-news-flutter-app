import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:good_news_flutter/app/data/storage_service.dart';
import 'package:good_news_flutter/app/models/News.dart';

class BookmarksScreenBloc {
  BookmarksScreenBloc({
    @required this.storage,
  }) {
    // here we create listener to storage,
    // so when we receive new values,
    // we update UI state through the BLoC
    storage.bookmarks.stream.listen((bookmarks) => this.updateWith(bookmarks: bookmarks));
  }

  final StorageService storage;

  final StreamController<List<News>> _bookmarksController =
  StreamController<List<News>>();

  Stream<List<News>> get bookmarksStream => _bookmarksController.stream;

  void updateWith({
    List<News> bookmarks,
  }) {
    _bookmarksController.add(bookmarks);
  }

  void updateWithError({
    Object error,
  }) {
    _bookmarksController.addError(error);
  }

  void dispose() {
    _bookmarksController.close();
  }
}
