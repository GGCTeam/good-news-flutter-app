
import 'package:good_news_flutter/app/models/News.dart';
import 'package:good_news_flutter/app/models/NewsSource.dart';
import 'package:good_news_flutter/app/models/NewsType.dart';
import 'package:localstorage/localstorage.dart';
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
  final String storageKey = "bookmarks";
  LocalStorage storage;

  BookmarksStorage() {
    storage = new LocalStorage('${storageKey}_storage');

    getFromStorage();
  }

  List<News> _bookmarks = [];

  BehaviorSubject stream = new BehaviorSubject<List<News>>();

  void getFromStorage() async {
    if (await storage.ready) {
      List<dynamic> bookmarks = storage.getItem(storageKey) ?? [];
      _bookmarks = bookmarks.map((b) => News.fromMap(b)).toList();
      stream.add(_bookmarks);
    }
  }

  void add(News bookmark) async {
    if (!_bookmarks.contains(bookmark)) {
      _bookmarks.insert(0, bookmark); // adding to the beginning of the list
      stream.add(_bookmarks);

      if (await storage.ready) {
        storage.setItem(storageKey, _bookmarks.map((b) => b.toMap()).toList());
      }
    }
  }

  void remove(News bookmark) async {
    if (_bookmarks.contains(bookmark)) {
      _bookmarks.remove(bookmark);
      stream.add(_bookmarks);

      if (await storage.ready) {
        storage.setItem(storageKey, _bookmarks.map((b) => b.toMap()).toList());
      }
    }
  }

  void dispose() {
    stream.close();
  }
}