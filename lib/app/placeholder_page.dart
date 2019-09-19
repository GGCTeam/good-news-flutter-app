import 'dart:io';
import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/navigation/routes.dart';

class PlaceholderPage extends StatefulWidget {
  PlaceholderPage(this.msg);

  final String msg;

  @override
  _PlaceholderPageState createState() => _PlaceholderPageState();
}

class _PlaceholderPageState extends State<PlaceholderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.msg),
        elevation: Platform.isIOS ? 0 : 8,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.msg),
            FlatButton(
              child: Text('Go to /news/open'),
              color: Colors.green,
              onPressed: () {
                 Navigator.of(context).pushNamed(Routes.paths[Path.news_open]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
