import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/models/NewsType.dart';

class NewsSource {
  NewsSource({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.types,
  });

  final String id;
  final String name;
  final String imageUrl;
  List<NewsType> types;

  factory NewsSource.fromMap(Map<String, dynamic> data) {
    if (data == null) return null;

    final String id = data["_id"];
    final String name = data["name"];
    final String imageUrl = data["image_url"];
    final List<dynamic> _types = data["types"];

    final List<NewsType> types = _types.map((t) => NewsType.fromMap(t)).toList();

    return NewsSource(
      id: id,
      name: name,
      imageUrl: imageUrl,
      types: types,
    );
  }

  Map<String, dynamic> toMap() {
    final List<dynamic> _types = types.map((t) => t.toMap()).toList();

    return {
      "_id": id,
      "name": name,
      "image_url": imageUrl,
      "types": _types,
    };
  }
}
