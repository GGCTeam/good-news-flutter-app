import 'package:dio/dio.dart';
import 'package:good_news_flutter/app/data/constants.dart';
import 'package:good_news_flutter/app/models/News.dart';
import 'package:good_news_flutter/app/models/NewsSource.dart';
import 'package:good_news_flutter/app/models/NewsType.dart';

// NOTE: might be better to separate this class to different classes
class ApiService {
  Future<List<News>> getNews() async {
    Response<List<dynamic>> resp = await Dio()
        .get<List<dynamic>>("${Constants.baseUrl}/v1/news/");

    return resp.data.map((n) => News.fromMap(n)).toList();
  }

  Future<List<NewsSource>> getNewsSources() async {
    Response<List<dynamic>> resp = await Dio()
        .get<List<dynamic>>("${Constants.baseUrl}/v1/news/sources");

    return resp.data.map((n) => NewsSource.fromMap(n)).toList();
  }

  Future<List<NewsType>> getNewsTypes() async {
    Response<List<dynamic>> resp = await Dio()
        .get<List<dynamic>>("${Constants.baseUrl}/v1/news/types");

    return resp.data.map((n) => NewsType.fromMap(n)).toList();
  }
}
