import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/navigation/tabs.dart';
import 'package:good_news_flutter/app/placeholder_page.dart';
import 'package:good_news_flutter/app/screens/bookmarks_screen.dart';
import 'package:good_news_flutter/app/screens/news_open_screen.dart';
import 'package:good_news_flutter/app/screens/news_screen.dart';
import 'package:good_news_flutter/app/screens/settings_screen.dart';

typedef MaterialPageRouteBuilder = MaterialPageRoute Function(
    BuildContext context);

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

  static Map<String, MaterialPageRouteBuilder> rootBuilders = {
    paths[Path.news_root]: (context) => MaterialPageRoute(
          settings: RouteSettings(isInitialRoute: true),
          // true - appears w/out animation
          builder: rootScreenBuilders[paths[Path.news_root]],
        ),
    paths[Path.bookmarks_root]: (context) => MaterialPageRoute(
          settings: RouteSettings(isInitialRoute: true),
          builder: rootScreenBuilders[paths[Path.bookmarks_root]],
        ),
    paths[Path.settings_root]: (context) => MaterialPageRoute(
          settings: RouteSettings(isInitialRoute: true),
          builder: rootScreenBuilders[paths[Path.settings_root]],
        ),
  };

  static Map<String, WidgetBuilder> rootScreenBuilders = {
    paths[Path.news_root]: (context) => NewsScreen.create(context),
    paths[Path.bookmarks_root]: (context) => BookmarksScreen.create(context),
    paths[Path.settings_root]: (context) => SettingsScreen.create(context),
  };
}
