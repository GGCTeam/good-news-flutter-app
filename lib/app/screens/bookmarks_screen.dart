import 'dart:io';
import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/blocs/bookmarks_screen_bloc.dart';
import 'package:good_news_flutter/app/common/list_items_builder.dart';
import 'package:good_news_flutter/app/common/news_list_item.dart';
import 'package:good_news_flutter/app/data/storage_service.dart';
import 'package:good_news_flutter/app/models/News.dart';
import 'package:good_news_flutter/app/navigation/routes.dart';
import 'package:good_news_flutter/app/screens/news_open_screen.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({Key key, this.bloc}) : super(key: key);

  final BookmarksScreenBloc bloc;

  static Widget create(BuildContext context) {
    final storage = Provider.of<StorageService>(context);

    return Provider<BookmarksScreenBloc>(
      builder: (context) => BookmarksScreenBloc(storage: storage),
      child: Consumer<BookmarksScreenBloc>(
        builder: (context, bloc, _) => BookmarksScreen(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  _BookmarksScreenState createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  void initState() {
    widget.bloc.get();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
        elevation: Platform.isIOS ? 0 : 4,
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    return StreamBuilder<List<News>>(
      stream: widget.bloc.bookmarksStream,
      builder: (context, snapshot) {
        return ListItemsBuilder<News>(
          snapshot: snapshot,
          itemBuilder: (context, news) => NewsListItem(
            model: news,
            onTap: (news) {
              Navigator.push(
                context,
                NewsOpenScreen.pageRoute(context, news),
              );
            },
            onBookmarkTap: (news) => widget.bloc.removeFromBookmarks(news),
            isBookmarked: true,
            onShareTap: (news) => Share.share(news.link),
          ),
        );
      },
    );
  }
}
