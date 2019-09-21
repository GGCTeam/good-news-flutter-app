import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:good_news_flutter/app/data/storage_service.dart';
import 'package:good_news_flutter/app/models/News.dart';
import 'package:good_news_flutter/app/models/NewsSource.dart';
import 'package:good_news_flutter/app/models/NewsType.dart';

class SettingsScreenBloc {
  SettingsScreenBloc({
    @required this.storage,
  }) {
    storage.newsSources.stream
        .listen((newsSources) => this.updateWith(newsSources: newsSources));
  }

  final StorageService storage;

  final StreamController<List<NewsSource>> _newsSourcesController =
      StreamController<List<NewsSource>>();

  Stream<List<NewsSource>> get newsSourcesStream =>
      _newsSourcesController.stream;

  Future<void> get() async {
    try {
      await storage.newsSources.get();
    } catch (e) {
      updateWithError(error: e);
    }
  }

  void newsSourceTypeSelected(NewsSource s, NewsType t, bool selected) async {
    storage.newsSources.typeSelected(s, t, selected);
    storage.news.filterWith(await storage.newsSources.getFromLocalStorage());
  }

  void updateWith({
    List<NewsSource> newsSources,
  }) {
    _newsSourcesController.add(newsSources);
  }

  void updateWithError({
    Object error,
  }) {
    _newsSourcesController.addError(error);
  }

  void dispose() {
    _newsSourcesController.close();
  }
}
