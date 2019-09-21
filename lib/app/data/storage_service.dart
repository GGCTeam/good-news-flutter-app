
import 'package:good_news_flutter/app/models/News.dart';
import 'package:good_news_flutter/app/models/NewsSource.dart';
import 'package:good_news_flutter/app/models/NewsType.dart';
import 'package:rxdart/subjects.dart';

class StorageService {
  NewsStorage news = NewsStorage();
  BookmarksStorage bookmarks = BookmarksStorage();
//  List<News> news = [];
//  List<News> bookmarks = []; // cached
//  // TODO вместо верхнего будет просто bookmarksStorage типа  того
//  List<NewsSource> newsSources = []; // cached
//  List<NewsType> newsTypes = []; // cached


}

class NewsStorage {
  List<News> _news = [];

  BehaviorSubject stream = new BehaviorSubject<List<News>>();

  List<News> get() {
    return _news;
  }

  void save(List<News> news) {
    _news = news;

    stream.add(_news);
  }

  void dispose() {
    stream.close();
  }
}

class BookmarksStorage {
  BookmarksStorage() {
    stream.add(_bookmarks);
  }

  List<News> _bookmarks = [];

  BehaviorSubject stream = new BehaviorSubject<List<News>>();

  void add(News bookmark) {
    if (!_bookmarks.contains(bookmark)) {
      _bookmarks.insert(0, bookmark); // adding to the beginning of the list

      // TODO save to the actual local_storage

      stream.add(_bookmarks);
    }
  }

  void remove(News bookmark) {
    if (_bookmarks.contains(bookmark)) {
      _bookmarks.remove(bookmark);

      // TODO remove from the actual local_storage

      stream.add(_bookmarks);
    }
  }

  void dispose() {
    stream.close();
  }
}