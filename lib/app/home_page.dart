import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/navigation/tab_navigator.dart';
import 'package:good_news_flutter/app/platform_specific/platform_tab_scaffold.dart';

import 'navigation/bottom_navigation.dart';
import 'navigation/tabs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = Tabs.initTab;

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      Tabs.navigatorKeys[tabItem].currentState
          .popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await Tabs.navigatorKeys[_currentTab].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != Tabs.initTab) {
            // select 'main' tab
            _selectTab(Tabs.initTab);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: PlatformTabScaffold(
        currentTab: _currentTab,
        onSelectTab: _selectTab,
      ),
    );
  }
}
