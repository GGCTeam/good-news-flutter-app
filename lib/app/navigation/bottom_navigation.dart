import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/navigation/tabs.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({@required this.currentTab, @required this.onSelectTab});

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(tabItem: TabItem.news),
        _buildItem(tabItem: TabItem.favorites),
        _buildItem(tabItem: TabItem.settings),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem}) {
    String text = Tabs.names[tabItem];
    IconData icon = Tabs.icons[tabItem];
    Color iconColor =
        currentTab == tabItem ? Tabs.activeColors[tabItem] : Colors.grey;

    return BottomNavigationBarItem(
      icon: Icon(icon, color: iconColor),
      title: Text(
        text,
        style: TextStyle(color: iconColor),
      ),
    );
  }
}
