
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
    TabItem.news: Colors.green,
    TabItem.bookmarks: Colors.green,
    TabItem.settings: Colors.green,
  };

  static Map<TabItem, IconData> icons = {
    TabItem.news: Icons.view_list,
    TabItem.bookmarks: Icons.star,
    TabItem.settings: Icons.settings,
  };

  static Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.news: GlobalKey<NavigatorState>(),
    TabItem.bookmarks: GlobalKey<NavigatorState>(),
    TabItem.settings: GlobalKey<NavigatorState>(),
  };
}