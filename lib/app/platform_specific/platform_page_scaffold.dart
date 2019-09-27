import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:good_news_flutter/app/platform_specific/platform_widget.dart';

class PlatformPageScaffold extends PlatformWidget {
  PlatformPageScaffold({
    this.title,
    this.previousPageTitle,
    this.isSliverForIOS = false,
    this.onRefresh,
    this.body,
    this.actionsIOS,
    this.actionsAndroid,
  });

  final String title;
  final String previousPageTitle; // optional
  final bool isSliverForIOS;
  final VoidCallback onRefresh; // only should be presented if isSliver == true
  final Widget body;
  final List<Widget> actionsIOS;
  final List<Widget> actionsAndroid;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    if (!isSliverForIOS) {
      return Material(
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            previousPageTitle: previousPageTitle,
            middle: Text(title),
            trailing: _trailingActionsIOS(),
          ),
          child: body,
        ),
      );
    }

    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          previousPageTitle: previousPageTitle,
          largeTitle: Text(title),
          trailing: _trailingActionsIOS(),
        ),
        if (onRefresh != null)
          CupertinoSliverRefreshControl(onRefresh: onRefresh),
        SliverPadding(
          padding: MediaQuery.of(context)
              .removePadding(
                removeTop: true,
                removeLeft: true,
                removeRight: true,
              )
              .padding,
          sliver: body,
        ),
      ],
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actionsAndroid,
      ),
      body: onRefresh != null
          ? RefreshIndicator(
              onRefresh: onRefresh,
              child: body,
            )
          : body,
    );
  }

  Widget _trailingActionsIOS() {
    return actionsIOS == null
        ? null
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: actionsIOS,
          );
  }
}
