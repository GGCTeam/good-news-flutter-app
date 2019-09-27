import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:good_news_flutter/app/navigation/routes.dart';
import 'package:good_news_flutter/app/navigation/tab_navigator.dart';
import 'package:good_news_flutter/app/navigation/tabs.dart';
import 'package:good_news_flutter/app/platform_specific/platform_widget.dart';

class PlatformTabScaffold extends PlatformWidget {
  PlatformTabScaffold({
    Key key,
    @required this.currentTab,
    @required this.onSelectTab,
  });

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _buildItem(tabItem: TabItem.news),
          _buildItem(tabItem: TabItem.bookmarks),
          _buildItem(tabItem: TabItem.settings),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final tabItem = TabItem.values[index];

        return CupertinoTabView(
          navigatorKey: Tabs.navigatorKeys[tabItem],
          builder: Routes.rootScreenBuilders[Routes.rootPaths[tabItem]],
        );
      },
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        _buildOffstageNavigator(TabItem.news),
        _buildOffstageNavigator(TabItem.bookmarks),
        _buildOffstageNavigator(TabItem.settings),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          _buildItem(tabItem: TabItem.news),
          _buildItem(tabItem: TabItem.bookmarks),
          _buildItem(tabItem: TabItem.settings),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: currentTab != tabItem,
      child: TabNavigator(tabItem: tabItem),
    );
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem}) {
    String text = Tabs.names[tabItem];
    IconData icon = Tabs.icons[tabItem];
    Color iconColor =
        currentTab == tabItem ? Tabs.activeColors[tabItem] : Colors.grey;

    // TODO до ума довести

    return BottomNavigationBarItem(
      icon: Icon(icon, color: iconColor),
      title: Text(
        text,
        style: TextStyle(color: iconColor),
      ),
    );
  }
}
