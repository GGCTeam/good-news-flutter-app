import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/navigation/routes.dart';
import 'package:good_news_flutter/app/navigation/tabs.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({@required this.tabItem});

  final TabItem tabItem;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Tabs.navigatorKeys[tabItem],
      initialRoute: Routes.rootPaths[tabItem],
      onGenerateRoute: (routeSettings) => Routes.builders[routeSettings.name](context, null),
    );
  }
}
