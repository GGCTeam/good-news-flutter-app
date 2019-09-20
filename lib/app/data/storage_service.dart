
import 'package:good_news_flutter/app/models/News.dart';
import 'package:good_news_flutter/app/models/NewsSource.dart';
import 'package:good_news_flutter/app/models/NewsType.dart';
import 'package:rxdart/subjects.dart';

// NOTE: might be better to separate this class to different classes
class StorageService {
  NewsStorage news = NewsStorage();
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

//class BookmarksStorage {
//  List<News> bookmarks = [];
//
//  BehaviorSubject stream = new BehaviorSubject<List<News>>();
//
//
//
//  void dispose() {
//    stream.close();
//  }
//}