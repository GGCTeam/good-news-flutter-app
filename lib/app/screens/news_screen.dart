import 'dart:io';
import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/blocs/news_screen_bloc.dart';
import 'package:good_news_flutter/app/common/list_items_builder.dart';
import 'package:good_news_flutter/app/models/News.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key key, this.bloc}) : super(key: key);

  final NewsScreenBloc bloc;

  static Widget create(BuildContext context) {
    return Provider<NewsScreenBloc>(
      builder: (context) => NewsScreenBloc(),
      child: Consumer<NewsScreenBloc>(
        builder: (context, bloc, _) => NewsScreen(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  Future<void> _refresh() async {
    return await bloc.get();
    // return await Future<Null>.value(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        elevation: Platform.isIOS ? 0 : 4,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: bloc.get,
          )
        ],
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    return StreamBuilder<List<News>>(
      stream: bloc.newsStream,
      builder: (context, snapshot) {
        return ListItemsBuilder<News>(
          snapshot: snapshot,
          itemBuilder: (context, news) => ListTile(
            title: Text(news.title),
          ),
          onLoadData: bloc.get,
        );
      },
    );
  }
}
