import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/navigation/routes.dart';
import 'package:good_news_flutter/app/navigation/tabs.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({@required this.tabItem});

  final TabItem tabItem;

  @override
  Widget build(BuildContext context) {
    print("${Routes.rootPaths[tabItem]} -- ${Tabs.navigatorKeys[tabItem]}");
    return Navigator(
      key: Tabs.navigatorKeys[tabItem],
      initialRoute: Routes.rootPaths[tabItem],
      onGenerateRoute: (routeSettings) {

        print(routeSettings.name);
        print(routeSettings.isInitialRoute);

        return MaterialPageRoute(
          settings: RouteSettings(
            // is used to disable animation when first News screen is appeared.
            isInitialRoute: Routes.rootPaths.values.contains(routeSettings.name),
          ),
          builder: (context) => Routes.builders[routeSettings.name](context),
        );
      },
    );
  }
}
