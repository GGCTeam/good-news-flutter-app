import 'package:flutter/material.dart';

class NewsType {
  NewsType({
    @required this.id,
    @required this.type,
    @required this.name,
    @required this.selected,
  });

  final String id;
  final String type;
  final String name;
  bool selected;

  factory NewsType.fromMap(Map<String, dynamic> data) {
    if (data == null) return null;

    final String id = data["_id"];
    final String type = data["type"];
    final String name = data["name"];
    final bool selected = data["selected"] ?? true;

    return NewsType(
      id: id,
      type: type,
      name: name,
      selected: selected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "type": type,
      "name": name,
      "selected": selected,
    };
  }
}
