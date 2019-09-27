import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/blocs/news_open_bloc.dart';
import 'package:good_news_flutter/app/data/storage_service.dart';
import 'package:good_news_flutter/app/platform_specific/platform_page_scaffold.dart';
import 'package:good_news_flutter/app/platform_specific/platform_refreshing_indicator.dart';
import 'package:good_news_flutter/app/platform_specific/platform_values.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:good_news_flutter/app/models/News.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsOpenScreen extends StatefulWidget {
  const NewsOpenScreen({
    Key key,
    @required this.bloc,
    @required this.model,
    this.previousPageTitle = '',
  }) : super(key: key);

  final NewsOpenBloc bloc;
  final News model;
  final String previousPageTitle;

  static Widget create(
      BuildContext context, News news, String previousPageTitle) {
    final storage = Provider.of<StorageService>(context);

    return Provider<NewsOpenBloc>(
      builder: (context) => NewsOpenBloc(storage: storage, news: news),
      child: Consumer<NewsOpenBloc>(
        builder: (context, bloc, _) => NewsOpenScreen(
          bloc: bloc,
          model: news,
          previousPageTitle: previousPageTitle,
        ),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  static PageRoute pageRoute(BuildContext context, News news, String previousPageTitle) {
    return PlatformValues.platformPageRoute(
      isInitialRoute: false,
      builder: (context) => NewsOpenScreen.create(context, news, previousPageTitle),
    );
  }

  @override
  _NewsOpenScreenState createState() => _NewsOpenScreenState();
}

class _NewsOpenScreenState extends State<NewsOpenScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    widget.bloc.checkIfBookmarked(widget.model);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformPageScaffold(
      title: widget.model.newsSource.name,
      previousPageTitle: widget.previousPageTitle,
      actionsIOS: <Widget>[
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.share),
          onPressed: () => Share.share(widget.model.link),
        ),
        StreamBuilder(
          stream: widget.bloc.stream,
          builder: (builder, snapshot) {
            if (snapshot.hasData) {
              bool isBookmarked = snapshot.data;

              return CupertinoButton(
                padding: EdgeInsets.zero,
                child: isBookmarked
                    ? Icon(CupertinoIcons.bookmark_solid)
                    : Icon(CupertinoIcons.bookmark),
                onPressed: isBookmarked
                    ? () => widget.bloc.removeFromBookmarks(widget.model)
                    : () => widget.bloc.addToBookmarks(widget.model),
              );
            }

            return CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(CupertinoIcons.bookmark),
              onPressed: () {},
            );
          },
        ),
      ],
      actionsAndroid: <Widget>[
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () => Share.share(widget.model.link),
        ),
        StreamBuilder(
          stream: widget.bloc.stream,
          builder: (builder, snapshot) {
            if (snapshot.hasData) {
              bool isBookmarked = snapshot.data;

              return IconButton(
                icon: isBookmarked ? Icon(Icons.star) : Icon(Icons.star_border),
                onPressed: isBookmarked
                    ? () => widget.bloc.removeFromBookmarks(widget.model)
                    : () => widget.bloc.addToBookmarks(widget.model),
              );
            }

            return IconButton(
              icon: Icon(Icons.star_border),
              onPressed: () {},
            );
          },
        ),
      ],
      body: _buildContents(),
    );
  }

  Widget _buildContents() {
    return SafeArea(
      child: Center(
        // this is done to wait till a page will be presented
        // and then start showing WebView, otherwise it would cause lags
        child: FutureBuilder(
          future: widget.bloc.webViewFuture,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return PlatformRefreshingIndicator();
              case ConnectionState.done:
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');

                return Builder(builder: (BuildContext context) {
                  return WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: widget.model.link,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                  );
                });
            }
            return null;
          },
        ),
      ),
    );
  }
}
