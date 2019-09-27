
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { news, bookmarks, settings }

class Tabs {
  static TabItem initTab = TabItem.news;

  static Map<TabItem, String> names = {
    TabItem.news: 'News',
    TabItem.bookmarks: 'Bookmarks',
    TabItem.settings: 'Settings',
  };

  static Map<TabItem, MaterialColor> activeColors = {
    TabItem.news: Colors.blue,
    TabItem.bookmarks: Colors.blue,
    TabItem.settings: Colors.blue,
  };

  static Map<TabItem, IconData> icons = {
    TabItem.news: Platform.isIOS ? CupertinoIcons.home : Icons.view_list,
    TabItem.bookmarks: Platform.isIOS ? CupertinoIcons.bookmark : Icons.star,
    TabItem.settings: Platform.isIOS ? CupertinoIcons.settings : Icons.settings,
  };

  static Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.news: GlobalKey<NavigatorState>(),
    TabItem.bookmarks: GlobalKey<NavigatorState>(),
    TabItem.settings: GlobalKey<NavigatorState>(),
  };
}