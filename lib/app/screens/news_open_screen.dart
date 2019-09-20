import 'dart:io';
import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/models/News.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsOpenScreen extends StatelessWidget {
  const NewsOpenScreen({
    Key key,
    @required this.model,
  }) : super(key: key);

  final News model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.newsSource.name),
        elevation: Platform.isIOS ? 0 : 4,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.star_border),
            onPressed: () {},
          )
        ],
      ),
      body: _buildContents(),
    );
  }

  Widget _buildContents() {
    return WebView(
      initialUrl: model.link,
    );
  }
}