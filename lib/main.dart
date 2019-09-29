import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:good_news_flutter/app/data/storage_service.dart';
import 'package:good_news_flutter/app/home_page.dart';
import 'package:good_news_flutter/app/platform_specific/platform_app.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      title: 'Good News',
      iosThemeData: CupertinoThemeData(
      ),
      androidThemeData: ThemeData(
        primarySwatch: Colors.green,
        splashColor: Platform.isIOS ? Colors.transparent : null,
      ),
      home: Provider<StorageService>(
        builder: (context) => StorageService(),
        dispose: (context, value) => value.dispose(),
        child: HomePage(),
      ),
    );
  }
}
