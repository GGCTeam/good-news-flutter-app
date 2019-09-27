import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/blocs/news_screen_bloc.dart';
import 'package:good_news_flutter/app/common/news_list_item.dart';
import 'package:good_news_flutter/app/data/storage_service.dart';
import 'package:good_news_flutter/app/models/News.dart';
import 'package:good_news_flutter/app/platform_specific/platform_list_items_builder.dart';
import 'package:good_news_flutter/app/platform_specific/platform_page_scaffold.dart';
import 'package:good_news_flutter/app/screens/news_open_screen.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'dart:async';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key key, this.bloc}) : super(key: key);

  final NewsScreenBloc bloc;

  static Widget create(BuildContext context) {
    final storage = Provider.of<StorageService>(context);

    return Provider<NewsScreenBloc>(
      builder: (context) => NewsScreenBloc(storage: storage),
      child: Consumer<NewsScreenBloc>(
        builder: (context, bloc, _) => NewsScreen(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    widget.bloc.get();

    super.initState();
  }

  Future<Null> _refresh() async {
    return await widget.bloc.get();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformPageScaffold(
      title: 'News',
      onRefresh: _refresh,
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    return StreamBuilder<List<News>>(
      stream: widget.bloc.newsStream,
      builder: (context, snapshot) {
        return PlatformListItemsBuilder(
          snapshot: snapshot,
          itemBuilder: (context, news, lastItem) => NewsListItem(
            model: news,
            lastItem: lastItem,
            onTap: (news) {
              Navigator.push(
                context,
                NewsOpenScreen.pageRoute(context, news, 'News'),
              );
            },
            onBookmarkTap: (news) => widget.bloc.addToBookmarks(news),
            onShareTap: (news) => Share.share(news.link),
          ),
          onRefreshData: widget.bloc.get,
        );
      },
    );
  }
}
