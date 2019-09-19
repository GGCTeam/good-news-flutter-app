import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/home_page.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // TODO :: try to implement Cupertino widgets

    return MaterialApp(
      title: 'Good News',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}