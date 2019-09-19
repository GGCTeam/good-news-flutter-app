import 'package:flutter/material.dart';

class NewsType {
  NewsType({
    @required this.id,
    @required this.type,
    @required this.name,
  });

  final String id;
  final String type;
  final String name;

  factory NewsType.fromMap(Map<String, dynamic> data) {
    if (data == null) return null;

    final String id = data["_id"];
    final String type = data["type"];
    final String name = data["name"];

    return NewsType(
      id: id,
      type: type,
      name: name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "type": type,
      "name": name,
    };
  }
}
