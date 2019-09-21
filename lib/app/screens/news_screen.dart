import 'dart:io';
import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/blocs/news_screen_bloc.dart';
import 'package:good_news_flutter/app/common/list_items_builder.dart';
import 'package:good_news_flutter/app/common/news_list_item.dart';
import 'package:good_news_flutter/app/data/storage_service.dart';
import 'package:good_news_flutter/app/models/News.dart';
import 'package:good_news_flutter/app/navigation/routes.dart';
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
    print("_build");

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
    print("_buildContents");
    return StreamBuilder<List<News>>(
      stream: widget.bloc.newsStream,
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
