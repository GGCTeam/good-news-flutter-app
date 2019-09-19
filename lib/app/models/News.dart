import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/models/NewsSource.dart';
import 'package:good_news_flutter/app/models/NewsType.dart';

class News {
  News({
    @required this.id,
    @required this.title,
    @required this.preamble,
    @required this.link,
    @required this.timeAdded,
    @required this.newsType,
    @required this.newsSource,
  });

  final String id;
  final String title;
  final String preamble;
  final String link;
  final int timeAdded;
  final NewsType newsType;
  final NewsSource newsSource;

  factory News.fromMap(Map<String, dynamic> data) {
    if (data == null) return null;

    final String id = data["_id"];
    final String title = data["title"];
    final String preamble = data["preamble"];
    final String link = data["link"];
    final int timeAdded = data["time_added"];
    final NewsType newsType = NewsType.fromMap(data["news_type"]);
    final NewsSource newsSource = NewsSource.fromMap(data["news_source"]);

    return News(
      id: id,
      title: title,
      preamble: preamble,
      link: link,
      timeAdded: timeAdded,
      newsType: newsType,
      newsSource: newsSource,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "title": title,
      "preamble": preamble,
      "link": link,
      "time_added": timeAdded,
      "news_type": newsType.toMap(),
      "news_source": newsSource.toMap(),
    };
  }
}
