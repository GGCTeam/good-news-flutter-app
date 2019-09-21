import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/navigation/tabs.dart';
import 'package:good_news_flutter/app/placeholder_page.dart';
import 'package:good_news_flutter/app/screens/bookmarks_screen.dart';
import 'package:good_news_flutter/app/screens/news_open_screen.dart';
import 'package:good_news_flutter/app/screens/news_screen.dart';
import 'package:good_news_flutter/app/screens/settings_screen.dart';

typedef MaterialPageRouteBuilder<T> = MaterialPageRoute Function(BuildContext context, T data);

enum Path {
  news_root,
  bookmarks_root,
  settings_root,
  news_open,
}

class Routes {
  static Map<Path, String> paths = {
    Path.news_root: 'news',
    Path.bookmarks_root: 'bookmarks',
    Path.settings_root: 'settings',
    Path.news_open: 'news_open',
  };

  static Map<TabItem, String> rootPaths = {
    TabItem.news: paths[Path.news_root],
    TabItem.bookmarks: paths[Path.bookmarks_root],
    TabItem.settings: paths[Path.settings_root],
  };

  static Map<String, MaterialPageRouteBuilder> builders = {
    paths[Path.news_root]: (context, _) => MaterialPageRoute(
      settings: RouteSettings(
        isInitialRoute: true, // true - appears w/out animation
      ),
      builder: (context) => NewsScreen.create(context),
    ),

    paths[Path.bookmarks_root]: (context, _) => MaterialPageRoute(
      settings: RouteSettings(
        isInitialRoute: true,
      ),
      builder: (context) => BookmarksScreen.create(context),
    ),

    paths[Path.settings_root]: (context, _) => MaterialPageRoute(
      settings: RouteSettings(
        isInitialRoute: true,
      ),
      builder: (context) => SettingsScreen.create(context),
    ),

    paths[Path.news_open]: (context, news) => MaterialPageRoute(
      settings: RouteSettings(
        isInitialRoute: false,
      ),
      builder: (context) => NewsOpenScreen(model: news),
    ),
  };
}
