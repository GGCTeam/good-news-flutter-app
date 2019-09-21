import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/data/storage_service.dart';
import 'package:good_news_flutter/app/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // TODO :: try to implement Cupertino widgets
    print("\n\n\n SUPER BUILD \n\n\n");
    return MaterialApp(
      title: 'Good News',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: Provider<StorageService>(
        builder: (context) => StorageService(),
        dispose: (context, value) => value.dispose(),
        child: HomePage(),
      ),
    );
  }
}
/*

MultiProvider(
        providers: [
          Provider<StorageService>.value(value: StorageService()),
        ],
        child: HomePage(),
      ),

* */