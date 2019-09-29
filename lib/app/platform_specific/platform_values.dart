import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformValues {
  PlatformValues._();

  // static Color splashColor = Platform.isIOS ? Colors.transparent : null;

  static PageRoute platformPageRoute({bool isInitialRoute, WidgetBuilder builder}) {
//    if (Platform.isIOS) {
//      return CupertinoPageRoute(
//        settings: RouteSettings(
//          isInitialRoute: isInitialRoute,
//        ),
//        builder: builder,
//      );
//    }

    return MaterialPageRoute(
      settings: RouteSettings(
        isInitialRoute: isInitialRoute,
      ),
      builder: builder,
    );
  }
}