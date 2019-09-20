import 'dart:io';
import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/blocs/news_screen_bloc.dart';
import 'package:good_news_flutter/app/common/list_items_builder.dart';
import 'package:good_news_flutter/app/common/news_list_item.dart';
import 'package:good_news_flutter/app/models/News.dart';
import 'package:good_news_flutter/app/navigation/routes.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

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

  Future<Null> _refresh() async {
    return await bloc.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        elevation: Platform.isIOS ? 0 : 4,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: _buildContents(context),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    return StreamBuilder<List<News>>(
      stream: bloc.newsStream,
      builder: (context, snapshot) {
        return ListItemsBuilder<News>(
          snapshot: snapshot,
          itemBuilder: (context, news) => NewsListItem(
            model: news,
            onTap: (news) {
              Navigator.push(
                context,
                Routes.builders[Routes.paths[Path.news_open]](
                  context,
                  news,
                ),
              );
            }, // TODO
            onBookmarkTap: (news) => print(news.title), // TODO
            onShareTap: (news) => Share.share(news.link),
          ),
          onLoadData: bloc.get,
        );
      },
    );
  }
}
