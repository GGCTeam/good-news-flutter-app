import 'package:good_news_flutter/app/data/api_service.dart';
import 'package:good_news_flutter/app/models/News.dart';
import 'package:good_news_flutter/app/models/NewsSource.dart';
import 'package:good_news_flutter/app/models/NewsType.dart';
import 'package:localstorage/localstorage.dart';
import 'package:rxdart/subjects.dart';

var api = ApiService();
var localStorage =
    LocalStorage("good-news-storage");

class StorageService {
  BookmarksStorage bookmarks = BookmarksStorage();
  NewsSourcesStorage newsSources = NewsSourcesStorage();
  NewsStorage news = NewsStorage();

  void dispose() {
    bookmarks.dispose();
    newsSources.dispose();
    news.dispose();
  }
}

class NewsStorage {
  BehaviorSubject stream = new BehaviorSubject<List<News>>();
  List<News> _news = [];

  Future<void> get({ List<NewsSource> newsSources }) async {
    try {
      _news = await api.getNews();

      // if there is something in news sources then we filter news with those values
      if (newsSources != null && newsSources.isNotEmpty) {
        filterWith(newsSources);
      } else {
        stream.add(_news);
      }
    } catch (e) {
      rethrow;
    }
  }

  // a bit "interesting" logic but it works =)
  void filterWith(List<NewsSource> newsSources) {
    List<News> filteredNews = [];

    for (News n in _news) {
      int nsIndex = newsSources.indexWhere((_ns) => _ns.id == n.newsSource.id);
      if (nsIndex >= 0) {
        NewsSource ns = newsSources[nsIndex];

        int ntIndex = ns.types.indexWhere((_nt) => _nt.id == n.newsType.id);
        if (ntIndex >= 0) {
          NewsType nt = ns.types[ntIndex];

          if (nt.selected) {
            filteredNews.add(n);
          }
        }
      }
    }

    stream.add(filteredNews);
  }

  void dispose() {
    stream.close();
  }
}

class BookmarksStorage {
  final String localStorageKey = "bookmarks";

  BehaviorSubject stream = new BehaviorSubject<List<News>>();
  List<News> _bookmarks = [];

  void get() async {
    if (await localStorage.ready) {
      List<dynamic> bookmarks = localStorage.getItem(localStorageKey) ?? [];
      _bookmarks = bookmarks.map((b) => News.fromMap(b)).toList();

      stream.add(_bookmarks);
    }
  }

  void add(News bookmark) {
    if (!bookmarksContain(bookmark)) {
      _bookmarks.insert(0, bookmark); // adding to the beginning of the list
      stream.add(_bookmarks);

      _saveData();
    }
  }

  void remove(News bookmark) {
    if (bookmarksContain(bookmark)) {
      _bookmarks.removeWhere((b) => b.id == bookmark.id);
      stream.add(_bookmarks);

      _saveData();
    }
  }

  bool isBookmarked(News news) {
    return bookmarksContain(news);
  }

  bool bookmarksContain(News news) {
    return _bookmarks.indexWhere((b) => b.id == news.id) >= 0;
  }

  void _saveData() async {
    if (await localStorage.ready) {
      localStorage.setItem(
          localStorageKey, _bookmarks.map((b) => b.toMap()).toList());
    }
  }

  void dispose() {
    stream.close();
  }
}

class NewsSourcesStorage {
  final String localStorageKey = "newsSources";

  BehaviorSubject stream = new BehaviorSubject<List<NewsSource>>();
  List<NewsSource> _newsSources = [];

  Future<List<NewsSource>> getFromLocalStorage() async {
    if (await localStorage.ready) {
      List<dynamic> newsSources = localStorage.getItem(localStorageKey) ?? [];
      _newsSources = newsSources.map((b) => NewsSource.fromMap(b)).toList();
    }

    return _newsSources;
  }

  Future<void> get() async {
    stream.add(_newsSources);

    try {
      List<NewsSource> newsSources = await api.getNewsSources();

      // here we change types of all incoming news sources with types of previous ones
      for (int i = 0; i < newsSources.length; i++) {
        int _nsIndex = _newsSources.indexWhere((_ns) => _ns.id == newsSources[i].id);
        if (_nsIndex >= 0) {
          newsSources[i].types = _newsSources[_nsIndex].types;
        }
      }

      _newsSources = newsSources;

      stream.add(_newsSources);

      _saveData();
    } catch (e) {
      rethrow;
    }
  }

  void typeSelected(NewsSource s, NewsType t, bool selected) {
    int sIndex = _newsSources.indexWhere((_ns) => _ns.id == s.id);
    if (sIndex >= 0) {
      int tIndex = _newsSources[sIndex].types.indexWhere((_t) => _t.id == t.id);
      if (tIndex >= 0) {
        _newsSources[sIndex].types[tIndex].selected = selected;

        stream.add(_newsSources);

        _saveData();
      }
    }
  }

  void _saveData() async {
    if (await localStorage.ready) {
      localStorage.setItem(
          localStorageKey, _newsSources.map((ns) => ns.toMap()).toList());
    }
  }

  void dispose() {
    stream.close();
  }
}
