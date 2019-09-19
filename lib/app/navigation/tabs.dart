
import 'package:flutter/material.dart';

enum TabItem { news, favorites, settings }

class Tabs {
  static TabItem initTab = TabItem.news;

  static Map<TabItem, String> names = {
    TabItem.news: 'News',
    TabItem.favorites: 'Favorites',
    TabItem.settings: 'Settings',
  };

  static Map<TabItem, MaterialColor> activeColors = {
    TabItem.news: Colors.green,
    TabItem.favorites: Colors.green,
    TabItem.settings: Colors.green,
  };

  static Map<TabItem, IconData> icons = {
    TabItem.news: Icons.view_list,
    TabItem.favorites: Icons.star,
    TabItem.settings: Icons.settings,
  };

  static Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.news: GlobalKey<NavigatorState>(),
    TabItem.favorites: GlobalKey<NavigatorState>(),
    TabItem.settings: GlobalKey<NavigatorState>(),
  };
}