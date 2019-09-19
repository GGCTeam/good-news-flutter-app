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
  final List<NewsType> types;

  factory NewsSource.fromMap(Map<String, dynamic> data) {
    if (data == null) return null;

    final String id = data["_id"];
    final String name = data["name"];
    final String imageUrl = data["image_url"];
    final List<dynamic> _types = data["types"];

    final List<NewsType> types = [];

    for (dynamic _type in _types) {
      types.add(NewsType.fromMap(_type));
    }

    return NewsSource(
      id: id,
      name: name,
      imageUrl: imageUrl,
      types: types,
    );
  }

  Map<String, dynamic> toMap() {
    final List<dynamic> types = [];

    for (NewsType type in this.types) {
      types.add(type.toMap());
    }

    return {
      "_id": id,
      "name": name,
      "image_url": imageUrl,
      "types": types,
    };
  }
}
