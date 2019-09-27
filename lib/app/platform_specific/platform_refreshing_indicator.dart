import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/platform_specific/platform_widget.dart';

class PlatformRefreshingIndicator extends PlatformWidget {
  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoActivityIndicator(
      animating: true,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return CircularProgressIndicator();
  }
}
