import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:good_news_flutter/app/platform_specific/platform_widget.dart';

class PlatformApp extends PlatformWidget {
  PlatformApp({
    this.title,
    this.androidThemeData,
    this.iosThemeData,
    this.home,
  });

  final String title;
  final ThemeData androidThemeData;
  final CupertinoThemeData iosThemeData;
  final Widget home;

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: androidThemeData,
      home: home,
    );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: androidThemeData,
      home: home,
    );

    return CupertinoApp(
      title: title,
      theme: iosThemeData,
      home: home,
    );
  }
}
